//
//  ShiPingViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ShiPingViewController.h"

#import "PchHeader.h"
#import "XjAVPlayerSDK.h"
#import "DangXiaoViewController.h"
@interface ShiPingViewController ()<XjAVPlayerSDKDelegate>{
    XjAVPlayerSDK *myPlayer;
}
//视频播放器
@end

@implementation ShiPingViewController
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭导航栏
       [self.navigationController setNavigationBarHidden:YES animated:YES];
    myPlayer = [[XjAVPlayerSDK alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/1.4)];
    myPlayer.xjPlayerUrl = @"http://192.168.1.222:8099/UpLoadFiles/media/20170419/20170419105544_0302.avi";
    myPlayer.xjPlayerTitle = [NSString stringWithFormat:@"%@",_titlesd];
    myPlayer.xjAutoOrient = YES;
    myPlayer.XjAVPlayerSDKDelegate = self;
    
    [self.view addSubview:myPlayer];

}
- (void)xjGoBack{
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
