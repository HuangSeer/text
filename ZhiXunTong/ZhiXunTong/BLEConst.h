//
//  BLEConst.h
//  LockSDK
//
//  Created by lujie on 16/7/28.
//  Copyright © 2016年 lujie. All rights reserved.
//

#ifndef BLEConst_h
#define BLEConst_h


/*
 蓝牙通讯错误编码
 */
typedef NS_ENUM(NSInteger, BLE_ERROR) {
    //无错误
    BLE_ERROR_NONE = 0,
    //身份校验失败
    BLE_ERROR_IDENTIFY_CHECK_FAILED   = 1,
    //通讯超时
    BLE_ERROR_TIMEOUT  = 2,
    //通讯中
    BLE_ERROR_OPERATING   = 3,
    //蓝牙未连接
    BLE_ERROR_NOT_CONNECTED   = 4,
    //通讯数据格式错误
    BLE_ERROR_DATA_FORMAT  = 5,
    //未检测到蓝牙信号
    BLE_ERROR_NO_SIGNAL  = 7,
    //参数错误
    BLE_ERROR_PARAM  = 8,
    //手机未打开蓝牙
    BLE_ERROR_BLEDISABLE  = 9,
    //上升遇阻
    BLE_ERROR_LOCK_FAILED  = 10,
    //下降遇阻
    BLE_ERROR_UNLOCK_FAILED  = 12,
};

typedef NS_ENUM(NSInteger, DEVICE_STATE) {
    DEVICE_STATE_LOCK=0x0,
    DEVICE_STATE_UNLOCK=0x1,
    DEVICE_STATE_UNLOCK_FAILED=0x2,
    DEVICE_STATE_LOCK_FAILED=0x3,
    DEVICE_STATE_UNKNOWN=0x88
};

typedef NS_ENUM(NSInteger, DEVICE_POWER) {
    DEVICE_POWER_NONE=0,
    DEVICE_POWER_LESS=1,
    DEVICE_POWER_HALF=2,
    DEVICE_POWER_FULL=3,
};

#endif /* BLEConst_h */
