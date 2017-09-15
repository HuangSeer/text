


//
//  LunWebViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LunWebViewController.h"
#import "PchHeader.h"

@interface LunWebViewController ()<UIWebViewDelegate>{
    
}
@property(strong ,nonatomic) UIWebView * webView;
@end

@implementation LunWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //返回按钮
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    self.navigationItem.title=@"资讯详情";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height)];

        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_panduanstr]];
        [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}
-(void)buttondesire{
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
