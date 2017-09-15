//
//  LANCommunication.h
//  AnjubaoSDK
//
//  Created by yangfan on 12/10/15.
//  Copyright © 2015 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 局域网IPC信息定义
 */
@interface IPCInfo : NSObject<NSCopying>

/** ipc在局域网中的ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ip;
/** ipc服务端口 */
@property(nonatomic, readwrite)                        int       port;
/** ipc序列号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipcId;
/** ipc所在云端服务的ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* serverIp;
/** ipc网卡mac地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mac;
/** ipc默认网关 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* gateWay;
/** ipc所在子网掩码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* netMask;
/** ipc的dns服务设置 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* dns;
/** ipc在云端注册后获得的uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipcUuid;
/** ipc局域网主码流播放地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mainStreamUrl;
/** ipc局域网子码流播放地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* subStreamUrl;
/** 固件版本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* firmwareVersion;

@end

/**
 * 局域网通讯回调定义
 */
@protocol LANCommunicationDelegate <NSObject>
@optional
/**
 * ipc主动发送的消息(目前只有IpcHeartBeat消息,可忽略不处理)
 * @param ipcId ipc序列号
 * @param msg 消息体
 */
-(void)onHandleData:(nonnull NSString*)ipcId :(nonnull NSData*)msg;
/**
 * ipc连接回调
 * @param ipcId ipc序列号
 */
-(void)onIpcConnect:(nonnull NSString*)ipcId;
/**
 * ipc断线回调
 * @param ipcId ipc序列号
 */
-(void)onIpcDisconnect:(nonnull NSString*)ipcId;
@end

/**
 * 局域网通讯回调定义
 */
@protocol LANCommunicationDelegate1 <NSObject>
@optional
/**
 * ipc主动发送的消息(目前只有IpcHeartBeat消息,可忽略不处理)
 * @param ipcId ipc序列号
 * @param msg 消息体
 */
-(void)onHandleData:(nonnull NSString*)ipcId :(nonnull NSObject*)msg;
/**
 * ipc连接回调
 * @param ipcId ipc序列号
 */
-(void)onIpcConnect:(nonnull NSString*)ipcId;
/**
 * ipc断线回调
 * @param ipcId ipc序列号
 */
-(void)onIpcDisconnect:(nonnull NSString*)ipcId;
@end

/**
 * 局域网通讯接口定义<br/>
 * 本类使用单例模式<br/>
 */
@protocol LANCommunication <NSObject>
/**
 * 设置局域网通讯回调
 * @param callback 见com.anjubao.LANCommunication.Callback定义
 */
-(void)setCallback:(nullable id<LANCommunicationDelegate>)lanCommunicationDelegate;
/**
 * 设置局域网通讯回调
 * @param callback 见com.anjubao.LANCommunication.Callback定义
 */
-(void)setCallback1:(nullable id<LANCommunicationDelegate1>)lanCommunicationDelegate1;
/**
 * 设置是否主动发送用于搜索IPC的广播数据
 * @param active 是否主动,默认非主动式
 */
-(void)setActivelySearch:(BOOL)active;
/**
 * 开启/关闭局域网ipc搜索
 * @param enable true开启/false关闭
 */
-(void)enableBroadcast:(BOOL)enable;
/**
 * 添加指定序列号的需要搜索的ipc
 * @param ipcId ipc序列号
 */
-(void)addFocusIpc:(nonnull NSString*)ipcId;
/**
 * 删除指定序列号的不需要搜索的ipc
 * @param ipcId ipc序列号
 */
-(void)delFocusIpc:(nonnull NSString*)ipcId;
/**
 * 获得当前已搜索到的ipc总数
 */
-(long)getIpcCount;
/**
 * 获得指定序列号的ipc在局域网信息
 * @param ipcId ipc序列号
 */
-(nullable IPCInfo*)getIpcInfo:(nonnull NSString*)ipcId;
/**
 * 获得当前已搜索到的局域网中的所有ipc信息
 */
-(nullable NSMutableArray<IPCInfo*>*)getIpcList;
/**
 * 清除已搜索到的局域网中的ipc的信息
 */
-(void)clearIpcList;
/**
 * 向ipc发送指令
 * @param ipcId ipc序列号
 * @param msg 消息体,现支持DeviceControl、VoiceTalkReqInfo、VoiceTalkStop以及NSData
 */
-(nullable NSObject*)sendMsgToIpc:(nonnull NSString*)ipcId :(nonnull NSObject*)msg;
/**
 * 关闭局域网通讯模块(程序退到后台时调用)
 */
-(void)closeLANCommunication;
@end

@interface LANCommunication : NSObject
/**
 * 获取一个实例
 */
+(nullable id<LANCommunication>)instance;
@end
