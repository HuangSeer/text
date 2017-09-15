#ifndef __MediaSDKOBJC_H_
#define __MediaSDKOBJC_H_

#import <Foundation/Foundation.h>

#include "MediaSDKCommon.h"

#ifdef __cplusplus
#include <string>
class IVideoRenderer;
#endif

/**
 * MediaSDK回调接口定义
 */
@protocol MediaSDKCallback <NSObject>
@optional
/**
 * 结果回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param result 返回结果,见MediaSDK.ErrorCode
 */
-(void)onResult:(int)handle :(int)result;
/**
 * 状态回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param status 状态值,见MediaSDK.StatusCode
 */
-(void)onStatusChanged:(int)handle :(int)status;
/**
 * 实时比特率回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param bitrate 当前实时视频的比特率
 */
-(void)onBitrateChanged:(int)handle :(int)bitrate;
/**
 * 进度回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param pos 播放在线报警录像、本地文件时为播放进度,下载TF卡录像文件时为下载进度(0~1000)
 */
-(void)onPosChanged:(int)handle :(int)pos;
/**
 * 网络状态回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param netStatus 网络状态
 */
-(void)onNetStatus:(int)handle :(int)netStatus;
/**
 * TF卡录像播放进度回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param dowloadPlayPos 播放进度(0~1000)
 */
-(void)onDownloadPlayPosChanged:(int)handle :(int)dowloadPlayPos;
/**
 * 分辨率回调
 * @param handle 句柄,MediaSDK.Play返回值
 * @param width 宽
 * @param height 高
 */
-(void)onResolutionChanged:(int)handle :(int)width :(int)height;
@end

@protocol MediaSDKWindow <NSObject>
@optional
-(void)displayYUV420pData:(void*)y :(void*)u :(void*)v :(NSInteger)w :(NSInteger)h :(NSInteger)linesize;
-(void)displayYUV420pData:(void*)y :(void*)u :(void*)v :(NSInteger)w :(NSInteger)h :(NSInteger)linesize :(NSInteger)yuvType;
@end

/**
 * 音视频播放组件
 */
@interface MediaSDK : NSObject

/**
 * 设置是否显示调试日志级别
 * @param level 调试日志级别，0为仅显示常规日志
 */
+(void)SetDebugLevel:(int)level;

/**
 * 设置是否启用硬件加速
 * @param enable 硬件加速开关
 */
+(void)SetHWAccelEnable:(BOOL)enable;

/**
 * 设置播放预览图等的存储路径(即结束一次实时视频播放后,会保存最后一帧图像为jpg到此路径下)
 * @param strRootPath
 * @return 0为成功
 */
+(int)SetRootPath:(NSString*)strRootPath;

/**
 * 用于播放实时视频、云端录像
 * @param strUrl 视频的url
 * @param pWindow 实现MediaSDKWindow接口
 * @param bUseTCP 是否使用tcp协议,传true
 * @param nMaxRetryTimes 最大重试次数,传1
 * @param nRetryInterval 重试间隔(毫秒),传200
 * @param strSessionID 无用,传""
 * @param strIpcID ipc的ID
 * @param bFullScreen 是否是全屏显示,传true
 * @param bIsFile 指定本url是否是以一个文件的形式播放，传NO时自动以后缀名判断
 * @param callback 见MediaSDK.Callback
 * @return 本次播放的唯一句柄标识,后续操作包括stop需要用到此句柄,小于0为播放失败
 */
+(int)Play:(NSString*)strUrl
          :(id<MediaSDKWindow>)pWindow
          :(BOOL)bUseTCP
          :(int)nMaxRetryTimes
          :(int)nRetryInterval
          :(NSString*)strSessionID
          :(NSString*)strIpcID
          :(BOOL)bFullScreen
          :(BOOL)bIsFile
          :(id<MediaSDKCallback>)callback;

/**
 * 用于播放实时视频、云端录像，相当于bIsFile传NO
 * @param strUrl 视频的url
 * @param pWindow 实现MediaSDKWindow接口
 * @param bUseTCP 是否使用tcp协议,传true
 * @param nMaxRetryTimes 最大重试次数,传1
 * @param nRetryInterval 重试间隔(毫秒),传200
 * @param strSessionID 无用,传""
 * @param strIpcID ipc的ID
 * @param bFullScreen 是否是全屏显示,传true
 * @param bIsFile 指定本url是否是以一个文件的形式播放
 * @param callback 见MediaSDK.Callback
 * @return 本次播放的唯一句柄标识,后续操作包括stop需要用到此句柄,小于0为播放失败
 */
+(int)Play:(NSString*)strUrl
          :(id<MediaSDKWindow>)pWindow
          :(BOOL)bUseTCP
          :(int)nMaxRetryTimes
          :(int)nRetryInterval
          :(NSString*)strSessionID
          :(NSString*)strIpcID
          :(BOOL)bFullScreen
          :(id<MediaSDKCallback>)callback;

/**
 * 设置播放窗口
 * @param nHandle MediaSDK.Play返回值
 * @param pWindow 实现MediaSDKWindow接口
 * @param bFullScreen 是否全屏显示
 * @return 0为成功
 */
+(int)SetPlayWindow:(int)nHandle
                   :(NSObject*)pWindow
                   :(BOOL)bFullScreen;

/**
 * 停止播放
 * @param nHandle MediaSDK.Play返回值
 * @return 0为成功
 */
+(int)Stop:(int)nHandle;

/**
 * 打开声音
 * @param nHandle MediaSDK.Play返回值
 * @return 0为成功
 */
+(int)OpenSound:(int)nHandle;

/**
 * 关闭声音
 * @param nHandle MediaSDK.Play返回值
 * @return 0为成功
 */
+(int)CloseSound:(int)nHandle;

/**
 * 截图
 * @param nHandle MediaSDK.Play返回值
 * @param strSavePath 图片保存路径(完整路径,饮食扩展名)
 * @return 0为成功
 */
+(int)Snapshot:(int)nHandle :(NSString*)strSavePath;

+(int)RecordStart:(int)nHandle :(NSString*)strSavePath;


+(int)RecordStop:(int)nHandle;

/**
 * 播放控制
 * @param nHandle MediaSDK.Play返回值
 * @param nControlCode : 控制码,见MediaSDK.ControlCode
 * @param nValue : 对应的控制值，例如倍速，位置
 * @return 0为成功
 * MediaControl_GetPlayPos、MediaControl_GetBufferPos返回当前播放位置、缓冲位置（百分比）
 * MediaControl_GetPlayStatus返回值-1为加载中、0为文件结束、5为开始显示图像、2为重连中、4为暂停、3为开始播放声音
 * MediaControl_GetBitrate返回当前视频网络流量比特率，单位为bits/s，例如须转换为KB/s则须将返回值除以8*1024（1Byte=8bits,1K=1024）
 */
+(int)MediaControl:(int)nHandle :(int)nControlCode :(void*)nValue;

/**
 * 获取文件总时长
 * @param nHandle MediaSDK.Play返回值
 * @return 文件总时长(秒)
 */
+(float)GetFileTotalTime:(int)nHandle;

/**
 * 获取当前播放位置
 * @param nHandle MediaSDK.Play返回值
 * @return 当前播放位置(秒)
 */
+(float)GetFileCurrentTime:(int)nHandle;

/**
 * 根据错误码获取描述
 * @param nErrorCode 错误码
 * @return 描述
 */
+(NSString*)GetErrorMsg:(int)nErrorCode;

/**
 * TF卡录像下载
 * @param strURL url
 * @param fTotalTime 文件总时长
 * @param nTotalSize 文件总大小
 * @param strDownloadPath 下载文件存储路径
 * @param pWindow 不需要边下边播,则传null,如需要边下边播,则传播放窗口,实现MediaSDKWindow接口
 * @param bFullScreen 是否全屏显示
 * @param callback 见MediaSDK.Callback
 * @return >0为合法handle,<0见MediaSDK.ErrorCode
 */
+(int)DownloadStart:(NSString*)strURL
                   :(float)fTotalTime
                   :(int)nTotalSize
                   :(NSString*)strDownloadPath
                   :(id<MediaSDKWindow>)pWindow
                   :(BOOL)bFullScreen
                   :(id<MediaSDKCallback>)callback;

/**
 * 停止TF卡录像下载
 * @param nHandle MediaSDK.DownloadStart返回值
 * @param bContinue 是否需要下次续传
 * @return 0为成功
 */
+(int)DownloadStop:(int)nHandle
                  :(BOOL)bContinue;

/**
 * 设置窗口背景为指定ipc的最后一帧图像
 * @param strIpcID ipc的uuid
 * @param pWindow 实现MediaSDKWindow接口
 * @param bDefault 是否刷新为默认图片(黑色背景)
 * @param bForceRefresh 是否强制刷新
 * @return 0为成功
 */
+(int)SetBackgroundImage:(NSString*)strIpcID
                        :(NSObject*)pWindow
                        :(BOOL)bDefault
                        :(BOOL)bForceRefresh;

/**
 * 清空窗口内容
 * @param pWindow 实现MediaSDKWindow接口
 * @return 0为成功
 */
+(int)ClearWindow:(NSObject*)pWindow;

/**
 * 从指定录像文件生成同名预览图
 * @param file 录像文件路径(完整路径)
 * @return 0为成功
 */
+(int)DumpRecordFileThumbnail:(NSString*)file;

+(NSString*)TmpSnapshotDirectory;

#ifdef __cplusplus
+(int)ClearBackground:(IVideoRenderer*)renderer :(std::string)strIpcID :(bool)bDefault :(bool)bForceRefresh;
#endif

@end

#endif
