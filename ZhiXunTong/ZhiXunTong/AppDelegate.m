//
//  AppDelegate.m
//  ZhiXunTong
//
//  Created by Mou on 2017/5/26.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AppDelegate.h"
#import "PchHeader.h"
//#import <AFNetworking.h>
#import "HomeViewController.h"
#import "ZhengWuViewController.h"
#import "PropertyViewController.h"
#import "GeRenViewController.h"
#import "DianShangViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
//#import <WXApi.h>
#import "WeiboSDK.h"
//#import "WeiboApi.h"
#import "APIKey.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "WXApiObject.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
//#define APP_KEY @"3438021574"



#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //[NSThread sleepForTimeInterval:3.0];//延长3秒
    //向微信注册wxc8d15ce0ff778ede
    [WXApi registerApp:@"wxd5e092991617315c"];
    [self configureAPIKey];
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat://微信
                 [appInfo SSDKSetupWeChatByAppId:@"wxd5e092991617315c"
                                       appSecret:@"3c736454bfbfc806b95c4548bfac84f3"];
                 break;
             case SSDKPlatformTypeQQ://qq
                 [appInfo SSDKSetupQQByAppId:@"1106286084"
                                      appKey:@"d8I8FCL1L5VO32ND"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    [[UITextField appearance] setTintColor:[UIColor grayColor]];//设置所有文本框光标颜色
    self.tab=[[GPTabBarViewController alloc] initWithNibName:nil bundle:nil];
    if(!IOS7){
        [self.tab.tabBar setTintColor:[UIColor whiteColor]];
    }
    [self.tab setViewControllers:[self initializeViewControllers]];
    //[self.tab setSelectedIndex:2];
    
    [self.window setRootViewController:self.tab];
    
    [self.window makeKeyAndVisible];
    return YES;
}
//高德地图
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}
//微信回调接口
- (void)onResp:(BaseResp *)resp
{
    NSLog(@"resp＝%@",resp);
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
                [SVProgressHUD showWithStatus:@"加载中"];
            case WXSuccess:{
                NSLog(@"支付成功");
                NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:resp];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                break;
            }
            default:{
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                NSNotification *notification2 =[NSNotification notificationWithName:@"tongzhi2" object:nil userInfo:resp];
                [[NSNotificationCenter defaultCenter] postNotification:notification2];
                
                
            }
                break;
        }
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    // 跳转到URL scheme中配置的地址
    NSLog(@"%@",options);
    //NSLog(@"跳转到URL scheme中配置的地址-->%@",url);
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }else{
        
        return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    }
}

//支付成功时调用，回到第三方应用中
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //    NSLog(@"****************url.host -- %@",url.host);
    //    if ([url.scheme isEqualToString:@"wxd5e092991617315c"])
    //    {
    //        return  [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
    //    }
    return YES;
}
#pragma mark- initializeViewControllers
- (NSMutableArray *)initializeViewControllers
{
    NSArray *viewControllerNames = @[
                                     @"HomeViewController",
                                     @"PropertyViewController",
                                     @"DianShangViewController",
                                     @"ZhengWuViewController",
                                     @"GeRenViewController"
                                     ];
    NSArray *tabbarItemImageNames=@[
                                    @{@"selected":@"main_1_2",@"unSelected":@"main_1_1"},
                                    @{@"selected":@"main_2_2",@"unSelected":@"main_2_1"},
                                    @{@"selected":@"main_3_2",@"unSelected":@"main_3_1"},
                                    @{@"selected":@"main_4_2",@"unSelected":@"main_4_1"},
                                    @{@"selected":@"main_5_2",@"unSelected":@"main_5_1"}
                                    ];
    
    NSArray *viewControllerTitles = @[
                                      @{@"navigationTitle":@"",@"tabbarTitle":@"首页"},
                                      @{@"navigationTitle":@"生活",@"tabbarTitle":@"生活"},
                                      @{@"navigationTitle":@"",@"tabbarTitle":@"商城"},
                                      @{@"navigationTitle":@"政务",@"tabbarTitle":@"政务"},
                                      @{@"navigationTitle":@"个人",@"tabbarTitle":@"个人"}
                                      ];
    NSMutableArray *initializedViewControllers = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *name in viewControllerNames) {
        UIViewController *object = [[NSClassFromString(name) alloc] init];
        
        object.title = viewControllerTitles[i][@"navigationTitle"];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:object];
        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
        //navbar.png
        [navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil]];
        [initializedViewControllers addObject:navigationController];
        
        UITabBarItem *tabbarItem;
        if ([tabbarItem respondsToSelector:@selector(initWithTitle:image:selectedImage:)]){
            //            NSLog(@"11111111%@",tabbarItem);
        }else{
            //  tabbarItem=[[UITabBarItem alloc] initWithTitle:viewControllerTitles[i][@"tabbarTitle"] image:[UIImage imageNamed:tabbarItemImageNames[i][@"unSelected"]] selectedImage:[UIImage imageNamed:tabbarItemImageNames[i][@"selected"]]];
            tabbarItem=[[UITabBarItem alloc] init];
            
            UIImage *selectedImage=[UIImage imageNamed:tabbarItemImageNames[i][@"selected"]];
            UIImage *unSelectedImage=[UIImage imageNamed:tabbarItemImageNames[i][@"unSelected"]];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [tabbarItem setSelectedImage:selectedImage];
            [tabbarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unSelectedImage];
            
            if(IOS7){
                [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(65, 141, 42, 1),NSForegroundColorAttributeName, nil] forState:UIControlStateHighlighted];
            }else{
                
                [tabbarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(251, 24, 24, 1),UITextAttributeTextColor, nil] forState:UIControlStateHighlighted];
            }
            
            [tabbarItem setTitle:viewControllerTitles[i][@"tabbarTitle"]];
            //tabbarTitle
            
        }
        
        object.tabBarItem=tabbarItem;
        
        i++;
    }
    
    return initializedViewControllers;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        
    }] ;
}

@end
