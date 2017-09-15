//
//  passViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/9.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "passViewController.h"
#import "PchHeader.h"

@interface passViewController ()
{
    UITextField *textiphone;
    UIButton *yanz;
    NSMutableDictionary *userinfo;
    NSString *key;
    NSString *tvinfo;
    NSString *ad;
    NSString *yzm;
    UITextField *textuser;
}

@end

@implementation passViewController
-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    
    ad=[[arry objectAtIndex:0]objectForKey:@"id"];
    key=[userDefaults objectForKey:Key];
    tvinfo=[userDefaults objectForKey:TVInfoId];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView
{
    self.navigationItem.title=@"修改手机号";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    
    UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(40, 50, Screen_Width-80, 35)];
    aa.text=@"输入新的手机号码：";
    [self.view addSubview:aa];
    textiphone=[[UITextField alloc] initWithFrame:CGRectMake(40, 100, Screen_Width-80, 35)];
    textiphone.textAlignment = NSTextAlignmentLeft;
    textiphone.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textiphone];
    textuser=[[UITextField alloc] initWithFrame:CGRectMake(40, 150, (Screen_Width-80)/2, 35)];
    textuser.textAlignment = NSTextAlignmentLeft;
    textuser.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textuser];
    
    
    UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuce.frame = CGRectMake(Screen_Width/2-70, 240, 140, 35);
    zhuce.backgroundColor = [UIColor blueColor];
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
    [zhuce setTitle:@"提交" forState:UIControlStateNormal];
    zhuce.layer.cornerRadius=5;
    zhuce.tag=150;
    [zhuce addTarget:self action:@selector(Btntjiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    yanz = [UIButton buttonWithType:UIButtonTypeCustom];
    yanz.frame = CGRectMake((Screen_Width-80)/2+60, 150, (Screen_Width-80)/2-20, 35);
    yanz.backgroundColor = [UIColor blueColor];
    [yanz setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yanz.titleLabel.font=[UIFont systemFontOfSize:13];
    [yanz setTitle:@"获取验证码" forState:UIControlStateNormal];
    //yanz.tag=151;
    [yanz addTarget:self action:@selector(btnyzm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yanz];
    
    
}
-(void)btnyzm
{
    NSLog(@"去验证啊");
    if (textiphone.text.length==11) {
        MBProgressHUD   *HUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        HUD.labelText = @"正在登录。。。";
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            NSLog(@"%@",@"do somethings....");
            [[WebClient sharedClient] YZMIphone:textiphone.text tvinfo:tvinfo keys:key ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"获取验证嘛:%@",resultObject);
                yzm=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                if (yzm.length>0) {
                    [self btndqs];
                    NSLog(@"获取成功了");
                }
            }];
            
        } completionBlock:^{
            
            [HUD removeFromSuperview];
        }];
       
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.view addSubview:hud];
        hud.labelText=@"手机位数不对";
        [hud hide:YES afterDelay:2];
    }
    
}
//验证码倒计时
-(void)btndqs
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
                [yanz setTitle:@"重新发送" forState:UIControlStateNormal];
                [yanz setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                yanz.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [yanz setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [yanz setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                yanz.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
-(void)Btntjiao
{
    if ([yzm isEqualToString:textuser.text]) {
        [[WebClient sharedClient] Iphone:textiphone.text Tvinfo:tvinfo Keys:key UserId:ad ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"修改成功：%@",resultObject);
            NSLog(@"Message=%@",[resultObject objectForKey:@"Message"]);
            NSString *ss=[resultObject objectForKey:@"Status"];
            int aa=[ss intValue];
            if (aa==1) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:UserInfo];
                NSLog(@"userDefaults:%@",userDefaults);
                [[NSUserDefaults standardUserDefaults] setObject:resultObject forKey:UserInfo];
                NSLog(@"%@",[userDefaults objectForKey:UserInfo]);
                //pop 三级》个人中心
                int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
                if (index>3) {
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-2)] animated:YES];
                }else
                {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
               
                
                
            }else{
                NSLog(@"修改失败");
            }
            
            
        }];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText=@"验证码不对";
        [hud hide:YES afterDelay:2];
    }
    
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
