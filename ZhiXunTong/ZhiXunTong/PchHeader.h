//
//  PchHeader.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#ifndef PchHeader_h
#define PchHeader_h
//帮助类
#define Screen_Width  [UIScreen mainScreen].bounds.size.width
#define Screen_height  [UIScreen mainScreen].bounds.size.height
//#define Screen_height self.view.bounds.size.height
//#define Screen_Width self.view.bounds.size.height
#define  RGBColor(x,y,z)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
//#define URL @"http://oa.ybqtw.org.cn"
#define URL @"http://192.168.1.222:8099"
#define URLds @"http://119.23.66.177:8080/shopping/api/"
#define WGURL @"http://www.eollse.cn:8080/grid/"
//#define WGURL @"http://192.168.1.223:8081/grid/"

#define DsURL @"http://119.23.66.177:8080"
//#define DsURL @"http://192.168.1.223:8081"

#define MyDpatid @"MyDpatid"
#define UserInfo @"UserInfo"
#define Address @"Address"
#define Key @"Key"
#define TVInfoId @"TVInfoId"
#define DeptId @"DeptId"
#define shzts @"shzt"
#define ALid @"ALid"
#define navtitle @"navtitle"
#define TX @"touxiang"
#define nikName @"nickname"
#define Cookie @"Cookie"
#define Cookiestr @"Cookie"
#define WGname @"WGname"
#define WGpass @"WGpass"


#import <AFNetworking.h>
#import <MJExtension.h>
#import "SDWebImage/SDImageCache.h"
#import "UIImageView+WebCache.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "IQKeyboardManager/KeyboardManager.h"
#import "WebClient.h"
#import "SVProgressHUD.h"
#import "FDAlertView.h"
#import "ZQLNetWork.h"
#endif /* PchHeader_h */



