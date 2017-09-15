//
//  LANCommunicationWrapper.m
//  sdk_test
//
//  Created by YangFan on 8/17/16.
//  Copyright © 2016 yangfan. All rights reserved.
//

#import "LANCommunicationWrapper.h"

@interface LANCommunicationWrapper() {
    id<LANCommunication> lan;
    NSHashTable<NSString*>* focusIpcs;
    NSMutableDictionary* map;
    BOOL _start;
}
@end

@implementation LANCommunicationWrapper

-(instancetype)init
{
    self = [super init];
    if (self) {
        lan = [LANCommunication instance];
        [lan setCallback1:self];
        focusIpcs = [[NSHashTable alloc] init];
        map = [[NSMutableDictionary alloc] init];
        _start = NO;
    }
    return self;
}

+(LANCommunicationWrapper*)instance
{
    static LANCommunicationWrapper* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LANCommunicationWrapper alloc] init];
    });
    return instance;
}

-(void)start
{
    @synchronized (self) {
        if (!_start) {
            [lan setActivelySearch:YES];
            [lan enableBroadcast:YES];
            _start = true;
        }
        for (NSString* ipc : focusIpcs) {
            [lan addFocusIpc:ipc];
        }
    }
}

-(void)stop
{
    @synchronized (self) {
        [lan closeLANCommunication];
        [map removeAllObjects];
        _start = false;
    }
}

-(void)addFocusIpc:(NSString*)ipcSerialNumber
{
    @synchronized (self) {
        [focusIpcs addObject:[ipcSerialNumber lowercaseString]];
        if ([focusIpcs count] > [map count]) {
            [lan enableBroadcast:YES];
        }
        [lan addFocusIpc:ipcSerialNumber];
    }
}

-(void)delFocusIpc:(NSString*)ipcSerialNumber
{
    @synchronized (self) {
        [focusIpcs removeObject:[ipcSerialNumber lowercaseString]];
        [lan delFocusIpc:ipcSerialNumber];
    }
}

-(IPCInfo*)getIpcInfo:(NSString*)ipcSerialNumber
{
    return [map objectForKey:[ipcSerialNumber lowercaseString]];
}

-(NSObject*)sendMsgToIpc:(NSString*)ipcSerialNumber :(NSObject*)msg
{
    return [lan sendMsgToIpc:ipcSerialNumber :msg];
}

-(void)onHandleData:(NSString *)ipcSerialNumber :(NSObject *)msg
{
    NSLog(@"onHandleData %@, %@", ipcSerialNumber, msg.class);
}

-(void)onIpcConnect:(NSString *)ipcSerialNumber
{
    NSLog(@"onIpcConnect %@", ipcSerialNumber);
    IPCInfo* info = [lan getIpcInfo:ipcSerialNumber];
    if (info) {
        [map setObject:info forKey:[ipcSerialNumber lowercaseString]];
    }
    if ([map count] == [focusIpcs count]) {
        [lan enableBroadcast:NO];
    }
}

-(void)onIpcDisconnect:(NSString *)ipcSerialNumber
{
    NSLog(@"onIpcDisconnect %@", ipcSerialNumber);
    [map removeObjectForKey:[ipcSerialNumber lowercaseString]];
    if ([map count] < [focusIpcs count]) {
        [lan enableBroadcast:YES];
    }
}

+(void)start
{
    [[LANCommunicationWrapper instance] start];
}

+(void)stop
{
    [[LANCommunicationWrapper instance] stop];
}

+(void)addFocusIpc:(NSString*)ipcSerialNumber
{
    [[LANCommunicationWrapper instance] addFocusIpc:ipcSerialNumber];
}

+(void)delFocusIpc:(NSString*)ipcSerialNumber
{
    [[LANCommunicationWrapper instance] delFocusIpc:ipcSerialNumber];
}

+(IPCInfo*)getIpcInfo:(NSString*)ipcSerialNumber
{
    return [[LANCommunicationWrapper instance] getIpcInfo:ipcSerialNumber];
}

+(NSObject*)sendMsgToIpc:(NSString*)ipcSerialNumber :(NSObject*)msg
{
    return [[LANCommunicationWrapper instance] sendMsgToIpc:ipcSerialNumber :msg];
}

@end
