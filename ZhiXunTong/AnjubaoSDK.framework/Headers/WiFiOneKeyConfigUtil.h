#ifndef _WIFIONEKEYCONFIGUTIL_H_
#define _WIFIONEKEYCONFIGUTIL_H_

/**
 * WiFi配置类型(主要由IPC版本决定)
 */
typedef enum {
    /**商铺型IPC使用*/
    Realtek,
    /**家居型IPC使用*/
    MTK,
    /**声波配置*/
    Sound,
} WirelessType;

/**
 * WiFi配置结果
 */
typedef enum {
    /**成功*/
    Succeed,
    /**失败*/
    Failed,
    /**超时*/
    Timeout,
    /**"嘀"声确认*/
    SoundConfirm,
    /**IPC连接WiFi失败(可能由SSID或密码设置错误导致)*/
    IPCConnectWiFiFailed,
} ConfigResult;

/**
 * WiFi配置结果回调接口定义
 */
@protocol WiFiOneKeyConfigDelegate <NSObject>
@optional
/**
 * WiFi配置结果回调
 * @param result WiFi配置结果，参见ConfigResult定义，用法参见Demo<br/>
 * Succeed: 在手机所连接的同一个局域网中搜索到了IPC<br/>
 * Failed: 未使用<br/>
 * Timeout: 在超过设置的超时时间内未有任何结果(默认180秒)<br/>
 * SoundConfirm: 检测到IPC的"嘀"声确认<br/>
 * IPCConnectWiFiFailed: IPC连接WiFi失败
 */
- (void)onConfigResult:(int)result;
@end


/**
 * WiFi配置工具
 */
@interface WiFiOneKeyConfigUtil : NSObject<WiFiOneKeyConfigDelegate>

/**
 * 初始化实例(默认以商铺型IPC进行初始化)
 */
-(id)init;

/**
 * 按指定WiFi配置类型进行初始化
 * @param types WiFi配置类型列表，参见WirelessType定义，用法参见Demo
 * @param num WiFi配置类型列表大小
 */
-(id)initWithTypes:(WirelessType[])types :(int)num;

/**
 * 开始配置(默认超时时间180秒)
 * @see startConfig
 */
-(BOOL)startConfig:(NSString*)ipc_id
              Ssid:(NSString*)ssid
          Password:(NSString*)password
  WithSoundConfirm:(BOOL)withSoundConfirm;

/**
 * 开始配置
 * @param ipc_id 要进行WiFi配置的IPC序列号(8个字符)
 * @param ssid 当前手机连接的WiFi的SSID
 * @param password 当前手机连接的WiFi的密码
 * @param withSoundConfirm 是否开启"嘀"声检测
 * @param timeout 自定义超时时间
 */
-(BOOL)startConfig:(NSString*)ipc_id
              Ssid:(NSString*)ssid
          Password:(NSString*)password
  WithSoundConfirm:(BOOL)withSoundConfirm
           Timeout:(int)timeout;

/**
 * 结束配置(只停止发送用于WiFi配置的udp广播数据包，但继续检测IPC连接WiFi失败的"嘀"声)<br/>
 * @see stopConfig
 */
-(void)stopConfig;

/**
 * 结束配置
 * @param with_sound_confirm 是否结束"嘀"声检测，完全关闭请使用YES，用法参见Demo
 */
-(void)stopConfig:(BOOL)with_sound_confirm;

/**
 * WiFi配置结果回调
 */
@property (assign, nonatomic) id<WiFiOneKeyConfigDelegate> configResultDelegate;

@end

#endif