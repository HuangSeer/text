//
//  AppDelegate.h
//  ZhiXunTong
//
//  Created by Mou on 2017/5/26.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPTabBarViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GPTabBarViewController *tab;
@end

