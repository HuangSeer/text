//
//  VoiceController.h
//  AnDianBao
//
//  Created by yangfan on 6/11/15.
//  Copyright (c) 2015 jistsonx. All rights reserved.
//

#ifndef AnDianBao_VoiceController_h
#define AnDianBao_VoiceController_h

@protocol VoiceController <NSObject>

-(BOOL)startVoiceTalk:(NSString*)ip Port:(int)port Ssrc:(int)ssrc;
-(BOOL)stopVoiceTalk;

-(NSMutableArray*)getCodecInst;

#ifdef USE_WEBRTC
-(NSString*)startVoiceTalkForPlay;
-(NSString*)stopVoiceTalkForPlay;
-(int)getSsrc;
-(BOOL)isRunning;
#endif

@end

@interface VoiceController : NSObject
+(id<VoiceController>)voiceController;
@end

#endif
