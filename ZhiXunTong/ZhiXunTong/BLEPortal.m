//
//  BLEPortal.m
//  LockSDK
//
//  Created by lujie on 16/7/27.
//  Copyright © 2016年 lujie. All rights reserved.
//

#import "BLEPortal.h"
#import "TIO.h"
#import "TIOManager.h"
#import "BLEMessage.h"

static const unsigned char PACKET_STATUS_START = 0x22;
static const unsigned char PACKET_STATUS_COMPLETE = 0x33;
static const unsigned char PACKET_STATUS_NAK = 0x44;
static const unsigned char PACKET_STATUS_ACK = 0x55;

typedef void (^BLEInnerCB)(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg);

@interface BLEPortal()<TIOManagerDelegate, TIOPeripheralDelegate>
{
    TIOManager *_manager;
    TIOPeripheral *curPeripheral;
    BLEInnerCB curCB;
    int returnCount;
    BLEFindDeviceCB findDeviceCB;
    
    LockState *_state;
}
@end

@implementation BLEPortal

+(id)instance{
    static BLEPortal *instance=nil;
    if (!instance) {
        instance=[[BLEPortal alloc]init];
    }
    return instance;
}

-(id)init{
    self=[super init];
    _manager=[TIOManager sharedInstance];
    [_manager setDelegate:self];
    _timeout=15;
    _isScanning=NO;
    return self;
}

-(void)startScan:(BLEFindDeviceCB)cb{
    findDeviceCB=cb;
    [_manager removeAllPeripherals];
    [_manager startScan];
    _isScanning=YES;
}

-(void)stopScan{
    [_manager stopScan];
    findDeviceCB=nil;
    _isScanning=NO;
}

-(void)setLockName:(NSString *)lockName{
    [self disconnect:nil];
    for (TIOPeripheral *per in _manager.peripherals) {
        if ([per.name containsString:lockName]) {
            _lockName=lockName;
            curPeripheral=per;
            return;
        }
    }
    curPeripheral=nil;
    _lockName=nil;
}

//进行蓝牙连接
-(void)connect:(BLEOperateCB)callback{
    if (_isConnected) {
        callback(YES,BLE_ERROR_NONE,nil);
        return;
    }
    if (!_bleAverable) {
        callback(NO,BLE_ERROR_BLEDISABLE,nil);
        return;
    }
    if (!curPeripheral) {
        callback(NO,BLE_ERROR_PARAM,nil);
        return;
    }
    
    BLEInnerCB cb=^(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg){
        if (isSuc) {
            //校验离线码
            [self checkWithPwd:_pwd cb:callback];
        }
        else{
            [curPeripheral cancelConnection];
            callback(NO,msgCode,nil);
        }
    };
    
    if ([self startMsg:cb]) {
        [self stopScan];
        [curPeripheral connect];
    }
}

//断开蓝牙连接
-(void)disconnect:(BLEOperateCB)cb{
    if (curPeripheral) {
        [curPeripheral cancelConnection];
    }
    if (cb) {
        cb(true,BLE_ERROR_NONE,nil);
    }
}

-(void)checkWithPwd:(NSString *)pwd cb:(BLEOperateCB)callback{
    if (pwd.length!=8) {
        callback(NO,BLE_ERROR_PARAM,nil);
        return;
    }
    
    NSData *data=[pwd dataUsingEncoding:NSUTF8StringEncoding];
    BLEMessage *msg=[[BLEMessage alloc]initWithHead:HEAD_SEND CMD:CMD_CHECK_PWD data:data];
    
    [self sendMsg:msg cb:^(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg){
        if (!callback) {
            return;
        }
        
        if (isSuc) {
            if (msg.head==HEAD_SUC&&msg.cmdCode==msg.cmdCode) {
                Byte *data=(Byte *)[msg.data bytes];
                _state=[[LockState alloc]initWithPower:data[1] state:data[0]];
                callback(YES,BLE_ERROR_NONE,_state);
            }
            else{
                msgCode=BLE_ERROR_IDENTIFY_CHECK_FAILED;
                callback(NO,msgCode,nil);
                [self disconnect:nil];
            }
        }
        else{
            callback(NO,msgCode,nil);
            [self disconnect:nil];
        }
    } waitCount:1];
}

//开锁
-(void)unlock:(BLEOperateCB)callback{
    BLEMessage *msg=[[BLEMessage alloc]initWithHead:HEAD_SEND CMD:CMD_UNLOCK data:nil];
    
    [self sendMsg:msg cb:^(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg){
        if (!callback) {
            return;
        }
        
        if (isSuc) {
            if (msg.head==HEAD_SUC&&msg.cmdCode==msg.cmdCode) {
                if (returnCount==0) {
                    callback(YES,BLE_ERROR_NONE,nil);
                }
            }
            else{
                if (returnCount==0) {
                    msgCode=BLE_ERROR_UNLOCK_FAILED;
                }else{
                    [self endMsg];
                    msgCode=BLE_ERROR_DATA_FORMAT;
                }
                callback(NO,msgCode,nil);
            }
        }
        else{
            callback(NO,msgCode,nil);
        }
    } waitCount:2];
}

//闭锁
-(void)lock:(BLEOperateCB)callback{
    BLEMessage *msg=[[BLEMessage alloc]initWithHead:HEAD_SEND CMD:CMD_LOCK data:nil];
    
    [self sendMsg:msg cb:^(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg){
        if (!callback) {
            return;
        }
        
        if (isSuc) {
            if (msg.head==HEAD_SUC&&msg.cmdCode==msg.cmdCode) {
                if (returnCount==0) {
                    callback(YES,BLE_ERROR_NONE,nil);
                }
            }
            else{
                if (returnCount==0) {
                    msgCode=BLE_ERROR_LOCK_FAILED;
                }else{
                    [self endMsg];
                    msgCode=BLE_ERROR_DATA_FORMAT;
                }
                callback(NO,msgCode,nil);
            }
        }
        else{
            callback(NO,msgCode,nil);
        }
    } waitCount:2];
}

-(void)getState:(BLEOperateCB)callback{
    BLEMessage *msg=[[BLEMessage alloc]initWithHead:HEAD_SEND CMD:CMD_GET_STATE data:nil];
    
    [self sendMsg:msg cb:^(BOOL isSuc,BLE_ERROR msgCode,BLEMessage *msg){
        if (!callback) {
            return;
        }
        
        if (isSuc) {
            if (msg.head==HEAD_SUC&&msg.cmdCode==msg.cmdCode) {
                Byte *data=(Byte *)[msg.data bytes];
                LockState *state=[[LockState alloc]initWithPower:_state.power state:data[0]];
                callback(YES,BLE_ERROR_NONE,state);
            }
            else{
                callback(NO,msgCode,nil);
            }
        }
        else{
            callback(NO,msgCode,nil);
        }
    } waitCount:1];
}

/////////////////////////////////////////////

-(void)sendMsg:(BLEMessage *)msg cb:(BLEInnerCB)cb waitCount:(int)count{
    [self connect:^(BOOL isSuc,BLE_ERROR error,id data){
        if (isSuc) {
            returnCount=count;
            if ([self startMsg:cb]) {
                [self UART_Send:[msg encode]];
            }
        }
        else{
            cb(NO,error,nil);
        }
    }];
}

/////////////////////////////////////////////
- (void)tioManager:(TIOManager *)manager didConnectPeripheral:(TIOPeripheral *)peripheral{
    
    peripheral.shallBeSaved = NO;
    [peripheral setDelegate:self];
    [peripheral connect];
}
- (void)tioManagerBluetoothAvailable:(TIOManager *)manager{
    _bleAverable=YES;
    if (_isScanning) {
        [_manager startScan];
    }else{
        [_manager stopScan];
    }
}

- (void)tioManagerBluetoothUnavailable:(TIOManager *)manager {
    _bleAverable=NO;
}

- (void)tioManager:(TIOManager *)manager didDiscoverPeripheral:(TIOPeripheral *)peripheral
{
    peripheral.shallBeSaved = NO;
    [peripheral setDelegate:self];
    if (findDeviceCB) {
        findDeviceCB(peripheral.name);
    }
}

- (void)tioManager:(TIOManager *)manager didRetrievePeripheral:(TIOPeripheral *)peripheral
{
    peripheral.shallBeSaved = NO;
    [peripheral setDelegate:self];
}

- (void)tioManager:(TIOManager *)manager didUpdatePeripheral:(TIOPeripheral *)peripheral
{
    peripheral.shallBeSaved = NO;
    [peripheral setDelegate:self];
}

- (void)tioPeripheralDidConnect:(TIOPeripheral *)peripheral{
    _isConnected=YES;
    curPeripheral=peripheral;
    if (curCB) {
        BLEInnerCB cb=curCB;
        [self endMsg];
        dispatch_async(dispatch_get_main_queue(), ^{
            cb(YES,BLE_ERROR_NONE,nil);
        });
    }
}
- (void)tioPeripheral:(TIOPeripheral *)peripheral didFailToConnectWithError:(NSError *)error{
    _isConnected=NO;
    if (curCB) {
        BLEInnerCB cb=curCB;
        [self endMsg];
        dispatch_async(dispatch_get_main_queue(), ^{
            cb(NO,BLE_ERROR_NOT_CONNECTED,nil);
        });
    }
}

- (void)tioPeripheral:(TIOPeripheral *)peripheral didDisconnectWithError:(NSError *)error{
    _isConnected=NO;
    if (curCB) {
        BLEInnerCB cb=curCB;
        [self endMsg];
        dispatch_async(dispatch_get_main_queue(), ^{
            cb(NO,BLE_ERROR_NOT_CONNECTED,nil);
        });
    }
}

- (void)tioPeripheral:(TIOPeripheral *)peripheral didReceiveUARTData:(NSData *)data{
    if (curCB) {
        BLEInnerCB cb=curCB;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            BLEMessage *msg=[BLEMessage decode:data];
            if (msg) {
                returnCount--;
                if (returnCount==0) {
                    [self endMsg];
                }
                cb(YES,BLE_ERROR_NONE,msg);
            }
            else{
                [self endMsg];
                cb(NO,BLE_ERROR_DATA_FORMAT,nil);
            }
        });
    }
}

-(NSData *)dataFromHexString:(NSString *)str{
    int len = (int)[str length] / 2;    // Target length
    unsigned char buf[len];
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < len; i++) {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        buf[i] = strtol(byte_chars, NULL, 16);
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    return data;
}

-(NSString *)numStringFromData:(NSData *)data{
    const char *d=[data bytes];
    NSMutableString *res=[NSMutableString string];
    for (int i=0; i<[data length]; i++) {
        char num=d[i];
        [res appendString:[NSString stringWithFormat:@"%2d",num]];
    }
    return res;
}

-(NSData *)dataFromShort:(ushort)sNum{
    unsigned char buf[2];
    buf[0]=(sNum>>8)&0xff;
    buf[1]=sNum&0xff;
    
    NSData *data = [NSData dataWithBytes:buf length:2];
    return data;
}

- (void)UART_Send:(NSData *)data
{
    if (!data||data.length ==0)
        return ;
    
    static int mPacketSequence=0;
    mPacketSequence++;
    
    int dataLenth = (int)data.length;
    
    // 发送长度到下位机 开始
    [self UARTReportStatus:PACKET_STATUS_START length:dataLenth seqID:mPacketSequence withPeripheral:curPeripheral];
    usleep(10000);
    
    int startIdx = 0;
    while (dataLenth >startIdx)
    {
        int writeLen=dataLenth-startIdx;
        writeLen=MIN(writeLen, TIO_MAX_UART_DATA_SIZE);
        NSRange range = {startIdx, writeLen};
        NSData *subData = [data subdataWithRange:range];
        [curPeripheral writeUARTData:subData];
        startIdx += writeLen;
        usleep(10000);
    }
    
    // 发送长度到下位机 结束 在发颜色值
    [self UARTReportStatus:PACKET_STATUS_COMPLETE length:dataLenth seqID:mPacketSequence withPeripheral:curPeripheral];
}

- (void)UARTReportStatus:(Byte)flag length:(int)length seqID:(int)seqId withPeripheral:(TIOPeripheral *)peripheral
{
    Byte packet[5];
    packet[0] = (Byte)(seqId & 0x0ff);
    packet[1] = (Byte)((seqId >> 8) & 0x0ff);
    packet[2] = flag;
    packet[3] = (Byte)(length & 0x0ff);
    packet[4] = (Byte)((length >> 8) & 0x0ff);
    NSData *packetData = [[NSData alloc] initWithBytes:packet length:5];
    [peripheral writeStartBeforeWriteData:packetData];
}

-(BOOL)startMsg:(BLEInnerCB)cb{
    if (curCB) {
        cb(NO,BLE_ERROR_OPERATING,nil);
        return NO;
    }
    curCB=cb;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimeCb) object:nil];
    [self performSelector:@selector(overTimeCb) withObject:nil afterDelay:self.timeout];
    return YES;
}

-(void)endMsg{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(overTimeCb) object:nil];
    curCB=nil;
    returnCount=0;
}

-(void)overTimeCb{
    if (curCB) {
        BLEInnerCB cb=curCB;
        [self endMsg];
        cb(NO,BLE_ERROR_TIMEOUT,nil);
    }
}

@end
