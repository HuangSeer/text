//
//  iphoneViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/9.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "iphoneViewController.h"
#import "PchHeader.h"
#import "passViewController.h"
@interface iphoneViewController (){
    NSMutableDictionary *userinfo;
    NSString *userpwd;
    NSString *useriphone;
    UITextField *textpass;
}

@end

@implementation iphoneViewController
-(void)viewDidAppear:(BOOL)animated{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    userinfo=[userDefaults objectForKey:UserInfo];
//    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
//    arry=[userinfo objectForKey:@"Data"];
//    userpwd=[[arry objectAtIndex:0] objectForKey:@"password"];
//    useriphone=[[arry objectAtIndex:0] objectForKey:@"phone"];
//    NSLog(@"%@",useriphone);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)initView
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    userpwd=[[arry objectAtIndex:0] objectForKey:@"password"];
    useriphone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    NSLog(@"%@",useriphone);
    
    self.navigationItem.title=@"修改手机";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];

    
    UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(40, 50, Screen_Width-80, 35)];
    aa.text=@"您当前绑定的手机号码是：";
    
    UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(40, 70, Screen_Width-80, 35)];
    bb.text=[NSString stringWithFormat:@"%@",useriphone];
    bb.textColor=[UIColor blackColor];
    bb.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:aa];
    [self.view addSubview:bb];
    
    UILabel *cc=[[UILabel alloc] initWithFrame:CGRectMake(40, 110, Screen_Width-80, 35)];
    cc.text=@"登录密码:";
    [self.view addSubview:cc];
    
    textpass=[[UITextField alloc] initWithFrame:CGRectMake(40, 150, Screen_Width-80, 35)];
    textpass.textAlignment = NSTextAlignmentLeft;
     textpass.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textpass];
    
    UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
    zhuce.frame = CGRectMake(Screen_Width/2-70, 240, 140, 35);
    zhuce.backgroundColor = [UIColor blueColor];
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
    [zhuce setTitle:@"下一步" forState:UIControlStateNormal];
    zhuce.layer.cornerRadius=5;
    [zhuce addTarget:self action:@selector(Btnxiugai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)Btnxiugai
{
    if ([textpass.text isEqualToString:userpwd]) {
        passViewController *pass=[[passViewController alloc] init];
        [self.navigationController pushViewController:pass animated:NO];
         NSLog(@"下一步");
    }else{
        NSLog(@"不对哟");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText=@"密码不对!";
        // hud.dimBackground = YES;
        [hud hide:YES afterDelay:2];
    }
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
