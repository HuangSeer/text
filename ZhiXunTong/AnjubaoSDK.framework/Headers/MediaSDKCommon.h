#ifndef _MEDIASDK_COMMON_H_
#define _MEDIASDK_COMMON_H_

#include <stdint.h>

/**
 * 错误码字义
 */
typedef enum {
    /**
     * 无错误
     */
    MediaSDK_Error_NoError = 0,
    /**
     * 无效handle
     */
    MediaSDK_Error_InvalidHandle = -1,
    /**
     * 资源为空
     */
    MediaSDK_Error_NullResource = -2,
    /**
     * 内部异常
     */
    MediaSDK_Error_Exception = -3,
    /**
     * 无效参数
     */
    MediaSDK_Error_InvalidParameter = -4,
    /**
     * 资源分配失败
     */
    MediaSDK_Error_ResourceAllocFailed = -5,
    /**
     * 操作中断
     */
    MediaSDK_Error_OperationInterrupted = -6,
    /**
     * 连接超时
     */
    MediaSDK_Error_ConnectionTimedOut = -110,//AVERROR(ETIMEDOUT),
    /**
     * RTSP 404错误
     */
    MediaSDK_Error_404StreamNotFound = -((0xF8) | ('4' << 8) | (('0') << 16) | (('4') << 24)),//AVERROR_HTTP_NOT_FOUND,
    /**
     * 未找到流
     */
    MediaSDK_Error_StreamNotFound = -((0xF8) | ('S' << 8) | (('T') << 16) | (('R') << 24)),//AVERROR_STREAM_NOT_FOUND,
    /**
     * RTSP认证错误
     */
    MediaSDK_Error_401Unauthorized = -((0xF8) | ('4' << 8) | (('0') << 16) | (('1') << 24)),//AVERROR_HTTP_UNAUTHORIZED,
    /**
     * IPC音视频关闭
     */
	MediaSDK_Error_VideoSwitchOff = -7,
} MediaSDKErrorCode;

/**
 * 播放控制码定义
 */
typedef enum {
    /**
     * 暂停
     */
    MediaControl_Pause = 0,
    /**
     * 恢复
     */
    MediaControl_Resume = 1,
    /**
     * 快进
     */
    MediaControl_Fast = 2,
    /**
     * 慢进
     */
    MediaControl_Slow = 3,
    /**
     * 获取进度
     */
    MediaControl_GetPlayPos = 4,
    /**
     * 设置进度
     */
    MediaControl_SetPlayPos = 5,
    /**
     * 获取缓冲进度
     */
    MediaControl_GetBufferPos = 6,
    /**
     * 获取视频宽
     */
    MediaControl_GetWidth = 7,
    /**
     * 获取视频高
     */
    MediaControl_GetHeight = 8,
    /**
     * 获取播放状态
     */
    MediaControl_GetPlayStatus = 9,
    /**
     * 获取当前比特率
     */
    MediaControl_GetBitrate = 10,
    /**
     * 获取文件总时长
     */
    MediaControl_GetTotalTime = 11,
    /**
     * 获取文件当前播放时间
     */
    MediaControl_GetCurrentTime = 12,
} MediaControlCode;

typedef enum {
    /**
     * 最慢(MediaControl慢进返回值)
     */
	MediaSDK_RateControlStatus_Slowest = 0x00000001,
    /**
     * 最快(MediaControl快进返回值)
     */
	MediaSDK_RateControlStatus_Fastest = 0x00000002,
} MediaSDKRateControlStatus;

/**
 * 状态码定义
 */
enum {
    /**
     * 文件结束
     */
    MEDIASDK_PLAY_STATUS_FILE_END = 0,
    /**
     * 开始播放,与以下MEDIASDK_PLAY_STATUS_START_DISPLAY和MEDIASDK_PLAY_STATUS_START_SOUND进行按位或使用
     */
    MEDIASDK_PLAY_STATUS_START = 1,
    /**
     * 视频播放开始
     */
    MEDIASDK_PLAY_STATUS_START_DISPLAY = 1 << 1,
    /**
     * 音频播放开始
     */
    MEDIASDK_PLAY_STATUS_START_SOUND = 1 << 2,
    /**
     * 正在进行RTSP重连
     */
    MEDIASDK_PLAY_STATUS_REPLAYING = 1 << 1,
    /**
     * 播放暂停
     */
    MEDIASDK_PLAY_STATUS_PAUSE = 1 << 2,
    /**
     * 内部重连失败,需要重新走信令请求
     */
    MEDIASDK_PLAY_STATUS_NEED_REPLAY = 1 << 3,
    /**
     * 下载完成
     */
    MEDIASDK_DOWNLOAD_COMPLETE = 1 << 4,
    /**
     * 下载中断
     */
    MEDIASDK_DOWNLOAD_INTERRUPTED = 1 << 5,
};

typedef enum MediaSDK_LogPriority {
    MEDIASDK_LOG_UNKNOWN = 0,
    MEDIASDK_LOG_DEFAULT,    /* only for SetMinPriority() */
    MEDIASDK_LOG_VERBOSE,
    MEDIASDK_LOG_DEBUG,
    MEDIASDK_LOG_INFO,
    MEDIASDK_LOG_WARN,
    MEDIASDK_LOG_ERROR,
    MEDIASDK_LOG_FATAL,
    MEDIASDK_LOG_SILENT,     /* only for SetMinPriority(); must be last */
} MediaSDK_LogPriority;

#ifndef _MEDIASDK_DECODE_INFO_
#define _MEDIASDK_DECODE_INFO_
enum
{
	MediaSDK_DecodedFrame_YUV420P,
	MediaSDK_DecodedFrame_YUV444P,
	MediaSDK_DecodedFrame_ARGB,
	MediaSDK_DecodedFrame_PCM,
};

typedef struct _DecodedFrame
{
	uint8_t* data[4];
	int linesize[4];
	int width;
	int height;
	int type;
} DecodedFrame;
#endif

#endif
