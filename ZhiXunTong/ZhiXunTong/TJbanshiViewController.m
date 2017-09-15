//
//  TJbanshiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TJbanshiViewController.h"
#import "PchHeader.h"
@interface TJbanshiViewController (){
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    
    UITextField *textName;
    UITextField *textPhone;
    UITextField *textYzm;
    UIButton *yanzheng;
    NSString *Status;
    
}

@end

@implementation TJbanshiViewController
//-(id)initWithTJba:(NSString *)EditDate Period:(NSString *)period HandleClassId:(NSString *)handid{
//    if (self=[super init]){
//        edate=EditDate;
//        perid=period;
//        hanid=handid;
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];//预约办事 认证提交
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    
    [self daohangView];
    [self BuJu];
}
-(void)BuJu
{
    self.view.backgroundColor=RGBColor(236, 236, 236);
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, Screen_height, 30)];
    lable1.text=@"办事信息确认";
    lable1.textColor=[UIColor orangeColor];
    [self.view addSubview:lable1];
    
    UILabel *labletiaoz=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, Screen_Width-20, 35)];
    labletiaoz.text=[NSString stringWithFormat:@"%@",_edate];
    labletiaoz.numberOfLines=0;
    labletiaoz.font=[UIFont systemFontOfSize:13.0f];
    labletiaoz.textColor=[UIColor orangeColor];
    [self.view addSubview:labletiaoz];
    
    UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, Screen_height, 30)];
    lable2.text=@"个人信息填写";
    lable2.textColor=[UIColor orangeColor];
    [self.view addSubview:lable2];
    
    UILabel *lableName=[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 60, 30)];
    lableName.text=@"姓  名:";
     lableName.font=[UIFont systemFontOfSize:13.0f];
      lableName.textAlignment = UITextAlignmentCenter;
//    lableName.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:lableName];
    
    textName=[[UITextField alloc] initWithFrame:CGRectMake(75, 130, Screen_Width-85, 30)];
    textName.borderStyle = UITextBorderStyleLine;
    textName.placeholder=@"用户名";
    [self.view addSubview:textName];
    
    UILabel *lablePhone=[[UILabel alloc] initWithFrame:CGRectMake(10, 165, 60, 30)];
    lablePhone.text=@"手机号:";
    lablePhone.textAlignment=NSTextAlignmentRight;
     lablePhone.font=[UIFont systemFontOfSize:13.0f];
      lablePhone.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:lablePhone];
    
    textPhone=[[UITextField alloc] initWithFrame:CGRectMake(75, 165, Screen_Width-85, 30)];
    textPhone.borderStyle = UITextBorderStyleLine;
    textPhone.placeholder=@"手机号";
    [self.view addSubview:textPhone];
    //验证码
    UILabel *lableYZM=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 60, 30)];
    lableYZM.text=@"验证码:";
    lableYZM.textAlignment=NSTextAlignmentRight;
     lableYZM.font=[UIFont systemFontOfSize:13.0f];
    lableYZM.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:lableYZM];
    
    textYzm=[[UITextField alloc] initWithFrame:CGRectMake(75, 200,(Screen_Width-85)/2-10, 30)];
    textYzm.borderStyle = UITextBorderStyleLine;
    textYzm.placeholder=@"验证码";
    [self.view addSubview:textYzm];
    
     yanzheng= [UIButton buttonWithType:UIButtonTypeCustom];
    yanzheng.frame = CGRectMake((Screen_Width)/2+45, 200,Screen_Width/3, 30);
    yanzheng.backgroundColor = [UIColor redColor];
    [yanzheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yanzheng.titleLabel.font=[UIFont systemFontOfSize:13];
    [yanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzheng addTarget:self action:@selector(BtnYzm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yanzheng];
    
    UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
    denglu.frame = CGRectMake(Screen_Width/2-50, 240, 100, 35);
    denglu.backgroundColor = [UIColor redColor];
    [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    denglu.titleLabel.font=[UIFont systemFontOfSize:20];
    [denglu setTitle:@"确认" forState:UIControlStateNormal];
    denglu.layer.cornerRadius=5;
    
    [denglu addTarget:self action:@selector(BtnQueRen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:denglu];
}
-(void)BtnQueRen
{
    if (textName.text .length!=0 ) {
        if (textPhone.text .length!=0) {
             if ([textYzm.text containsString:Status]) {
       
[[WebClient sharedClient]BanShiTJ:tvinfoId Keys:key Deptid:deptid EditDate:_timess Period:_timess UserName:textName.text MobileNo:textPhone.text HandleClassId:_hanid ResponseBlock:^(id resultObject, NSError *error) {
    NSLog(@"resultObject==%@",resultObject);
    
}];
             
             
             }
        }else{
        
         [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
        }
    }else{
          [SVProgressHUD showErrorWithStatus:@"你输入的姓名有误"];
    
    }
        
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [yanzheng setTitle:@"重新发送" forState:UIControlStateNormal];
                [yanzheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                yanzheng.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [yanzheng setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [yanzheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                yanzheng.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//发送验证码实现的方法
-(void)BtnYzm
{
    if (textPhone.text.length < 11)
    {
        [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:textPhone.text];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:textPhone.text];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:textPhone.text];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            [[WebClient sharedClient] ShoujYZ:tvinfoId Keys:key phone:textPhone.text YZ:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                //                YZM=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                Status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                NSLog(@"%@",resultObject);
                [self openCountdown];
                
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
        }
        
    }

}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"预约办事";
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
