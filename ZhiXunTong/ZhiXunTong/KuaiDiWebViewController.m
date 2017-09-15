//
//  KuaiDiWebViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "KuaiDiWebViewController.h"
#import "PchHeader.h"
@interface KuaiDiWebViewController (){
    NSString *urlString;
}

@end

@implementation KuaiDiWebViewController
//-(id)initWithCoderk:(NSString *)webUrl
//{
//    if (self=[super init]){
//        urlString=webUrl;
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fanhui];
    urlString=@"http://www.baidu.com";
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height)];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:_webView];
}
-(void)fanhui
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"地区详情";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
