//
//  LockState.m
//  BLE_SDK1
//
//  Created by lujie on 16/8/23.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import "LockState.h"

@implementation LockState

-(id)initWithPower:(DEVICE_POWER)power state:(DEVICE_STATE)state{
    self=[super init];
    _power=power;
    _state=state;
    
    return self;
}
@end
