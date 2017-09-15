//
//  LianXiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LianXiViewController.h"
#import "PchHeader.h"
#import "HGDQQRCodeView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDK/ShareSDK+Base.h>
@interface LianXiViewController (){
    NSString *erweima;
}

@end

@implementation LianXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self daohangView];
    NSString *str =  [ShareSDK sdkVer];
    NSLog(@"%@",str);
    [[WebClient sharedClient] Stard:@"2" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"成功-------%@",resultObject);
        NSLog(@"error=%@",error);
        NSString *status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
        int aa=[status intValue];
        if (aa==1)
        {
            erweima=[resultObject objectForKey:@"Path"];
            NSLog(@"erweima=%@",erweima);
           
            [self LianXiView];
        }
       
    }];
    
}
-(void)LianXiView{
    NSLog(@"%@",erweima);
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 50, Screen_Width, 35)];
    lab.text=@"分享二维码给好友";
    lab.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab];
    UIImageView *view=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-120)/2, 100, 120, 120)];
    [self.view addSubview:view];
    
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-200)/2, 250, 200, 70)];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:13];
    lab1.text=@"地址:重庆市渝北区黄龙路28号 郎俊中心 3栋6-2";
    lab1.numberOfLines = 2;
    [self.view addSubview:lab1];
    
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, 310, Screen_Width, 35)];
    lab2.text=@"电话:023-67025355";
    lab2.font=[UIFont systemFontOfSize:13];
    lab2.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lab2];
    [HGDQQRCodeView creatQRCodeWithURLString:erweima superView:view logoImage:[UIImage imageNamed:@"erweimaLog.png"] logoImageSize:CGSizeMake(30, 30) logoImageWithCornerRadius:5];
        
}

-(void)daohangView
{
    self.navigationItem.title=@"联系我们";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *LaftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:LaftItemBar];
    
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setTitle:@"分享" forState:UIControlStateNormal];
    //[backFen setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(btnFenXiang) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
}

-(void)btnCkmore{
   
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)btnFenXiang
{
    NSLog(@"分享");
    //1、创建分享参数
    UIImage* imageArray =[UIImage imageNamed:@"wglg.png"];
  //  注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray)
    {
        
//        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"老子天下无敌 http://www.shenzoom.com http://www.mob.com"
//                                                   title:@"这个啥都没有"
//                                                   image:@""
//                                  http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg                   url:[NSURL URLWithString:@"http://www.mob.com"]
//                                                                     latitude:0
//                                                                    longitude:0
//                                                                     objectID:nil
//                                                                         type:SSDKContentTypeAuto];
//         [shareParams SSDKEnableUseClientShare];
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"指讯通是一款智慧社区公共服务综合信息软件，打通了基层政府服务老百姓的最后一公里，包括了党群服务、政务服务、网格治理、平安社区、物业服务、便民服务等全方位信息及服务内容，是社区老百姓必备软件及常用平台。"
                                         images:imageArray
                                            url:[NSURL URLWithString:erweima]
                                          title:@"指讯通"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
        {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               NSLog(@"%@",error);
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
        }];
   }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
