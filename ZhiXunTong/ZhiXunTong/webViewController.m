//
//  webViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "webViewController.h"
#import "PchHeader.h"
@interface webViewController ()<UIWebViewDelegate>{
    NSString *_urlString;
    NSString *_title;
}

@end

@implementation webViewController
-(id)initWithCoderZW:(NSString *)webUrls Title:(NSString *)title
{
    if (self=[super init]){
        _urlString=webUrls;
        _title=title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self fanhui];
    NSLog(@"urlstring=%@",_urlString);
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height-15)];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    [self.view addSubview:_webView];
}
-(void)fanhui
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=_title;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
