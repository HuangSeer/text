//
//  BLEMessage.h
//  LockSDK
//
//  Created by lujie on 16/8/4.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLEMessage : NSObject

@property(strong, nonatomic)NSData *data;
@property(nonatomic)unsigned char cmdCode;
@property(nonatomic)unsigned char head;

-(id)initWithHead:(unsigned char)head CMD:(unsigned char)cmd data:(NSData *)data;

-(NSData *)encode;
+(id)decode:(NSData *)encodeData;

@end
