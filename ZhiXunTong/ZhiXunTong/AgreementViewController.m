//
//  AgreementViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AgreementViewController.h"
#import "PchHeader.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "MJAd.h"
#import "SbmitViewController.h"
@interface AgreementViewController ()
{
    UITextView *textView;
    NSString *leirong;
    NSString *akey;
    NSString *apeid;
    NSString *atvinfo;
}

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    akey=[userDefaults objectForKey:Key];
    apeid=[userDefaults objectForKey:DeptId];
    atvinfo=[userDefaults objectForKey:TVInfoId];
    [self daohangView];
   
    [self postAFN];
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"诉求协议";
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
-(void)initTextView
{
    UIView *baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    [self.view addSubview:baseView];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-200)];
    textView.text=leirong;
    textView.editable=NO;
    textView.font=[UIFont systemFontOfSize:13];
    [baseView addSubview:textView];
    
    UIButton *yesBtn=[[UIButton alloc] initWithFrame:CGRectMake(20, Screen_height-180, 100, 40)];
    [yesBtn setTitle:@"同意" forState:UIControlStateNormal];
    //[yesBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    yesBtn.backgroundColor=[UIColor greenColor];
    yesBtn.titleLabel.textColor=[UIColor whiteColor];
    [yesBtn addTarget:self
              action:@selector(BtnClick)
    forControlEvents:UIControlEventTouchUpInside];

    [baseView addSubview:yesBtn];
    
    UIButton *noBtn=[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-120, Screen_height-180, 100, 40)];
    [noBtn setTitle:@"不同意" forState:UIControlStateNormal];
    [noBtn addTarget:self
               action:@selector(BtnClicka)
     forControlEvents:UIControlEventTouchUpInside];
    noBtn.backgroundColor=[UIColor redColor];
    noBtn.titleLabel.textColor=[UIColor whiteColor];
    [baseView addSubview:noBtn];
    
}
-(void)BtnClick
{
    NSLog(@"同意");
    SbmitViewController *sbmit=[[SbmitViewController alloc] init];
    self.tabBarController.tabBar.hidden=YES;
    
    [self.navigationController pushViewController:sbmit animated:NO];
}
-(void)BtnClicka{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)postAFN {
    // 1 封装会话管理者
    [SVProgressHUD showWithStatus:@"加载中"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSDictionary *dict = @{
                           @"TVInfoId" : atvinfo,
                           @"Page" : @"1",
                           @"method" : @"OpinionAgreement",
                           @"Key" : akey,
                          
                           };
    // 3 发送请求
    /*http://oa.ybqtw.org.cn/api/APP1.0.aspx?TVInfoId=19&Page=1&method=IndexNews&Key=21218CCA77804D2BA1922C33E0151105&PageSize=6
     第一个参数:请求路径(!不包含参数) 类型是NSString
     以前:http://120.25.226.186:32812/login?username=520it&pwd=123&type=JSON
     现在:http://120.25.226.186:32812/login
     */
    NSString *ss=[NSString stringWithFormat:@"%@/api/APP1.0.aspx",URL];
    [manager POST:ss parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject != nil){
           // NSDictionary *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
           // NSLog(@"str = %@",string);
            MJAd *aa = [MJAd mj_objectWithKeyValues:responseObject];
            leirong=aa.Agreement;
            [self initTextView];
            [SVProgressHUD showSuccessWithStatus:@"数据加载成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误failure---%@", error);
         [SVProgressHUD showErrorWithStatus:@"数据异常"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
