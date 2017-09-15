//
//  GPTabBarViewController.m
//  WeiCun001
//
//  Created by shengxun on 14-3-31.
//  Copyright (c) 2014年 com.cn.sx.wc.Junnpy. All rights reserved.
//

#import "GPTabBarViewController.h"
#import "PchHeader.h"
#import "LoginViewController.h"
@interface GPTabBarViewController ()<UITabBarControllerDelegate,UITabBarDelegate>
{
    NSMutableDictionary *userInfo;

}

@end

@implementation GPTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self setDelegate:self];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark 判断是否登录若没登录跳转到登录页面

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
//
    NSLog(@"%@",userInfo);
//    
//    NSUserDefaults *userdefault =;
//    NSString* str = [userdefaultvalueForKey:@"LoginStatu"];
    if([viewController.tabBarItem.title isEqualToString:@"生活"]){//判断点击的tabBarItem的title是不是购物车，如果是继续执行
        if(userInfo==nil){//当登录的时候存储一个标识，判断是否登录过，没登录执行下面代码进入登录页

            NSLog(@"111111");
            LoginViewController *Login = [[LoginViewController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:Login];
            Login.mark = YES;
            [self presentViewController:nav animated:NO completion:nil];
          
        }else{//当登录后直接进入购物车
//            returnYES;
             NSLog(@"2222222");
//            LoginViewController *log=[[LoginViewController alloc] init];
//            [self.navigationController pushViewController:log animated:YES];
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        if (![self.view window])
        {
            self.view = nil;
             [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
    }
}



@end
