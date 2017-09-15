//
//  ZnLoginViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/21.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ZnLoginViewController.h"
#import "PchHeader.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"
#import "JiaJuViewController.h"
#import <AnjubaoSDK/LANCommunication.h>
@interface ZnLoginViewController (){
    id<AnjubaoSDK> sdk;
    BOOL heartBeatThreadStart;
    NSMutableDictionary* mapSubAccount;
    AJBAccountEntity* subAccount;
    
NSMutableDictionary *userInfo;
    NSString *phone;
    UILabel *labzhsz;

}

@end

@implementation ZnLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    heartBeatThreadStart = NO;
    sdk = [AnjubaoSDK instance];
    NSLog(@"2==2=2=2=2======%@",sdk);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    NSLog(@"%@",phone);
    [self initLoginUI];
    self.navigationItem.title=@"可视对讲登录";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)initLoginUI{
    UILabel *labzh=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 40, 25)];
    labzh.text=@"账号:";
    labzh.font=[UIFont systemFontOfSize:14.0f];
    [self.view addSubview:labzh];
    labzhsz=[[UILabel alloc]initWithFrame:CGRectMake(55, 20, Screen_Width-75, 25)];
    labzhsz.text=phone ;
    labzhsz.font=[UIFont systemFontOfSize:14.0f];
    [self.view addSubview:labzhsz];
    UIButton *butdk=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2,65,100, 35)];
    [butdk setTitle:@"登     录" forState:UIControlStateNormal];
    [butdk setFont:[UIFont systemFontOfSize:19.0f]];
    butdk.backgroundColor=[UIColor blueColor];
    [butdk addTarget:self action:@selector(butdkClicklogin) forControlEvents:UIControlEventTouchUpInside];
    [butdk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:butdk];
}
-(void)butdkClicklogin{
    int result =[sdk thirdPartyLogin:@"13220236734"  subAccounts:nil isMainAccountLogin:YES deviceId:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    NSLog(@"%@ %d", @"thirdPartyLogin", result);
    if (result == ErrorCode_ERR_OK) {
        [iOSToast toast:@"账号登录成功" :1];
        JiaJuViewController *JiaJuV=[[JiaJuViewController alloc] init];
        [self.navigationController pushViewController:JiaJuV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
        
    } else {
        [iOSToast toast:@"账号登录失败" :1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
