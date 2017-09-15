//
//  WGLoginViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/10.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WGLoginViewController.h"
#import "PchHeader.h"
#import "WGHomeViewController.h"
@interface WGLoginViewController ()
{
    UIImageView * ImgView;
    UITextField *textUserName;
    UITextField *textUserPass;
    UITextField *textUserYzm;
    UIButton *yanzheng;//验证码
    NSString *wgYzm;
    NSString *strcookie;

}

@end
//网格登录
@implementation WGLoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangView];
    [self initView];
}
-(void)daohangView
{
    ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    ImgView.userInteractionEnabled=YES;
    [self.view addSubview:ImgView];
    UIImage *image = [UIImage imageNamed:@"wgimg.png"];
    ImgView.image=image;

    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(16, 34, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [ImgView addSubview:backItem];
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(50, 20, Screen_Width-100, 44)];
    labTitle.text=@"网格登录";
    labTitle.textAlignment=NSTextAlignmentCenter;
    labTitle.textColor=[UIColor whiteColor];
    [ImgView addSubview:labTitle];
    
    UIImageView *logView=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-100)/2, 95, 100, 100)];
    
    UIImage *lgimage = [UIImage imageNamed:@"wglg.png"];
    logView.image=lgimage;
    
    [ImgView addSubview:logView];
}
-(void)initView
{
    //用户名
    UIImageView *nameImg=[[UIImageView alloc] initWithFrame:CGRectMake(25, 230, Screen_Width-50, 30)];
    nameImg.userInteractionEnabled=YES;
    nameImg.image=[UIImage imageNamed:@"nameBG.png"];
    [ImgView addSubview:nameImg];
    
    textUserName=[[UITextField alloc] initWithFrame:CGRectMake(50, 4,nameImg.frame.size.width-60, 22)];
    textUserName.placeholder=@"用户名";
//    textUserName.text=@"zs";
    textUserName.backgroundColor=[UIColor whiteColor];
    [nameImg addSubview:textUserName];
    //密码
    UIImageView *passImg=[[UIImageView alloc] initWithFrame:CGRectMake(25, 275, Screen_Width-50, 30)];
    passImg.userInteractionEnabled=YES;
    passImg.image=[UIImage imageNamed:@"nameBG.png"];
    [ImgView addSubview:passImg];
    
    textUserPass=[[UITextField alloc] initWithFrame:CGRectMake(50, 4,nameImg.frame.size.width-60, 22)];
    textUserPass.placeholder=@"密   码";
//    textUserPass.text=@"123";
    textUserPass.backgroundColor=[UIColor whiteColor];
    [passImg addSubview:textUserPass];
    
    //验证码
    UIImageView *yzmImg=[[UIImageView alloc] initWithFrame:CGRectMake(25, 320, Screen_Width-50, 30)];
    yzmImg.userInteractionEnabled=YES;
    yzmImg.image=[UIImage imageNamed:@"nameBG.png"];
    [ImgView addSubview:yzmImg];
    
    textUserYzm=[[UITextField alloc] initWithFrame:CGRectMake(50, 4,100, 22)];
    textUserYzm.placeholder=@"验证码";
    textUserYzm.backgroundColor=[UIColor whiteColor];
    [yzmImg addSubview:textUserYzm];
    
    yanzheng = [UIButton buttonWithType:UIButtonTypeCustom];
    yanzheng.frame = CGRectMake(150, 0, Screen_Width-180, 30);
    yanzheng.backgroundColor = [UIColor clearColor];
    [yanzheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yanzheng.titleLabel.font=[UIFont systemFontOfSize:13];
    [yanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzheng addTarget:self action:@selector(YzmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [yzmImg addSubview:yanzheng];
    
    UIImageView *name=[[UIImageView alloc] initWithFrame:CGRectMake(13, 6, 20, 20)];
    name.image=[UIImage imageNamed:@"name.png"];
    [nameImg addSubview:name];
    UIImageView *pass=[[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 15, 20)];
    pass.image=[UIImage imageNamed:@"pass.png"];
    [passImg addSubview:pass];
    UIImageView *yzm=[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 22, 15)];
    yzm.image=[UIImage imageNamed:@"yzm.png"];
    [yzmImg addSubview:yzm];
    
    UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
    denglu.frame = CGRectMake(Screen_Width/2-75, 400, 150, 35);
    denglu.backgroundColor =[UIColor clearColor];
    [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    denglu.titleLabel.font=[UIFont systemFontOfSize:20];
    [denglu setTitle:@"登录" forState:UIControlStateNormal];
    denglu.layer.cornerRadius=10;
    [denglu.layer setBorderColor:[UIColor blackColor].CGColor];
    [denglu.layer setBorderWidth:1];
    [denglu.layer setMasksToBounds:YES];
    [denglu addTarget:self action:@selector(WgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ImgView addSubview:denglu];
}
-(void)WgBtnClick
{
    NSLog(@"%@=%@",wgYzm,textUserYzm.text);
    if ([wgYzm isEqualToString:textUserYzm.text])
    {
        [SVProgressHUD showWithStatus:@"加载中"];
        [ZQLNetWork postWithUrlString:[NSString stringWithFormat:@"%@app/user/login.do",WGURL] parameters:@{@"userName":textUserName.text,@"password":textUserPass.text,@"code":textUserYzm.text} success:^(id data) {
            NSLog(@"data=%@",data);
            NSString *code=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
           // NSString *Rele=[data objectForKey:@"roleLevel"];
            NSString *message=[data objectForKey:@"message"];
            int aa=[code intValue];
            NSString *xstr=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/user/login.do?userName=%@&password=%@",textUserPass.text,textUserName.text];
            if (aa==200)
            {
                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
                for (NSHTTPCookie *tempCookie in cookies)
                {
                    NSLog(@"tempCookie------%@",tempCookie.value);
                    strcookie=tempCookie.value;
                }
                [[NSUserDefaults standardUserDefaults] setObject:strcookie forKey:Cookie];
                 [[NSUserDefaults standardUserDefaults] setObject:textUserName.text forKey:WGname];
                 [[NSUserDefaults standardUserDefaults] setObject:textUserPass.text forKey:WGpass];
                WGHomeViewController *wghome=[[WGHomeViewController alloc] init];
                [self.navigationController pushViewController:wghome animated:NO];
                NSLog(@"网格登录");
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:message];
            }
        } failure:^(NSError *error) {
            NSLog(@"error=%@",error);
            if (error!=nil) {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
            
        }];
    }
    else
    {
    [SVProgressHUD showErrorWithStatus:@"验证码错误"];
    
    }
}
#pragma 获取验证码
-(void)YzmBtnClick
{
    wgYzm=@"";
    [SVProgressHUD showWithStatus:@"加载中"];
    [ZQLNetWork postWithUrlString:[NSString stringWithFormat:@"%@app/user/getPhoneCaptcha.do",WGURL] parameters:@{@"userName":textUserName.text,@"password":textUserPass.text} success:^(id data) {
        NSLog(@"%@",data);
        NSString *code=[data objectForKey:@"statusCode"];
        NSString *message=[data objectForKey:@"message"];
        int aa=[code intValue];
        if (aa==200) {
            [self btndqsd];
            wgYzm=[NSString stringWithFormat:@"%@",[data objectForKey:@"captcha"]];
            [SVProgressHUD showSuccessWithStatus:message];
        }
        else{
            [SVProgressHUD showErrorWithStatus:message];
        }
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
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
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
//验证码倒计时
-(void)btndqsd
{
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
                [yanzheng setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                yanzheng.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)btnCkmore
{
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
