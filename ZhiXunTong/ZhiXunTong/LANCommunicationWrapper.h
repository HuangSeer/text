//
//  LANCommunicationWrapper.h
//  sdk_test
//
//  Created by YangFan on 8/17/16.
//  Copyright © 2016 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AnjubaoSDK/LANCommunication.h>

@interface LANCommunicationWrapper : NSObject<LANCommunicationDelegate1>

+(void)start;
+(void)stop;
+(void)addFocusIpc:(NSString*)ipcSerialNumber;
+(void)delFocusIpc:(NSString*)ipcSerialNumber;
+(IPCInfo*)getIpcInfo:(NSString*)ipcSerialNumber;
+(NSObject*)sendMsgToIpc:(NSString*)ipcSerialNumber :(NSObject*)msg;

@end
