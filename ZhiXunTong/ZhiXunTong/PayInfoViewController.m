//
//  PayInfoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PayInfoViewController.h"
#import "PchHeader.h"

#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "ChengGongViewController.h"
#import "QueRxDViewController.h"
#import "LZCartViewController.h"

@interface PayInfoViewController (){
    NSString *Wei_Zhi;
    NSUInteger leiX;
    NSMutableDictionary *userinfo;
    NSString *phone;
    
    UIButton *button;
    UIButton *button1;
    UIButton *Btn_QD;
}
@end

@implementation PayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"支付方式";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"tongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi2) name:@"tongzhi2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi3:) name:@"tongzhi3" object:nil];
    
    [self payInfoView];
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
    if ([_pandz containsString:@"q"]) {
        for (QueRxDViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[LZCartViewController class]]) {
                LZCartViewController *A =(LZCartViewController *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
        }
    }else{
        
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)payInfoView
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wx_btn)];
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zfb_btn)];
    
    UILabel *Zjia=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 40)];
    Zjia.text=@"总价:";
    [self.view addSubview:Zjia];
    
    UILabel *pri=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-110, 0, 100, 40)];
    pri.textAlignment=NSTextAlignmentRight;
    pri.textColor=[UIColor redColor];
    float jg=[_jiage floatValue];
    pri.text=[NSString stringWithFormat:@"%0.2f",jg];
    [self.view addSubview:pri];
    
    UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(0, 40, Screen_Width, 10)];
    aaView.backgroundColor=RGBColor(245, 245, 245);
    [self.view addSubview:aaView];
    
    UILabel *qxz=[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 150, 40)];
    qxz.text=@"请选择支付方式";
    [self.view addSubview:qxz];
    
    UIView *xianView=[[UIView alloc] initWithFrame:CGRectMake(0, 90, Screen_Width, 1)];
    xianView.backgroundColor=RGBColor(245, 245, 245);
    [self.view addSubview:xianView];
    
    
    UIView *wxView=[[UIView alloc] initWithFrame:CGRectMake(0, 91, Screen_Width, 80)];
    wxView.userInteractionEnabled=YES;
    // wxView.backgroundColor=[UIColor blueColor];
    UIImageView *wximg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    wximg.image=[UIImage imageNamed:@"weixin_pay_logo@2x.png"];
    [wxView addSubview:wximg];
    UILabel *lab_wx=[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 120, 40)];
    lab_wx.text=@"微信支付";
    [wxView addSubview:lab_wx];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(Screen_Width-40, 20, 40, 40);
    [button setImage:[UIImage imageNamed:@"shop_unchose.png"] forState:UIControlStateNormal];
    [wxView addSubview:button];
    [wxView addGestureRecognizer:tapGesture];
    [self.view addSubview:wxView];
    
    UIView *xianView1=[[UIView alloc] initWithFrame:CGRectMake(0, 171, Screen_Width, 1)];
    xianView1.backgroundColor=RGBColor(245, 245, 245);
    [self.view addSubview:xianView1];
    
    UIView *zfView=[[UIView alloc] initWithFrame:CGRectMake(0, 172, Screen_Width, 80)];
    zfView.userInteractionEnabled=YES;
    UIImageView *zfimg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    zfimg.image=[UIImage imageNamed:@"zhifubao@2x.png"];
    [zfView addSubview:zfimg];
    UILabel *lab_zf=[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 120, 40)];
    lab_zf.text=@"支付宝支付";
    [zfView addSubview:lab_zf];
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(Screen_Width-40, 20, 40, 40);
    [button1 setImage:[UIImage imageNamed:@"shop_unchose.png"] forState:UIControlStateNormal];
    [zfView addSubview:button1];
    [zfView addGestureRecognizer:tapGesture1];
    [self.view addSubview:zfView];
    
    UIView *xianView2=[[UIView alloc] initWithFrame:CGRectMake(0, 252, Screen_Width, 1)];
    xianView2.backgroundColor=RGBColor(245, 245, 245);
    [self.view addSubview:xianView2];
    
    
    Btn_QD = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn_QD.frame = CGRectMake(0, Screen_height-104, Screen_Width, 40);
    Btn_QD.backgroundColor = [UIColor greenColor];
    [Btn_QD setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Btn_QD.titleLabel.font=[UIFont systemFontOfSize:20];
    [Btn_QD setTitle:[NSString stringWithFormat:@"确定支付:%0.2f",jg] forState:UIControlStateNormal];
    [Btn_QD addTarget:self action:@selector(BtnClics) forControlEvents:UIControlEventTouchUpInside];
    Btn_QD.userInteractionEnabled=NO;
    Btn_QD.backgroundColor = [UIColor grayColor];
    [self.view addSubview:Btn_QD];
}
-(void)BtnClics{
    if ([Wei_Zhi isEqualToString:@"wx"]) {
        NSLog(@"微信支付");
        [self MoNiLogin];
    }else if ([Wei_Zhi isEqualToString:@"zfb"]){
        //        NSLog(@"支付宝支付");
        [self apliyLogin];
        
        
    }else{
        NSLog(@"您还没有选择支付方式");
    }
}
-(void)apliyLogin{
    //    http://192.168.1.223:8081/shopping/api/aliPay.htm?id=*&subject=*
    
    NSString *strzxt=[[NSString  stringWithFormat:@"指讯通-商城交易"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strurlph=[NSString stringWithFormat:@"%@/shopping/api/aliPay.htm?id=%@&subject=%@",DsURL,_TOId,strzxt];
    [ZQLNetWork getWithUrlString:strurlph success:^(id data) {
        NSString *orderString=[data objectForKey:@"returnData" ];
        NSLog(@"==%@",orderString);
        [[AlipaySDK defaultService] auth_V2WithInfo:orderString  fromScheme:@"alisdkdemo" callback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            NSString *strurl=[NSString stringWithFormat:@"%@aliPayOrderQuery.htm?id=%@",URLds,_TOId];
            
            NSLog(@"strurl==%@",strurl);
            NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [ZQLNetWork getWithUrlString:hString success:^(id data) {
                NSLog(@"失败回掉%@",data);
                NSString *code=[[data objectForKey:@"alipay_trade_query_response"] objectForKey:@"code"];
                NSString *sub_msg=[[data objectForKey:@"alipay_trade_query_response"] objectForKey:@"sub_msg"];
                NSMutableArray *aliArray=[data objectForKey:@"alipay_trade_query_response"] ;
                if ([code containsString:@"10000"]) {
                    [SVProgressHUD showErrorWithStatus:sub_msg];
                    ChengGongViewController *chenggong=[[ChengGongViewController alloc] init];
                    chenggong.aliArray=aliArray;
                    chenggong.CGid=@"支付宝";
                    [self.navigationController pushViewController:chenggong animated:NO];
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:sub_msg];
                }
                
            } failure:^(NSError *error) {
                NSLog(@"回掉%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
            
            
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
        
    } failure:^(NSError *error) {
        NSLog(@"reslut = %@",error);
    }];
    
    
    
}
-(void)MoNiLogin{
    Btn_QD.userInteractionEnabled=NO;
    Btn_QD.backgroundColor = [UIColor grayColor];
    
    NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        NSLog(@"MoNiLogin===%@",data);
        NSString *str=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
        int aa=[str intValue];
        if (aa==200) {
            [SVProgressHUD showWithStatus:@"加载中"];
            NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/wxpay.htm?id=%@&productName=指讯通-商城交易",DsURL,_TOId];
            NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [ZQLNetWork getWithUrlString:hString success:^(id data) {
                NSLog(@"post====%@",data);
                NSLog(@"去支付");
                PayReq *req = [[PayReq alloc] init];
                //调起微信支付
                
                NSMutableString *stamp  = [data objectForKey:@"timestamp"];
                //享去哪
                req.openID              = [data objectForKey:@"appid"];
                req.partnerId           = [data objectForKey:@"partnerid"];
                req.prepayId            = [data objectForKey:@"prepayid"];
                req.nonceStr            = [data objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [data objectForKey:@"package"];
                req.sign                = [data objectForKey:@"sign"];
                [WXApi sendReq:req];
                [SVProgressHUD showSuccessWithStatus:@"前往支付"];
                
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                Btn_QD.userInteractionEnabled=YES;
                Btn_QD.backgroundColor = [UIColor greenColor];
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        Btn_QD.userInteractionEnabled=YES;
        Btn_QD.backgroundColor = [UIColor greenColor];
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)wx_btn{
    NSLog(@"wx");
    Btn_QD.userInteractionEnabled=YES;
    Btn_QD.backgroundColor = [UIColor greenColor];
    Wei_Zhi=@"wx";
    [button setImage:[UIImage imageNamed:@"shop_chose.png"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"shop_unchose.png"] forState:UIControlStateNormal];
}
-(void)zfb_btn{
    NSLog(@"zfb");
    Btn_QD.userInteractionEnabled=YES;
    Btn_QD.backgroundColor = [UIColor greenColor];
    Wei_Zhi=@"zfb";
    [button1 setImage:[UIImage imageNamed:@"shop_chose.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shop_unchose.png"] forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//微信成功回调方法
-(void)tongzhi{
    NSLog(@"返回成功通知的方法1");
    Btn_QD.userInteractionEnabled=YES;
    Btn_QD.backgroundColor = [UIColor greenColor];
    
    ChengGongViewController *chenggong=[[ChengGongViewController alloc] init];
    chenggong.CGid=_TOId;
    [self.navigationController pushViewController:chenggong animated:NO];
    
    Btn_QD.userInteractionEnabled=YES;
    Btn_QD.backgroundColor = [UIColor greenColor];
}
//微信失败回调方法
-(void)tongzhi2{
    //    [SVProgressHUD showWithStatus:@"加载中"];
    Btn_QD.userInteractionEnabled=YES;
    Btn_QD.backgroundColor = [UIColor greenColor];
    
    //    ChengGongViewController *chenggong=[[ChengGongViewController alloc] init];
    //    chenggong.CGid=_TOId;
    //
    //    [self.navigationController pushViewController:chenggong animated:NO];
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/wxPayOrderQuery.htm?id=%@",DsURL,_TOId];
    
    NSLog(@"strurl==%@",strurl);
    NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZQLNetWork getWithUrlString:hString success:^(id data) {
        NSLog(@"失败回掉%@",data);
        NSString *aacc=[data objectForKey:@"returnMsg"];
        [SVProgressHUD showErrorWithStatus:aacc];
    } failure:^(NSError *error) {
        NSLog(@"回掉%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
    
}
- (void)tongzhi3:(NSString *)sender{
    // ooid=sender;
    NSLog(@"－－－－－接收到通知-----重新支付-");
    //NSLog(@"sender%@==%@",sender,ooid);
}

@end
