//
//  AnjubaoSDK.h
//  AnjubaoSDK
//
//  Created by YangFan on 4/8/16.
//  Copyright © 2016 YangFan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDKCommonDef.h"

/**
 * 服务器推送消息回调接口定义
 */
@protocol AnjubaoSDKPushMessageDelegate <NSObject>
@optional
/**
 * 当服务器有消息推送时回调此接口
 * @param pushMessage 服务器推送消息，参见AJBPushMessage定义，用法参见Demo
 */
-(void)onMessagePushed:(AJBPushMessage*)pushMessage;
@end

/**
 * 用户离线回调接口定义
 */
@protocol AnjubaoSDKUserOfflineDelegate <NSObject>
@optional
/**
 * 当用户在其它手机或App上登陆时，回调此接口
 */
-(void)onUserOffline;
@end

/**
 * 安居宝云监控SDK定义<br/>
 * 本SDK使用单例模式，同时只支持一个用户使用<br/>
 * 所有返回值为int类型的接口，以返回值0代表成功，其它值代表失败<br/>
 * 返回值其它类型的，具体可参见AnjubaoSDKCommonDef.h中的类定义
 */
@protocol AnjubaoSDK <NSObject>

/**
 * 设置是否登录到2.0版本服务器
 * @param isVersion2 是否登录到2.0版本服务器
 */
-(void)setVersion2:(BOOL)isVersion2;

/**
 * 查询指定型号IPC目前的最新固件版本信息
 * @param ipcModel IPC的型号，即IpcInfomaion中的device_type
 * @return 参见AJBVersionInfo
 */
-(AJBVersionInfo*)checkUpgradeInfo:(NSString*)ipcModel;

/**
 * 设置是否打印调试信息<br/>
 * 建议开发调试阶段设置为true，以方便问题跟踪，发布时再设置为false
 */
-(void)setDebug:(BOOL)debug;

/**
 * 开始监听服务器消息推送
 * @param pushMessageDelegate 服务器推送消息回调实例
 */
-(void)startListen:(id<AnjubaoSDKPushMessageDelegate>)pushMessageDelegate;

/**
 * 停止监听服务器消息推送
 */
-(void)stopListen;

/**
 * 开始监听服务器消息推送
 * @param pushMessageDelegate 服务器推送消息回调实例
 */
-(void)startListenNew:(id<AnjubaoSDKPushMessageDelegate>)pushMessageDelegate;

/**
 * 停止监听服务器消息推送
 */
-(void)stopListenNew;

/**
 * 设置用户离线回调
 * @param callback 用户离线回调实例
 */
-(void)setOfflineDelegate:(id<AnjubaoSDKUserOfflineDelegate>)userOfflineDelegate;

/**
 * 设置服务器信息(用于调试，可以用户在不同的服务器注册和登录，默认不用设置)
 * @param address 服务器IP
 * @param port 服务器端口
 */
-(void)setServiceInfo:(NSString*)address port:(int)port;

/**
 * 连接服务器<br/>
 * 获取相关服务器信息(此接口调用成功后才可使用其它所有与服务器有交互的功能)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)connectService;

-(NSString*)getUserId;

-(NSString*)getClientId;

-(NSString*)getNginxServerIP;

-(int32_t)getNginxServerPort;

/**
 * 第三方登录<br/>
 * 供第三方安居小宝用户使用，调用接口只须提供手机账号，内部判断是否已注册，如已注册则登录，如未注册则自动注册后登录
 * @param account 手机账号
 * @param deviceId 手机设备唯一ID
 * @return 0代表成功，1检查账号失败，2登录失败，3注册失败
 */
-(int)thirdPartyLogin:(NSString*)account
             deviceId:(NSString*)deviceId;

/**
 * 第三方登录<br/>
 * 供第三方安居小宝用户使用，调用接口只须提供手机账号，内部判断是否已注册，如已注册则登录，如未注册则自动注册后登录
 * @param account 手机账号
 * @param deviceId 手机设备唯一ID
 * @param languageType 语言类型(见AJBLanType定义)
 * @param timeZone 时区名称，如"UTC+8"，填nil或@""则默认中国时区
 * @param timeZoneOffset 时区偏移，以秒数计，如"UTC+8"下为8*3600，timeZone为nil或@""时无效
 * @return 0代表成功，1检查账号失败，2登录失败，3注册失败
 */
-(int)thirdPartyLogin:(NSString*)account
             deviceId:(NSString*)deviceId
         languageType:(AJBLangType)languageType
             timeZone:(NSString*)timeZone
       timeZoneOffset:(int)timeZoneOffset;

/**
 * 第三方登录(带主从账号信息)<br/>
 * 供第三方安居小宝用户使用
 * @param mainAccount 主账号
 * @param subAccounts 子账号(以主账号登录时，此参数为主账号下所有子账号;非以主账号登录时，此参数为要登录的子账号，即ArrayList中只有一个成员)
 * @param isMainAccountLogin 当前是否以主账号登陆
 * @param deviceId 手机设备唯一ID
 * @return 0代表成功，1检查账号失败，2登录失败，3注册失败，4账号错误，5主账号登录失败，6获取主账号地址失败，7主账号未创建地址，8主账号添加子账号失败
 */
-(int)thirdPartyLogin:(NSString*)mainAccount
          subAccounts:(NSMutableArray<NSString*>*)subAccounts
   isMainAccountLogin:(BOOL)isMainAccountLogin
             deviceId:(NSString*)deviceId;

/**
 * 第三方添加子账号<br/>
 * 用于第三方在已有的主账号上添加新的子账号
 * @param mainAccount 主账号
 * @param subAccount 子账号
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)thirdPartyAddSubAccount:(NSString*)mainAccount
                            subAccount:(NSString*)subAccount;

/**
 * 第三方注册账号<br/>
 * 用于第三方注册账号
 * @param account 主账号
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)thirdPartyUserRegister:(NSString*)account
                              appType:(int)appType;

/**
 * 第三方批量注册账号<br/>
 * 用于第三方批量注册账号
 * @param accounts 要注册的指账号(手机号)
 * @return 参见AJBMutiUsersRegitser
 */
-(AJBMutiUsersRegitser*)thirdPartyMultiUserRegister:(NSMutableArray<NSString*>*)accounts;

/**
 * 获取短信验证码
 * @param account 用户手机号
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @param areaCode 用户手机地区代码(例如中国大陆为“86”)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)getSmsAuthCode:(NSString*)account
                      appType:(int32_t)appType
                     areaCode:(NSString*)areaCode;

/**
 * @deprecated 旧版用户注册接口，已停用
 * @see userRegisterNew
 */
-(AJBErrorCode)userRegister:(NSString*)account
                   password:(NSString*)password
                    appType:(int32_t)appType;

/**
 * 用户注册(调用此接口前，请先获取短信验证码)
 *
 * @see #getSmsAuthCode(String, int, String)
 * @param account 用户手机号
 * @param password 用户密码
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @param authCode 用户手机地区代码(例如中国大陆为“86”)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)userRegisterNew:(NSString*)account
                      password:(NSString*)password
                       appType:(int32_t)appType
                      authCode:(NSString*)authCode;

/**
 * 用户登录
 * @param account 用户帐户，通常为手机号
 * @param password 用户密码
 * @param deviceId 手机设备唯一ID
 * @param areaType 1:国内版 2:海外版 3:安居家园
 * @return 参见AJBUserLogin
 */
-(AJBUserLogin*)userLogin:(NSString*)account
                 password:(NSString*)password
                 deviceId:(NSString*)deviceId
                 areaType:(int)areaType;

/**
 * 用户登录(带app类型)
 * @param account 用户帐户，通常为手机号
 * @param password 用户密码
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @param deviceId 手机设备唯一ID
 * @param areaType 1:国内版 2:海外版 3:安居家园
 * @return 参见AJBUserLogin
 */
-(AJBUserLogin*)userLogin:(NSString*)account
                 password:(NSString*)password
                  appType:(int)appType
                 deviceId:(NSString*)deviceId
                 areaType:(int)areaType;

/**
 * 用户登录(带语言及时区信息)
 * @param account 用户帐户，通常为手机号
 * @param password 用户密码
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @param languageType 语言类型(见AJBLanType定义)
 * @param timeZone 时区名称，如"UTC+8"，填nil或@""则默认中国时区
 * @param timeZoneOffset 时区偏移，以秒数计，如"UTC+8"下为8*3600，timeZone为nil或@""时无效
 * @param deviceId 手机设备唯一ID
 * @param areaType 1:国内版 2:海外版 3:安居家园
 * @return 参见AJBUserLogin
 */
-(AJBUserLogin*)userLogin:(NSString*)account
                 password:(NSString*)password
                  appType:(int)appType
             languageType:(AJBLangType)languageType
                 timeZone:(NSString*)timeZone
           timeZoneOffset:(int)timeZoneOffset
                 deviceId:(NSString*)deviceId
                 areaType:(int)areaType;

/**
 * 用户注销<br/>
 * 用于注销最近一次用户登录的信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)userLogout;

/**
 * 消息推送开关
 @param is_push 设置是否推送消息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)isPush:(BOOL)is_push;

/**
 * 发送心跳包<br/>
 * 用于维持当前登录用户在服务器上活跃，建议每三分钟调用一次
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)heartBeat;

/**
 * 获取用户名下所有地址信息
 * @return 参见AJBUserGetAddress
 */
-(AJBUserGetAddress*)userGetAddress;

/**
 * 获取用户指定地址下所有IPC信息
 * @param addressId 地址ID
 * @return 参见AJBUserGetAddressIpcs
 */
-(AJBUserGetAddressIpcs*)userGetAddressIpcs:(NSString*)addressId;

/**
 * 对指定地址布/撤防
 * @param addressId 地址ID
 * @param safeStatus 布防true,撤防false
 * @return 参见AJBAddressSetAgainst
 */
-(AJBAddressSetAgainst*)addressSetAgainst:(NSString*)addressId
                               safeStatus:(BOOL)safeStatus;

/**
 * 获取报警事件列表
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBReAlarmEventList
 */
-(AJBReAlarmEventList*)reAlarmEventList:(int32_t)pageLimit
                                 offset:(int32_t)offset;

/**
 * 获取报警事件列表(带报警类型及时间段过滤)
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @param alarmType 查询的报警类型
 * @param beginTime 查询的开始时间
 * @param endTime 查询的结束时间
 * @return 参见AJBReAlarmEventList
 */
-(AJBReAlarmEventList*)reAlarmEventList:(int32_t)pageLimit
                                 offset:(int32_t)offset
                              alarmType:(int32_t)alarmType
                              beginTime:(NSString*)beginTime
                                endTime:(NSString*)endTime;

/**
 * 获取设备事件列表
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBReDeviceEventlist
 */
-(AJBReDeviceEventlist*)reDeviceEventlist:(int32_t)pageLimit
                                   offset:(int32_t)offset;

/**
 * 获取服务事件列表
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBReServiceEventlist
 */
-(AJBReServiceEventlist*)reServiceEventlist:(int32_t)pageLimit
                                     offset:(int32_t)offset;

/**
 * 对指定地址绑定IPC
 * @param addressId 地址ID
 * @param addressName 地址名称
 * @param ipcId 要绑定的IPC的ID
 * @param ipcName 设定要绑定的IPC的名称
 * @return 参见AJBAddressBindIpcs
 */
-(AJBAddressBindIpcs*)addressBindIpcs:(NSString*)addressId
                          addressName:(NSString*)addressName
                                ipcId:(NSString*)ipcId
                              ipcName:(NSString*)ipcName;

/**
 * 对指定地址邀请指定用户<br/>
 * 即邀请后，该用户可以查看该地址下IPC的音视频，报警消息等信息
 * @param addressId 要邀请的地址ID
 * @param addressName 要邀请的地址名称
 * @param account 要邀请的用户
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressInvitedUser:(NSString*)addressId
                      addressName:(NSString*)addressName
                          account:(NSString*)account;

/**
 * 拒绝邀请<br/>
 * 即当接收到他人对自己的邀请后，可以使用此接口拒绝
 * @param addressId 被邀请的地址ID
 * @param addressName 被邀请的地址名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)refusedInvite:(NSString*)addressId
                 addressName:(NSString*)addressName;

/**
 * 删除指定地址
 * @param addressId 要删除的地址ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)userRemoveAddress:(NSString*)addressId;

/**
 * 删除指定地址下指定的IPC(可同时删除多个)
 * @param addressId 地址ID
 * @param ipcIds IPC的ID数组
 * @param isDelData 删除后是否同时删除该IPC存储在云端的数据(报警事件，报警录像等)
 * @param isDelSensor 删除后是否同时删除该IPC下所绑定的传感器
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressRemoveIpcs:(NSString*)addressId
                          ipcIds:(NSMutableArray<NSString*>*)ipcIds
                       isDelData:(BOOL)isDelData
                     isDelSensor:(BOOL)isDelSensor;

/**
 * 查询云端录像
 * @param pageLimit 每次查询的事件数量（因录像数量可能巨大，不可能一次性获取全部录像，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBQueryRecord
 */
-(AJBQueryRecord*)queryRecord:(int32_t)pageLimit
                       offset:(int32_t)offset;

/**
 * 请求查看IPC实时视频
 * @param streamType 请使用EStreamType.E_STR_NOTYPE
 * @param ipcId 要查看视频的IPC的ID
 * @param addressId 要查看视频的IPC所属的地址ID
 * @return 参见AJBReqWatchIpc
 */
-(AJBReqWatchIpc*)reqWatchIpc:(AJBEStreamType)streamType
                        ipcId:(NSString*)ipcId
                    addressId:(NSString*)addressId;

/**
 * 请求停止查看IPC实时视频
 * @param streamType 请使用EStreamType.E_STR_NOTYPE
 * @param ipcId 要查看视频的IPC的ID
 * @param url 对应reqWatchIpc返回的RTSP URL
 * @param isException 此次停止是否因为异常而停止
 * @return 参见AJBreqStopWatchIpc
 */
-(AJBErrorCode)reqStopWatchIpc:(AJBEStreamType)streamType
                         ipcId:(NSString*)ipcId
                           url:(NSString*)url
                   isException:(BOOL)isException;

/**
 * 获取所有邀请的用户信息
 * @return 参见AJBAddressVisitors
 */
-(AJBAddressVisitors*)addressVisitors;

/**
 * 取消对某个用户的邀请
 * @param addressId 地址ID
 * @param account 要取消邀请的用户手机号
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressNoInvitedUser:(NSString*)addressId
                            account:(NSString*)account;

/**
 * 开启双向语音对讲<br/>
 * 即开始由App端发送音频到IPC端(须成功开启实时视频后才可开启双向语音对讲)
 * @param ipcId 要开启对讲的IPC的ID
 * @return 参见AJBReqStartTalkIpc
 */
-(AJBReqStartTalkIpc*)reqStartTalkIpc:(NSString*)ipcId;

/**
 * 关闭双向语音对讲<br/>
 * @param ipcId 要关闭对讲的IPC的ID
 * @param ssrc 要关闭的此次对讲的ssrc,由reqStartTalkIpc返回值中获得
 * @return 参见AJBreqStopTalkIpc
 */
-(AJBErrorCode)reqStopTalkIpc:(NSString*)ipcId
                         ssrc:(int32_t)ssrc;

/**
 * 获取指定IPC当前抓拍图像
 * @param ipcIds 要获取的IPC的ID列表
 * @return 参见AJBGetIpcImg
 */
-(AJBGetIpcImg*)getIpcImg:(NSMutableArray<NSString*>*)ipcIds;

/**
 * 将传感器绑定到指定IPC下
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 传感器序列号
 * @param sensorType 传感器类型
 * @param sensorName 传感器名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcBindSensors:(NSString*)ipcId
           sensorSerialNumber:(NSString*)sensorSerialNumber
                   sensorType:(AJBESensorType)sensorType
                   sensorName:(NSString*)sensorName;

/**
 * 修改用户资料信息
 * @param addressName 地址名称
 * @param tel 电话
 * @param addr 地址
 * @return 参见AJBUserAddAddress
 */
-(AJBUserAddAddress*)userAddAddress:(NSString*)addressName
                                tel:(NSString*)tel
                               addr:(NSString*)addr;

/**
 * 检查指定IPC固件是否有更新可用
 * @param ipcId IPC的ID
 * @return 参见AJBCheckIpcUpdate
 */
-(AJBCheckIpcUpdate*)checkIpcUpdate:(NSString*)ipcId;

/**
 * 更新指定IPC的固件
 * @param ipcId IPC的ID
 * @param url 固件升级包URL
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)updateIpcPackage:(NSString*)ipcId
                            url:(NSString*)url;

/**
 * 修改用户密码
 * @param oldPwd 原来的密码
 * @param newPwd 新的密码
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)userChangePwd:(NSString*)oldPwd
                      newPwd:(NSString*)newPwd;

/**
 * 设置IPC水印文字内容
 * @param ipcId IPC的ID
 * @param osdStr OSD文字内容
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)setIpcOsd:(NSString*)ipcId
                  osdStr:(NSString*)osdStr;

/**
 * 设置IPC图像反转
 * @param ipcId IPC的ID
 * @param imageReverseType 反转类型
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)setIpcImageReverse:(NSString*)ipcId
                 imageReverseType:(AJBEImageReverseType)imageReverseType;

/**
 * @deprecated 旧版忘记密码接口，已停用
 * @see forgetPwdNew
 */
-(AJBErrorCode)forgetPwd:(NSString*)appKey
                    zone:(NSString*)zone
                 account:(NSString*)account
                  newPwd:(NSString*)newPwd
                    code:(NSString*)code
                 appType:(int32_t)appType;

/**
 * 忘记密码(调用此接口前，请先获取短信验证码)
 * @see #getSmsAuthCode(String, int, String)
 * @param account 账户名
 * @param newPwd 新的密码
 * @param authCode 获取到的短信验证码
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)forgetPwdNew:(NSString*)account
                     newPwd:(NSString*)newPwd
                   authCode:(NSString*)authCode
                    appType:(int32_t)appType;

/**
 * 检查指定手机号是否已被注册
 * @param account 手机号
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 参见AJBMobileExists
 */
-(AJBMobileExists*)mobileExists:(NSString*)account
                        appType:(int32_t)appType;

/**
 * 获取绑定在指定IPC下的传感器信息
 * @param ipcId IPC的ID
 * @return 参见AJBUserGetAddressIpcSensors
 */
-(AJBUserGetAddressIpcSensors*)userGetAddressIpcSensors:(NSString*)ipcId;

/**
 * 删除指定IPC属下的指定传感器
 * @param ipcId IPC的ID
 * @param sensorId 传感器的ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcRemoveSensors:(NSString*)ipcId
                       sensorId:(NSString*)sensorId;

/**
 * 修改地址信息（dayDefenceTime和noDefenceTime不为空，即设置定时布撤防时间）
 * @param addressInfo AddressInfo实例
 * @param dayDefenceTime 布防时间
 * @param noDefenceTime 撤防时间
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editAddressInfo:(AJBAddressInfo*)addressInfo
                dayDefenceTime:(NSString*)dayDefenceTime
                 noDefenceTime:(NSString*)noDefenceTime;

/**
 * 在线更改IPC所连接WiFi
 * @param ipcId 要更改的IPC的ID
 * @param ipcEncryptType 要使IPC连接的WiFi的加密类型
 * @param ssid 要使IPC连接的WiFi的SSID
 * @param pwd 要使IPC连接的WiFi的密码
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)updateIpcWifipwd:(NSString*)ipcId
                 ipcEncryptType:(AJBIpcEncryptType)ipcEncryptType
                           ssid:(NSData*)ssid
                            pwd:(NSString*)pwd
                          bssid:(NSString*)bssid;
/**
 * 检查当前用户属下所有IPC是否有更新
 * @return 参见AJBCheckAllIpcUpdate
 */
-(AJBCheckAllIpcUpdate*)checkAllIpcUpdate;

/**
 * 升级所有IPC
 * @param ipcInformationArray 要升级的IPC列表
 * @return 参见AJBAllIpcUpdate
 */
-(AJBAllIpcUpdate*)allIpcUpdate:(NSMutableArray<AJBIpcInfomation*>*)ipcInformationArray;

/**
 * 查询IPC在指定月份里SD卡有录像的日期
 * @param ipcId IPC的ID
 * @param monthList 月份列表（格式"2015-05"）
 * @return 参见AJBappGetIpcFileMonthInfo
 */
-(AJBappGetIpcFileMonthInfo*)appGetIpcFileMonthInfo:(NSString*)ipcId
                                          monthList:(NSMutableArray<NSString*>*)monthList;

/**
 * 查询指定IPC在指定日期里的SD卡录像信息
 * @param ipcId IPC的ID
 * @param dateStr 要查询的日期
 * @return 参见AJBappGetIpcFileInfo
 */
-(AJBappGetIpcFileInfo*)appGetIpcFileInfo:(NSString*)ipcId
                                  dateStr:(NSString*)dateStr;

-(AJBappGetIpcFileInfo*)appGetIpcFileInfo:(NSString*)ipcId
                                  dateStr:(NSString*)dateStr
                                pageLimit:(int)pageLimit
                                   offset:(int)offset;

/**
 * 请求下载IPC的SD卡录像
 * @param ipcId IPC的ID
 * @param fileId 要下载的文件ID
 * @param timestamp 开始的时间点（用于断点续传，以秒为单位，例如从头开始下载，则传"0"）
 * @return 参见AJBappDownloadIpcFile
 */
-(AJBappDownloadIpcFile*)appDownloadIpcFile:(NSString*)ipcId
                                     fileId:(NSString*)fileId
                                  timestamp:(NSString*)timestamp;

/**
 * 请求停止下载IPC的SD卡录像
 * @param ipcId IPC的ID
 * @param fileId 要停止下载的文件ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)stopDownloadFile:(NSString*)ipcId
                         fileId:(NSString*)fileId
                            url:(NSString*)url;

/**
 * 获取IPC状态
 * @param ipcId IPD的ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)refreshIpc:(NSString*)ipcId;

/**
 * 请求格式化IPC的TF卡
 * @param ipcId IPC的ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)formatIpcTF:(NSString*)ipcId;

/**
 * 查询指定IPC是否在线
 * @param SerialNumber IPC的出厂序列号
 * @return 参见AJBrefreshIpcIsOnline
 */
-(AJBrefreshIpcIsOnline*)refreshIpcIsOnline:(NSString*)ipcId;

/**
 * 对指定IPC进行布撤防（可多个）
 * @param ipcIdArray IPC的ID
 * @param safeStatus 布撤防状态（true为布防，false为撤防）
 * @param defenceDelay 布防延迟时间
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcSetAgainst:(NSMutableArray<NSString*>*)ipcIdArray
                  safeStatus:(BOOL)safeStatus
                defenceDelay:(int)defenceDelay;

/**
 * 修改IPC信息
 * @param ipcInformation 新的IPC信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)updateIpcInfo:(AJBIpcInfomation*)ipcInformation;

/**
 * 苹果推送开关
 * @param isOpen 设置是否启用苹果推送
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)openIOSPushState:(BOOL)isOpen;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 智能家居相关
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * 智能家居用户登录
 * @param account 用户账号
 * @param password 用户密码
 * @param deviceId 手机设备唯一ID
 * @param areaType 1:国内版 2:海外版 3:安居家园
 * @return 参见AJBHomeUserLogin
 */
-(AJBHomeUserLogin*)homeUserLogin:(NSString*)account
                         password:(NSString*)password
                         deviceId:(NSString*)deviceId
                         areaType:(int)areaType;

/**
 * 智能家居用户登录(带语言及时区信息)
 * @param account 用户帐户，通常为手机号
 * @param password 用户密码
 * @param languageType 语言类型(见AJBLanType定义)
 * @param timeZone 时区名称，如"UTC+8"，填nil或@""则默认中国时区
 * @param timeZoneOffset 时区偏移，以秒数计，如"UTC+8"下为8*3600，timeZone为nil或@""时无效
 * @param deviceId 手机设备唯一ID
 * @param areaType 1:国内版 2:海外版 3:安居家园
 * @return 参见AJBHomeUserLogin
 */
-(AJBHomeUserLogin*)homeUserLogin:(NSString*)account
                         password:(NSString*)password
                     languageType:(AJBLangType)languageType
                         timeZone:(NSString*)timeZone
                   timeZoneOffset:(int)timeZoneOffset
                         deviceId:(NSString*)deviceId
                         areaType:(int)areaType;

/**
 * 增加房间
 * @param roomName 房间名称
 * @param picUrl 房间图片
 * @param roomType 房间类型
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addRoom:(NSString*)roomName
                picUrl:(NSString*)picUrl
              roomType:(int32_t)roomType;

/**
 * 修改房间信息
 * @param roomId 房间ID
 * @param roomName 房间名称
 * @param picUrl 房间图片
 * @param roomType 房间类型
 * @return
 *         0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editroom:(NSString*)roomId
               roonName:(NSString*)roomName
                 picUrl:(NSString*)picUrl
               roomType:(int32_t)roomType;

/**
 * 删除房间（可多个）
 * @param roomIdArray 要删除的房间ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delRoom:(NSMutableArray<NSString*>*)roomIdArray;

/**
 * 获取所有房间
 * @return 参见AJBappDownloadIpcFile
 */
-(AJBGetAllRoom*)getAllRoom;

/**
 * 为指定地址添加子用户
 * @param addressId 地址ID
 * @param account 用户账号
 * @param password 用户密码
 * @param userName 子账户的名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addUser:(NSString*)addressId
               account:(NSString*)account
              password:(NSString*)password
              userName:(NSString*)userName;

/**
 * 添加子用户，并指定其有权限访问的地址
 * @param addressIds 子账户有权限访问的地址ID集合
 * @param account 用户账号
 * @param password 用户密码
 * @param userName 子账户的名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addUserWithAddresses:(NSMutableArray<NSString*>*)addressIds
                            account:(NSString*)account
                           password:(NSString*)password
                           userName:(NSString*)userName;

/**
 * 删除子用户
 * @param accountId 子用户账号
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delSubUser:(NSString*)accountId;

/**
 * 获取当前用户属下所有子用户信息
 * @return 参见AJBGetAllSubUser
 */
-(AJBGetAllSubUser*)getAllSubUser;

/**
 * 对指定家绑定IPC
 * @param homeId 家ID
 * @param ipcInformation IPC信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)homeBindIpc:(NSString*)homeId
            ipcInformation:(AJBIpcInfomation*)ipcInformation;

/**
 * 对指定房间下指定IPC绑定传感器
 * @param roomId 房间ID
 * @param ipcId IPC的ID
 * @param sensorInfo 传感器信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)homeBindSensors:(NSString*)roomId
                         ipcId:(NSString*)ipcId
                    sensorInfo:(AJBAppSensorInfo*)sensorInfo;

/**
 * 添加场景
 * @param scenceEntity 场景实体
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addScence:(AJBScenceEntity*)scence;

/**
 * 编辑场景
 * @param scenceEntity 要编辑的场景实体
 * @param scenceDeviceEntityArray 场景设备实体
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editScence:(AJBScenceEntity*)scence
 scenceDeviceEntityArray:(NSMutableArray<AJBScenceDeviceEntity*>*)scenceDeviceEntityArray;

/**
 * 删除场景（可多个）
 * @param scenceIdArray 场景ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delScence:(NSMutableArray<NSString*>*)scenceIdArray;

/**
 * 获取当前用户属下所有场景
 * @return 参见AJBGetAllScence
 */
-(AJBGetAllScence*)getAllScence;

/**
 * 获取指定场景信息
 * @param scenceId 场景ID
 * @return 参见AJBGetAllScence
 */
-(AJBGetScenceInfo*)getScenceInfo:(NSString*)scenceId;

/**
 * 操作设备
 * @param deviceEntityArray 设备实体
 * @return 参见AJBDeviceAction
 */
-(AJBDeviceAction*)deviceAction:(NSMutableArray<AJBDeviceEntity*>*)deviceEntityArray;

/**
 * 打开场景
 * @param scenceId 场景ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)openScence:(NSString*)scenceId;

/**
 * 获取房间设备状态
 * @param roomId 房间ID
 * @return 参见AJBDeviceAction
 */
-(AJBRoomDeviceStatus*)roomDeviceStatus:(NSString*)roomId;

/**
 * 删除设备（传感器）
 * @param deviceId 设备ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)removeDevice:(NSString*)deviceId;

/**
 * 修改传感器名称
 * @param deviceId 设备ID
 * @param deviceName 设备名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editDeviceName:(NSString*)deviceId
                   deviceName:(NSString*)deviceName;

/**
 * 家庭一键布撤防
 * @param homeId 家庭ID
 * @param safeStatus 是否布防
 * @param defenceDelay 布防延迟时间
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBHomeSetAgainst*)homeSetAgainst:(NSString*)homeId
                         safeStatus:(BOOL)safeStatus
                       defenceDelay:(int)defenceDelay;

/**
 * 获取当前最新的空气质量
 * @param homeId 家庭ID
 * @param ipcId IPC的ID(为nil或""时获取所有IPC最新空气质量状况)
 * @param beginTime 开始时间
 * @param endTime 结束时间
 * @return 参见AJBGetIpcAirQuality
 */
-(AJBGetIpcAirQuality*)getIpcAirQuality:(NSString*)homeId
                                  ipcId:(NSString*)ipcId
                              beginTime:(NSString*)beginTime
                                endTime:(NSString*)endTime;

/**
 * 编辑用户信息(目前只编辑图像地址，以后再加其他的)
 * @param userPicUrl 图片Url
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editHomeUserInfo:(NSString*)userPicUrl;

/**
 * 用户添加家(商铺)
 * @param homeName 名称
 * @param tel 电话
 * @param addr 地址
 * @return 参见AJBUserAddHome
 */
-(AJBUserAddHome*)userAddHome:(NSString *)homeName
                          tel:(NSString *)tel
                         addr:(NSString *)addr;

/**
 * 修改情景基本信息(此消息不编辑情景的设备信息)
 * @param scenceId 情景ID
 * @param scenceName 情景名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editScenceBaseInfo:(NSString *)scenceId
                       scenceName:(NSString *)scenceName;

/**
 * 获取指定房间的传感器数据
 * @param roomId 房间ID
 * @return 参见AJBGetRoomDevice
 */
-(AJBGetRoomDevice*)getRoomDevice:(NSString *)roomId;

/**
 * 修改传感器子设备名字
 * @param childDeviceId 子设备ID
 * @param childDeviceName 子设备名称
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editSensorChildDeviceName:(NSString *)childDeviceId
                       chiledDeiviceName:(NSString *)childDeviceName;

/**
 * 主账号重置子帐号密码
 * @param subAccountId 子账号ID
 * @param subAccountPassword 子账号新密码
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)resetChildAccountPass:(NSString*)subAccountId
                  subAccountPassword:(NSString*)subAccountPassword;

/**
 * 批量设备控制
 * @param controlData 设备控制集合
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)appMutiDeviceControl:(NSMutableArray<AJBDeviceControl*>*)controlData;

/**
 * 获取家里所有的传感器
 * @param homeId 家庭ID
 * @return 参见AJBGetHomeAllSensor
 */
-(AJBGetHomeAllSensor*)getHomeAllSensor:(NSString*)homeId;

/**
 * 设备移到另一个房间
 * @param roomId 房间ID
 * @param sensorIds 传感器ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)moveDevice2Room:(NSString*)homeId
                     sensorIds:(NSMutableArray<NSString*>*)sensorIds;

/**
 * 获取全家的设备状态
 * @param homeId 家庭ID
 * @return 参见AJBHomeDeviceStatus
 */
-(AJBHomeDeviceStatus*)homeDeviceStatus:(NSString*)homeId;

/**
 * 转移ipc传感器
 * @param roomId 房间ID
 * @param ipcId IPC的ID
 * @param sensorInfo 要移除的传感器信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)homeReSetSensors:(NSString*)roomId
                          ipcId:(NSString*)ipcId
                     sensorInfo:(AJBAppSensorInfo*)sensorInfo;

/**
 * 删除报警
 * @param alarmIdsArray 报警ID数组
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delAlarm:(NSMutableArray<NSString*>*)alarmIdsArray;

/**
 * 删除指定地址下的报警
 * @param addressId 地址ID
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delAlarmByAddrId:(NSString*)addressId;

/**
 * 获取指定情景下的报警联动信息
 * @param scenceId 情景ID
 * @return 参见AJBGetLinkageScenceAlarm
 */
-(AJBGetLinkageScenceAlarm*)getLinkageScenceAlarm:(NSString*)scenceId;

/**
 * 设定指定情景模式下的报警联动
 * @param scenceId 情景ID
 * @param ipcLinkageScenceArray 报警联动设置
 * @return 参见AJBappMutiLinkageScenceAlarm
 */
-(AJBErrorCode)appMutiLinkageScenceAlarm:(NSString*)scenceId
                   ipcLinkageScenceArray:(NSMutableArray<AJBLinkageScenceAlarm*>*)ipcLinkageScenceArray;

/**
 * IPC移动侦测报警开关
 * @param ipcId IPC的ID
 * @param isOpenMotionDetection 是否开启移动侦测报警
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcMotionSwitch:(NSString*)ipcId
         isOpenMotionDetection:(BOOL)isOpenMotionDetection;

/**
 * IPC自动升级开关
 * @param ipcId IPC的ID
 * @param isAutoLevelUp 是否开启自动升级
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcAutoLevelUp:(NSString*)ipcId
                isAutoLevelUp:(BOOL)isAutoLevelUp;

/**
 * IPC的LED闪烁开关
 * @param ipcId IPC的ID
 * @param isOpen 是否开启LED灯闪烁
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)AppIPCSeeFlashing:(NSString*)ipcId
                          isOpen:(BOOL)isOpen;

/**
 * 获取IPC扫描到的WiFi信息
 * @param ipcId IPC的ID
 * @return 参见AJBAppWiFiAPScannig
 */
-(AJBAppWiFiAPScannig*)appWiFiAPScannig:(NSString*)ipcId;

/**
 * IPC语音提示开关
 * @param ipcId IPC的ID
 * @param voicePromptActive 是否开启语音提示
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)ipcPromptSwitch:(NSString*)ipcId
             voicePromptActive:(BOOL)voicePromptActive;

/**
 * 账号转移
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @param oldMobile 原手机号
 * @param oldPassword 原密码
 * @param newMobile 新手机号
 * @param newPassword 新密码
 * @param newMobileAreaCode 新手机号地区代码
 * @param smsAuthCode 短信验证码
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)changeMobile:(int)appType
                  oldMobile:(NSString*)oldMobile
                oldPassword:(NSString*)oldPassword
                  newMobile:(NSString*)newMobile
                newPassword:(NSString*)newPassword
          newMobileAreaCode:(NSString*)newMobileAreaCode
                smsAuthCode:(NSString*)smsAuthCode;

/**
 * 第三方注册接口
 * @param mainAccount 主账号
 * @param mainAccountPassword 主账号密码
 * @param subAccounts 子账号
 * @param subAccountsPassword 子账号密码
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)userRegister3:(NSString*)mainAccount
         mainAccountPassword:(NSString*)mainAccountPassword
                 subAccounts:(NSMutableArray<NSString*>*)subAccounts
         subAccountsPassword:(NSMutableArray<NSString*>*)subAccountsPassword
                     appType:(int)appType;

/**
 * IPC视频开关(用于开启或关闭IPC的实时视频功能)
 * @param ipcId IPC的ID
 * @param videoSwitchStatus 开关
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)appIpcVideoSwitch:(NSString*)ipcId
               videoSwitchStatus:(BOOL)videoSwitchStatus;

/**
 * 运维音视频权限开关(用于控制运维是否有权限查看该地址下的音视频)
 * @param addressId 地址ID
 * @param avSwitch 开关
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)setOpAVSwitch:(NSString*)addressId
                    avSwitch:(BOOL)avSwitch;

/**
 * 发送短信(自编短信模板)
 * @param mobile 手机号
 * @param areaCode 用户手机地区代码(例如中国大陆为“86”)
 * @param smsTemplate 短信模板
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)appSendSMS:(NSString*)mobile
                 areaCode:(NSString*)areaCode
              smsTemplate:(NSString*)smsTemplate
                  appType:(int)appType;

////////////////////////////////////////////////////////////////////////////////////////////////
// By Address
/**
 * 增加房间(按地址)
 * @param addressId 房间所属地址ID
 * @param roomName 房间名称
 * @param picUrl 房间图片
 * @param roomType 房间类型
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addRoomByAddress:(NSString*)addressId
                       roomName:(NSString*)roomName
                         picUrl:(NSString*)picUrl
                       roomType:(int)roomType;

/**
 * 添加场景(按地址)
 * @param addressId 场景情景所属的地址ID
 * @param scenceEntity 场景实体
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addScenceByAddress:(NSString*)addressId
                     scenceEntity:(AJBScenceEntity*)scenceEntity;

/**
 * 获取所有房间(按地址)
 * @param addressId 要获取房间的地址ID
 * @return 参见AJBGetAllRoom_01
 */
-(AJBGetAllRoom_01*)getAllRoomByAddress:(NSString*)addressId;

/**
 * 获取当前用户属下所有场景(按地址)
 * @param addressId 要获取场景的地址ID
 * @return 参见AJBGetAllScence_01
 */
-(AJBGetAllScence_01*)getAllScenceByAddress:(NSString*)addressId;

/**
 * 获取报警事件列表(按地址)
 * @param addressId 要获取报警事件列表的地址ID
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBReAlarmEventList_02
 */
-(AJBReAlarmEventList_02*)getAlarmEventListByAddress:(NSString*)addressId
                                           pageLimit:(int)pageLimit
                                              offset:(int)offset;

/**
 * 获取报警事件列表(带报警类型及时间段过滤)(按地址)
 * @param addressId 要获取报警事件列表的地址ID
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @param alarmType 查询的报警类型
 * @param beginTime 查询的开始时间
 * @param endTime 查询的结束时间
 * @return 参见AJBReAlarmEventList_02
 */
-(AJBReAlarmEventList_02*)getAlarmEventListByAddress:(NSString*)addressId
                                           pageLimit:(int)pageLimit
                                              offset:(int)offset
                                           alarmType:(int)alarmType
                                           beginTime:(NSString*)beginTime
                                             endTime:(NSString*)endTime;

/**
 * 获取设备事件列表(按地址)
 * @param addressId 要获取设备事件列表的地址ID
 * @param pageLimit 每次查询的事件数量（因事件数量可能巨大，不可能一次性获取全部事件，故用此实现分页）
 * @param offset 查询的偏移量
 * @return 参见AJBReDeviceEventlist_02
 */
-(AJBReDeviceEventlist_02*)getDeviceEventListByAddress:(NSString*)addressId
                                             pageLimit:(int)pageLimit
                                                offset:(int)offset;
////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * 对指定地址邀请指定用户<br/>
 * 即邀请后，该用户可以查看该地址下IPC的音视频，报警消息等信息
 * @param addressId 要邀请的地址ID
 * @param account 要邀请的用户
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressInvitedUserNew:(NSString*)addressId
                             account:(NSString*)account
                             appType:(int)appType;

/**
 * 取消对某个用户的邀请
 * @param addressId 地址ID
 * @param account 要取消邀请的用户手机号
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressNoInvitedUserNew:(NSString*)addressId
                               account:(NSString*)account
                               appType:(int)appType;

/**
 * 对指定地址邀请多个用户<br/>
 * 即邀请后，该用户可以查看该地址下IPC的音视频，报警消息等信息
 * @param addressId 要邀请的地址ID
 * @param accounts 要邀请的用户
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addressInviteMultiUser:(NSString*)addressId
                             accounts:(NSMutableArray<NSString*>*)accounts
                              appType:(int)appType;

/**
 * 定时情景
 * @param scenceId 情景ID
 * @param isOpen 定时情景开关
 * @param openTime 打开定时情景的时间,格式"HH:MM:SS"(isOpen为false时传"")
 * @return 0代表成功，非0代表失败，错误码参见com.anjubao.SDKCommonDef.ErrorCode
 */
-(int)setTimeScence:(NSString*)scenceId
             isOpen:(BOOL)isOpen
           openTime:(NSString*)openTime;

/**
 * 获取单个报警的详细信息
 * @param alarmId 报警ID
 * @return 参见AJBgetAlarmInfo
 */
-(AJBgetAlarmInfo*)GetAlarmInfo:(NSString*)alarmId;

/**
 * 获取批量检查账号是否已注册
 * @param accounts 要检查的批量账号
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 参见AJBMutiUsersExists
 */
-(AJBMutiUsersExists*)mutiUsersExists:(NSMutableArray<NSString*>*)accounts
                              appType:(int)appType;

/**
 * 获取批量注册账号
 * @param accountInfos 要注册的批量账号信息,参见com.anjubao.SDKCommonDef.UserRegister
 * @param appType 应用类型(商铺型1，家居型即安居小宝2)
 * @return 参见AJBMutiUsersRegitser
 */
-(AJBMutiUsersRegitser*)mutiUsersRegister:(NSMutableArray<AJBUserRegister*>*)accountInfos
                                  appType:(int)appType;

/**
 * 获取指定指纹锁已设置的指纹ID与情景绑定关系
 * @param sensorMac 要获取的指纹锁传感器MAC
 * @return 参见AJBGetLockFingerPrint
 */
-(AJBGetLockFingerPrint*)getLockFingerPrint:(NSString*)sensorMac;

/**
 * 添加指定的指纹锁某个指纹ID与情景绑定关系
 * @param fingerPringScence 要添加的绑定关系信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)addLockFingerPrint:(AJBFingerPrintScence*)fingerPringScence;

/**
 * 编辑指定的指纹锁某个指纹ID与情景绑定关系
 * @param fingerPringScence 要编辑的绑定关系信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)editLockFingerPrint:(AJBFingerPrintScence*)fingerPringScence;

/**
 * 删除指定的指纹锁某个指纹ID与情景绑定关系
 * @param fingerPringScence 要删除的绑定关系信息
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)delLockFingerPrint:(AJBFingerPrintScence*)fingerPringScence;

/**
 * 修改IPC的时区设置
 * @param ipcId 要修改时区的IPC的ID
 * @param timeZoneName 时区名称，如"UTC+8"
 * @param timeZoneOffset 时区偏移，以秒数计，如"UTC+8"下为8*3600
 * @return 0代表成功，非0代表失败，错误码参见AJBErrorCode
 */
-(AJBErrorCode)appIPCTimeZone:(NSString*)ipcId
                 timeZoneName:(NSString*)timeZoneName
               timeZoneOffset:(int)timeZoneOffset;

/**
 * 设置IPC TF卡录像策略
 * @param ipcId 要设置录像策略的IPC的ID
 * @param recordPolicy 录像策略，见AJBSetRecord_policy
 * @param forever 是否循环
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)appSetIpcRecording:(NSString*)ipcId
                     recordPolicy:(NSMutableArray<AJBSetRecord_policy*>*)recordPolicy
                          forever:(BOOL)forever;

/**
 * 学习型红外, 添加家电
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeAppliance 家电信息，参见AJBSensorChildEntity
 * @return 参见AJBAddHomeAppliance
 */
-(AJBAddHomeAppliance*)addHomeAppliance:(NSString*)ipcId
                     sensorSerialNumber:(NSString*)sensorSerialNumber
                               sensorId:(NSString*)sensorId
                          homeAppliance:(AJBSensorChildEntity*)homeAppliance;

/**
 * 学习型红外, 获取已添加的家电
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @return 参见AJBGetHomeAppliance
 */
-(AJBGetHomeAppliance*)getHomeAppliance:(NSString*)ipcId
                     sensorSerialNumber:(NSString*)sensorSerialNumber
                               sensorId:(NSString*)sensorId;

/**
 * 学习型红外, 删除家电
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeApplianceId 家电ID
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)delHomeAppliance:(NSString*)ipcId
             sensorSerialNumber:(NSString*)sensorSerialNumber
                       sensorId:(NSString*)sensorId
                homeApplianceId:(NSString*)homeApplianceId;

/**
 * 学习型红外, 删除家电情景
 * @param homeApplianceId 家电ID
 * @param keyScenceArray 要删除的家电情景
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)delAlreadyStudyApplianceScence:(NSString*)homeApplianceId
                               keyScenceArray:(NSMutableArray<AJBApplianceScenceKeySceneInfo*>*)keyScenceArray;

/**
 * 学习型红外, 控制家电
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeApplianceId 家电ID
 * @param keyNumber 按钮编号
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)controlApplianceKeyButton:(NSString*)ipcId
                      sensorSerialNumber:(NSString*)sensorSerialNumber
                                sensorId:(NSString*)sensorId
                         homeApplianceId:(NSString*)homeApplianceId
                               keyNumber:(int)keyNumber;

/**
 * 学习型红外, 编辑家电名称
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeApplianceId 家电ID
 * @param homeApplianceName 家电名称
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)editHomeAppliance:(NSString*)ipcId
              sensorSerialNumber:(NSString*)sensorSerialNumber
                        sensorId:(NSString*)sensorId
                 homeApplianceId:(NSString*)homeApplianceId
               homeApplianceName:(NSString*)homeApplianceName;

/**
 * 上报app语言环境
 * @param languageType 参见com.anjubao.SDKCommonDef.LangType
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)switchLanguage:(AJBLangType)languageType;

/**
 * 学习型红外, 开始学习，key_number代表功能键,不同设备型号功能键意思不一样,空调是学习模式
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeApplianceId 家电ID
 * @param keyNumber 按钮编号
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)startStudyApplianceButton:(NSString*)ipcId
                      sensorSerialNumber:(NSString*)sensorSerialNumber
                                sensorId:(NSString*)sensorId
                         homeApplianceId:(NSString*)homeApplianceId
                               keyNumber:(int)keyNumber;

/**
 * 学习型红外, 学习结束, 将保存在云端
 * @param ipcId IPC的ID
 * @param sensorSerialNumber 红外转发器sensor序列号 mac地址
 * @param sensorId 红外转发器 uuid
 * @param homeApplianceId 家电ID
 * @param keyScence 要保存的家电情景
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)stopStudyApplianceButton:(NSString*)ipcId
                     sensorSerialNumber:(NSString*)sensorSerialNumber
                               sensorId:(NSString*)sensorId
                        homeApplianceId:(NSString*)homeApplianceId
                               isGiveUp:(BOOL)isGiveUp
                              keyScence:(AJBApplianceScenceKeySceneInfo*)keyScence;

/**
 * 获取已学习的按键集合
 * @param ipcId IPC的ID
 * @param homeApplianceId 家电ID
 * @return 参见AJBGetAlreadyStudyApplianceButton
 */
-(AJBGetAlreadyStudyApplianceButton*)getAlreadyStudyApplianceButton:(NSString*)ipcId
                                                    homeApplianceId:(NSString*)homeApplianceId;

/**
 * 编辑空调已学习的模式
 * @param ipcId IPC的ID
 * @param homeApplianceId 家电ID
 * @param keyScenceArray 要编辑的家电情景列表
 * @return 0代表成功，非0代表失败，AJBErrorCode
 */
-(AJBErrorCode)editAlreadyStudyApplianceScence:(NSString*)ipcId
                               homeApplianceId:(NSString*)homeApplianceId
                                keyScenceArray:(NSMutableArray<AJBApplianceScenceKeySceneInfo*>*)keyScenceArray;

@end

@interface AnjubaoSDK : NSObject
/**
 * @return 创建并返回本SDK的一个单例实例，创建失败则返回nil
 */
+(id<AnjubaoSDK>)instance;
@end
