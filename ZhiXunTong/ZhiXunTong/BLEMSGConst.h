//
//  BLEMSGConst.h
//  LockSDK
//
//  Created by lujie on 16/7/28.
//  Copyright © 2016年 lujie. All rights reserved.
//

#ifndef BLEMSGConst_h
#define BLEMSGConst_h

/**
 *  HEAD
 */
#define HEAD_SEND 0x55
#define HEAD_FAILED 0x5b
#define HEAD_SUC 0x5a

/**
 *  CMD
 */
//开锁
#define CMD_UNLOCK 0x01
//闭锁
#define CMD_LOCK 0x02
//设置蓝牙名称
#define CMD_SET_BLE_NAME 0x03
//读取锁状态
#define CMD_GET_STATE 0x06

#define CMD_SET_U_CYCLE 0x07

#define CMD_GET_U_CYCLE 0x08

#define CMD_SET_U_TIME 0x09

#define CMD_GET_U_TIME 0x0a

#define CMD_CHECK_PWD 0x11

#endif /* BLEMSGConst_h */
