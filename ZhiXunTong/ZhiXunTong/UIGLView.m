//
//  ALMoviePlayerControls.m
//  ALMoviePlayerController
//
//  Created by Anthony Lobianco on 10/8/13.
//  Copyright (c) 2013 Anthony Lobianco. All rights reserved.
//
#import "UIGLView.h"
#import <tgmath.h>
#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/EAGL.h>

@interface UIGLView() {

@private
#pragma mark custom
    /**
     OpenGL绘图上下文
     */
    EAGLContext             *_glContext;
    
    /**
     帧缓冲区
     */
    GLuint                  _framebuffer;
    
    /**
     渲染缓冲区
     */
    GLuint                  _renderBuffer;
    
    /**
     着色器句柄
     */
    GLuint                  _program;
    
    /**
     YUV纹理数组
     */
    GLuint                  _textureYUV[4];
    
    /**
     视频宽度
     */
    GLuint                  _videoW;
    
    /**
     视频高度
     */
    GLuint                  _videoH;
    
    GLint                   _uniformMatrix;
    GLint                   _uniform1i[3];
    GLint                   _uniform1i_nv12[2];
    
    GLint                   _backingWidth;
    GLint                   _backingHeight;
    
    GLfloat                 _vertices[8];
    
    int _videoLinesize;
}
@end

@implementation UIGLView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(self)
        {
            [EAGLContext setCurrentContext:_glContext];
            [self destoryFrameAndRenderBuffer];
            [self createFrameAndRenderBuffer];
        }
        
        glViewport(0, 0, _backingWidth, _backingHeight);
    });
}

# pragma mark mediaSDK

enum AttribEnum {
    ATTRIB_VERTEX,
    ATTRIB_TEXTURE,
    ATTRIB_COLOR,
};

enum TextureType {
    TEXY = 0,
    TEXU,
    TEXV,
    TEXUV,
    TEXC
};

//- (void)debugGlError
//{
//    GLenum r = glGetError();
//    if (r != 0)
//    {
//        printf("%d   \n", r);
//    }
//}
- (BOOL)initOpenGLES {
    //printf("%s\n", __FUNCTION__);
    CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
    eaglLayer.opaque = YES;
    eaglLayer.drawableProperties =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithBool:NO],
     kEAGLDrawablePropertyRetainedBacking,
     kEAGLColorFormatRGBA8,
     kEAGLDrawablePropertyColorFormat,
     nil];
    
    _glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //[self debugGlError];
    
    if(!_glContext || ![EAGLContext setCurrentContext:_glContext]) {
        return NO;
    }
    
    memset(_textureYUV, 0, sizeof(GLuint) * TEXC);
    
    [self setupYUVTexture];
    [self loadShader];
    
    glUseProgram(_program);
    
    return YES;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        NSLog(@"initWithFrame self.contentScaleFactor %f", self.contentScaleFactor);
        if (![self initOpenGLES]) {
            self = nil;
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        NSLog(@"initWithCoder self.contentScaleFactor %f", self.contentScaleFactor);
        
        if (![self initOpenGLES]) {
            self = nil;
        }
    }
    return self;
}

- (void)setupYUVTexture {
    if (_textureYUV[TEXY]) {
        glDeleteTextures(TEXC, _textureYUV);
    }
    
    glGenTextures(TEXC, _textureYUV);
    if (!_textureYUV[TEXY] || !_textureYUV[TEXU] || !_textureYUV[TEXV] || !_textureYUV[TEXUV]) {
        NSLog(@"<<<<<<<<<<<<纹理创建失败!>>>>>>>>>>>>");
        return;
    }
}

#pragma mark - 设置openGL
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (BOOL)createFrameAndRenderBuffer {
    glGenFramebuffers(1, &_framebuffer);
    glGenRenderbuffers(1, &_renderBuffer);
    
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    
    
    if (![_glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer]) {
        NSLog(@"attach渲染缓冲区失败");
    }
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_backingHeight);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffer);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"创建缓冲区错误 0x%x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }
    return YES;
}

- (void)destoryFrameAndRenderBuffer {
    if (_framebuffer) {
        glDeleteFramebuffers(1, &_framebuffer);
    }
    
    if (_renderBuffer) {
        glDeleteRenderbuffers(1, &_renderBuffer);
    }
    
    _framebuffer = 0;
    _renderBuffer = 0;
}

#define FSH @"\
varying highp vec2 TexCoordOut;\
uniform sampler2D SamplerY;\
uniform sampler2D SamplerU;\
uniform sampler2D SamplerV;\
uniform sampler2D SamplerUV;\
uniform int yuvType;\
void main()\
{\
mediump mat3 yuv2rgb = mat3(vec3(1, 1, 1), vec3(0, -0.344, 1.772), vec3(1.402, -0.714, 0));\
mediump vec3 yuv;\
lowp vec3 rgb;\
if (yuvType == 1) {\
yuv.x = texture2D(SamplerY, TexCoordOut).r;\
yuv.yz = texture2D(SamplerUV, TexCoordOut).ra - 0.5;\
} else {\
yuv.x = texture2D(SamplerY, TexCoordOut).r;\
yuv.y = texture2D(SamplerU, TexCoordOut).r - 0.5;\
yuv.z = texture2D(SamplerV, TexCoordOut).r - 0.5;\
}\
rgb = yuv2rgb * yuv;\
gl_FragColor = vec4(rgb, 1.0);\
}"
/*
 highp float r = yuv.x +             1.402 * yuv.z;\
 highp float g = yuv.x - 0.344 * yuv.y - 0.714 * yuv.z;\
 highp float b = yuv.x + 1.772 * yuv.y;\
 */

#define VSH @"\
attribute vec4 position;\
attribute vec2 TexCoordIn;\
uniform mat4 uniformMatrix;\
varying vec2 TexCoordOut;\
\
void main()\
{\
gl_Position = uniformMatrix * position;\
TexCoordOut = TexCoordIn;\
}"

/**
 加载着色器
 */
- (void)loadShader {
    _program = glCreateProgram();
    
    // 1
    GLuint vertexShader = [self compileShader:VSH withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:FSH withType:GL_FRAGMENT_SHADER];
    
    // 2
    glAttachShader(_program, vertexShader);
    glAttachShader(_program, fragmentShader);
    
    // 绑定需要在link之前
    glBindAttribLocation(_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(_program, ATTRIB_TEXTURE, "TexCoordIn");
    
    glLinkProgram(_program);
    
    // 3
    GLint linkSuccess;
    glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"<<<<着色器连接失败 %@>>>", messageString);
        //exit(1);
    }
    
    _uniformMatrix = glGetUniformLocation(_program, "uniformMatrix");
    
    const char* uniform1i_name[3] = {
        "SamplerY",
        "SamplerU",
        "SamplerV"
    };
    for (int i = 0; i < 3; i++) {
        _uniform1i[i] = glGetUniformLocation(_program, uniform1i_name[i]);
    }
    
    const char* uniform1i_name_nv12[2] = {
        "SamplerY",
        "SamplerUV",
    };
    for (int i = 0; i < 2; i++) {
        _uniform1i_nv12[i] = glGetUniformLocation(_program, uniform1i_name_nv12[i]);
    }
    
    if (vertexShader)
        glDeleteShader(vertexShader);
    if (fragmentShader)
        glDeleteShader(fragmentShader);
}

- (GLuint)compileShader:(NSString*)shaderString withType:(GLenum)shaderType {
   	// 1
    if (!shaderString) {
        //NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    else
    {
        //NSLog(@"shader code-->%@", shaderString);
    }
    
    // 2
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // 3
    const char * shaderStringUTF8 = [shaderString UTF8String];
    GLint shaderStringLength = (GLint)[shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // 4
    glCompileShader(shaderHandle);
    
    // 5
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (void)displayYUV420pData:(void *)data width:(int)w height:(int)h {
    [self displayYUV420pData:data :(data + w * h) :(data + w * h * 5 / 4) :w :h :w];
}

static void mat4f_LoadOrtho(float left, float right, float bottom, float top, float near, float far, float* mout)
{
    float r_l = right - left;
    float t_b = top - bottom;
    float f_n = far - near;
    float tx = - (right + left) / (right - left);
    float ty = - (top + bottom) / (top - bottom);
    float tz = - (far + near) / (far - near);
    
    mout[0] = 2.0f / r_l;
    mout[1] = 0.0f;
    mout[2] = 0.0f;
    mout[3] = 0.0f;
    
    mout[4] = 0.0f;
    mout[5] = 2.0f / t_b;
    mout[6] = 0.0f;
    mout[7] = 0.0f;
    
    mout[8] = 0.0f;
    mout[9] = 0.0f;
    mout[10] = -2.0f / f_n;
    mout[11] = 0.0f;
    
    mout[12] = tx;
    mout[13] = ty;
    mout[14] = tz;
    mout[15] = 1.0f;
}

- (void)updateVertices
{
    const BOOL fit      = !(self.contentMode == UIViewContentModeScaleAspectFit);
    const float width   = _videoW;
    const float height  = _videoH;
    const float linesize= _videoLinesize;
    const float dW      = (float)_backingWidth	/ _videoW;
    const float dH      = (float)_backingHeight / height;
    const float dd      = fit ? MIN(dH, dW) : MAX(dH, dW);
    const float wl      = (width  * dd / (float)_backingWidth );
    const float wr      = (linesize  * dd / (float)_backingWidth );
    const float h       = (height * dd / (float)_backingHeight);
    
    _vertices[0] = - wl;
    _vertices[1] = - h;
    _vertices[2] =   wl + 2 * (wr - wl) / wr;
    _vertices[3] = - h;
    _vertices[4] = - wl;
    _vertices[5] =   h;
    _vertices[6] =   wl + 2 * (wr - wl) / wr;
    _vertices[7] =   h;
}

- (void)displayYUV420pData:(void *)y :(void *)u :(void *)v :(NSInteger)w :(NSInteger)h :(NSInteger)linesize {
    [self displayYUV420pData:y :u :v :w :h :linesize :0];
}

- (void)displayYUV420pData:(void *)y :(void *)u :(void *)v :(NSInteger)w :(NSInteger)h :(NSInteger)linesize :(NSInteger)yuvType {
    @synchronized(self) {
        if (0 == _backingWidth || 0 == _backingHeight) {
            return;
        }
        
        //GLint _bW, _bH;
        //glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_bW);
        //glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_bH);
        //printf("%s %d %d\n", __FUNCTION__, _bW, _bH);
        
        if (w != _videoW || h != _videoH || linesize != _videoLinesize
            /*|| _backingWidth != _bW || _backingHeight != _bH*/) {
            
            _videoW = w;
            _videoH = h;
            _videoLinesize = linesize;
            
            //_backingWidth = _bW;
            //_backingHeight = _bH;
            
            [self updateVertices];
        }
        
        [EAGLContext setCurrentContext:_glContext];
        
        glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
        glViewport(0, 0, _backingWidth, _backingHeight);
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(_program);
        
        glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
        
        const char* yuv[3] = {
            y,
            u,
            v,
        };
        int width[3] = {
            linesize,
            linesize >> 1,
            linesize >> 1,
        };
        int height[3] = {
            h,
            h >> 1,
            h >> 1,
        };
        
        GLint yuvTypeLocation = glGetUniformLocation(_program, "yuvType");
        glUniform1i(yuvTypeLocation, yuvType);
        
        if (yuvType == 1) {
            for (int i = 0; i < 2; i++) {
                glActiveTexture(GL_TEXTURE0 + i);
                glBindTexture(GL_TEXTURE_2D, _textureYUV[i == 0 ? 0 : TEXUV]);
                
                glTexImage2D(GL_TEXTURE_2D, 0,
                             i == 0 ? GL_LUMINANCE : GL_LUMINANCE_ALPHA,
                             width[i], height[i], 0,
                             i == 0 ? GL_LUMINANCE : GL_LUMINANCE_ALPHA,
                             GL_UNSIGNED_BYTE, yuv[i]);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
                
                glUniform1i(_uniform1i_nv12[i], i);
            }
        } else {
            for (int i = 0; i < 3; i++) {
                glActiveTexture(GL_TEXTURE0 + i);
                glBindTexture(GL_TEXTURE_2D, _textureYUV[i]);
                
                glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, width[i], height[i], 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, yuv[i]);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
                glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
                
                glUniform1i(_uniform1i[i], i);
            }
        }
        
        static const GLfloat coordVertices[] = {
            0.0f, 1.0f,
            1.0f, 1.0f,
            0.0f, 0.0f,
            1.0f, 0.0f,
        };
        
        GLfloat modelviewProj[16];
        mat4f_LoadOrtho(-1.0f, 1.0f, -1.0f, 1.0f, -1.0f, 1.0f, modelviewProj);
        glUniformMatrix4fv(_uniformMatrix, 1, GL_FALSE, modelviewProj);
        
        // Update attribute values
        glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, /*squareVertices*/_vertices);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        
        glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, 0, 0, coordVertices);
        glEnableVertexAttribArray(ATTRIB_TEXTURE);
        
        // Draw
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        
        glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
        [_glContext presentRenderbuffer:GL_RENDERBUFFER];
    }
}

- (void)clearFrame {
    NSLog(@"%s", __FUNCTION__);
    @synchronized(self) {
        if ([self window]) {
            [EAGLContext setCurrentContext:_glContext];
            glClearColor(0.0, 0.0, 0.0, 1.0);
            glClear(GL_COLOR_BUFFER_BIT);
            glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
            [_glContext presentRenderbuffer:GL_RENDERBUFFER];
        }
    }
}

@end
