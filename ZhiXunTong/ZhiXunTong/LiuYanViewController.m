//
//  LiuYanViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/27.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LiuYanViewController.h"
#import "PchHeader.h"
@interface LiuYanViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UITextView *list;
    UILabel *lable1;
    BOOL _wasKeyboardManagerEnabled;
    
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aadptid;
}

@end

@implementation LiuYanViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadptid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    
    [self initView];
    [self MyView];
}
-(void)initView
{
    self.navigationItem.title=@"留言";
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lvse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)MyView
{
    self.view.backgroundColor=RGBColor(236, 236, 236);
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, Screen_Width-20, 50)];
    lable.text=@"请填写你的宝贵意见:";
    [self.view addSubview:lable];
    
    list=[[UITextView alloc] initWithFrame:CGRectMake(10, 60, Screen_Width-20, 160)];
    list.delegate=self;
    [list.layer setCornerRadius:5];
    lable1=[[UILabel alloc] initWithFrame:CGRectMake(3, 3, 160, 20)];
    lable1.text=@"请填写...";
    lable1.font=[UIFont systemFontOfSize:13];
    lable1.enabled=NO;
    [list addSubview:lable1];
    [self.view addSubview:list];
    
    UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
    denglu.frame = CGRectMake(Screen_Width/2-90, 250, 180, 35);
    denglu.backgroundColor = [UIColor greenColor];
    [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    denglu.titleLabel.font=[UIFont systemFontOfSize:17];
    [denglu setTitle:@"提    交" forState:UIControlStateNormal];
    denglu.layer.cornerRadius=5;
    
    [denglu addTarget:self action:@selector(Tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:denglu];
}
-(void)Tijiao
{
    if (list.text.length>0) {
        NSLog(@"提交留言");
        [[WebClient sharedClient] LiuYan:aatvinfo Deid:aadptid Keys:aakey UserId:aaid Content:list.text ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"resultObject=%@",resultObject);
            NSLog(@"%@",error);
            NSString *stat=[resultObject objectForKey:@"Status"];
            int ss=[stat intValue];
            if (ss==1) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                [SVProgressHUD showSuccessWithStatus:@"提交失败"];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"文本不能为空"];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    //self
    if ([list.text length]==0) {
        [lable1 setHidden:NO];
    } else {
        [lable1 setHidden:YES];
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
