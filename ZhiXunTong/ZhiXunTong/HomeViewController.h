//
//  HomeViewController.h
//  zhixun
//
//  Created by Mou on 2017/5/24.
//  Copyright © 2017年 air. All rights reserved.
//
//
//  HomeViewController.h
//  zhixun
//
//  Created by Mou on 2017/5/24.
//  Copyright © 2017年 air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnjubaoSDK/AnjubaoSDK.h>
#import <AnjubaoSDK/LANCommunication.h>
@interface HomeViewController : UIViewController<AnjubaoSDKPushMessageDelegate, AnjubaoSDKUserOfflineDelegate>
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic,strong)void (^imageBlock)(NSInteger  tap);

@property(nonatomic, readwrite, copy, null_unspecified) NSString* serverAddress;
@property(nonatomic, readwrite, copy, null_unspecified) NSString* appType;
@property(nonatomic, readwrite) int appTypeValue;
@property(nonatomic, readwrite) int areaTypeValue;
@property(nonatomic, readwrite) BOOL isVersion2;

+(nullable HomeViewController*)instance;


@end
