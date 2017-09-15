//
//  PropertyViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnjubaoSDK/AnjubaoSDK.h>
#import <AnjubaoSDK/LANCommunication.h>
@interface PropertyViewController : UIViewController<AnjubaoSDKPushMessageDelegate, AnjubaoSDKUserOfflineDelegate>
@property(nonatomic,strong)void (^imageBlock)(NSInteger  tap);

@property(nonatomic, readwrite, copy, null_unspecified) NSString* serverAddress;
@property(nonatomic, readwrite, copy, null_unspecified) NSString* appType;
@property(nonatomic, readwrite) int appTypeValue;
@property(nonatomic, readwrite) int areaTypeValue;
@property(nonatomic, readwrite) BOOL isVersion2;

+(nullable PropertyViewController*)instance;

@end
