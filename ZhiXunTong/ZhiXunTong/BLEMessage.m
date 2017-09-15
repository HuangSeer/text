//
//  BLEMessage.m
//  LockSDK
//
//  Created by lujie on 16/8/4.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import "BLEMessage.h"
#import "crc.h"

@implementation BLEMessage

-(id)initWithHead:(unsigned char)head CMD:(unsigned char)cmd data:(NSData *)data{
    self=[super init];
    _head=head;
    _cmdCode=cmd;
    _data=data;
    return self;
}

-(NSData *)encode{
    int len=5+(_data?(int)[_data length]:0);
    
    unsigned char _d[len];
    _d[0]=_head;
    _d[1]=len-4;
    _d[2]=_cmdCode;
    memcpy(_d+3, [_data bytes], len-5);
    _d[len-2]=CRC8_Tab(_d+1,len-3,0x00);
    _d[len-1]=0xaa;
    
    return [NSData dataWithBytes:_d length:len];
}

+(id)decode:(NSData *)encodeData{
    const unsigned char *_d=[encodeData bytes];
    int len=(int)[encodeData length];
    unsigned char crc=CRC8_Tab(_d+1,len-3,0x00);
    if (crc!=_d[len-2]||_d[1]+4!=len) {
        return nil;
    }
    
    unsigned char _head=_d[0];
    unsigned char _cmdCode=_d[2];
    NSData *_data=nil;
    if (len>5) {
        unsigned char _d1[len-5];
        memcpy(_d1, _d+3, len-5);
        _data=[NSData dataWithBytes:_d1 length:len-5];
    }
    
    return [[BLEMessage alloc]initWithHead:_head CMD:_cmdCode data:_data];
}


@end
