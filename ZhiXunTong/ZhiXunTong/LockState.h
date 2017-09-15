//
//  LockState.h
//  BLE_SDK1
//
//  Created by lujie on 16/8/23.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLEConst.h"

@interface LockState : NSObject

//电量
@property DEVICE_POWER power;
//升降状态
@property DEVICE_STATE state;

-(id)initWithPower:(DEVICE_POWER)power state:(DEVICE_STATE)state;

@end
