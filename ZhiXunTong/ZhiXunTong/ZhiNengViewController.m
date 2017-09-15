//
//  OpenViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ZhiNengViewController.h"
#import "PchHeader.h"

@interface ZhiNengViewController ()
{
    NSArray *classArray;
    NSArray *classArrayImage;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
}

@end

@implementation ZhiNengViewController
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    [self panduan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"智能家居";
    [self daohangView];//导航栏
    
    
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)panduan{
    [[WebClient sharedClient] PanDuan:aatvinfo Keys:aakey State:@"2" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSString *ss=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"URL"]];
        if (ss.length>0) {
            NSString *str=[NSString stringWithFormat:@"%@%@",URL,ss];
            NSLog(@"str=======%@",str);
            NSString *url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height-64)];
            _webView.scalesPageToFit = YES;
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            [self.view addSubview:_webView];
        }
        if (error!=nil) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
        }
    }];
}

-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
