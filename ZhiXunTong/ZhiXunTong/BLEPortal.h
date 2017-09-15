//
//  BLEPortal.h
//  LockSDK
//
//  Created by lujie on 16/7/27.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLEConst.h"
#import "BLEMSGConst.h"
#import "LockState.h"

/**
 * 操作回调函数
 * @param isSuc 是否操作成功
 * @param errorCode 错误码，参考BLEConst.h
 * @param data 返回数据，具体参考每个接口方法说明
 */
typedef void (^BLEOperateCB)(BOOL isSuc,BLE_ERROR error,id data);

typedef void (^BLEFindDeviceCB)(NSString *lockName);

@interface BLEPortal : NSObject
//蓝牙设备名
@property(strong, nonatomic)NSString *lockName;
//设备离线码
@property(strong, nonatomic)NSString *pwd;
//蓝牙是否连接
@property(readonly) BOOL isConnected;
//手机蓝牙开关
@property(readonly) BOOL bleAverable;
//是否正在扫描
@property(readonly) BOOL isScanning;
//每条指令的超时时间:秒
@property int timeout;

/**
 * 单例
 */
+(id)instance;


-(void)startScan:(BLEFindDeviceCB)cb;

-(void)stopScan;

/**
 * 进行蓝牙连接
 * @param callback 回调函数
 */
-(void)connect:(BLEOperateCB)callback;

/**
 * 断开蓝牙连接
 * @param callback 回调函数
 */
-(void)disconnect:(BLEOperateCB)callback;

/**
 * 解锁
 * @param callback 回调函数
 */
-(void)unlock:(BLEOperateCB)callback;

/**
 * 闭锁
 * @param callback 回调函数
 */
-(void)lock:(BLEOperateCB)callback;

/**
 * 获取锁状态
 * @param callback 回调函数 data的类型为LockState
 */
-(void)getState:(BLEOperateCB)callback;

@end
