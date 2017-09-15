//
//  zhuceViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/9.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "zhuceViewController.h"
#import "PchHeader.h"
@interface zhuceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *zhuceTabView;
    UITextField *textUserName;
    UITextField *textUserphone;
    UITextField *textUser;
    UITextField *textUserandpass;
    UITextField *textPass;
    UIButton *yanzheng;//验证码
    
    //NSMutableDictionary *userinfo;
   // NSString *ad;
    NSString *key;
    NSString *tvinfo;
    NSString *deptid;
    NSString *yzm;
}

@end

@implementation zhuceViewController

-(void)viewDidAppear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    tvinfo=[userDefaults objectForKey:TVInfoId];
    deptid=[userDefaults objectForKey:DeptId];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangView];
}
-(void)daohangView
{
    self.navigationItem.title=@"注册";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    zhuceTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    
    zhuceTabView.delegate=self;
    zhuceTabView.dataSource=self;
    [self.view addSubview:zhuceTabView];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 180;
    }
    else
    {
        return 44;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width/2-50, 40, 100, 100)];
        img.image=[UIImage imageNamed:@"APPlogo.png"];
        [cell.contentView addSubview:img];
        cell.backgroundColor=[UIColor clearColor];
    }
    else if (indexPath.row==1)
    {
        UIImageView *nameImg=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 28)];
        nameImg.image=[UIImage imageNamed:@"username"];
        [cell.contentView addSubview:nameImg];
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        textUserName=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-140, 35)];
        textUserName.placeholder=@"用户名";
        [cell.contentView addSubview:textUserName];
    }
    else if (indexPath.row==2)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        UIImageView *nameImg=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 28)];
        nameImg.image=[UIImage imageNamed:@"phone"];
        [cell.contentView addSubview:nameImg];
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        textUserphone=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-140, 35)];
        textUserphone.placeholder=@"请输入绑定手机号";
        [cell.contentView addSubview:textUserphone];
        cell.backgroundColor=[UIColor clearColor];
    }
    else if (indexPath.row==3)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        UIView *shuxian1=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width-120, 13, 0.5, 22)];
        shuxian1.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian1];
        UIImageView *nameImg1=[[UIImageView alloc] initWithFrame:CGRectMake(24, 15, 28, 20)];
        nameImg1.image=[UIImage imageNamed:@"duanxin"];
        [cell.contentView addSubview:nameImg1];
        textUser=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-200, 35)];
        textUser.placeholder=@"验证码";
        [cell.contentView addSubview:textUser];
        
        yanzheng = [UIButton buttonWithType:UIButtonTypeCustom];
        yanzheng.frame = CGRectMake(Screen_Width-105, 10, 100, 30);
        yanzheng.backgroundColor = [UIColor clearColor];
        [yanzheng setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        yanzheng.titleLabel.font=[UIFont systemFontOfSize:13];
        [yanzheng setTitle:@"获取验证码" forState:UIControlStateNormal];
        yanzheng.tag=400;
        [yanzheng addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:yanzheng];
    }
    else if (indexPath.row==4)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        UIImageView *nameImg1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 28)];
        nameImg1.image=[UIImage imageNamed:@"userpass"];
        [cell.contentView addSubview:nameImg1];
        textPass=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-140, 35)];
        textPass.secureTextEntry=YES;
        textPass.placeholder=@"密码";
        [cell.contentView addSubview:textPass];
    }
    else if (indexPath.row==5)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        UIImageView *nameImg1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 28)];
        nameImg1.image=[UIImage imageNamed:@"userpass"];
        [cell.contentView addSubview:nameImg1];
        textUserandpass=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-140, 35)];
        textUserandpass.secureTextEntry=YES;
        textUserandpass.placeholder=@"确认密码";
        [cell.contentView addSubview:textUserandpass];
    }
    else if (indexPath.row==6)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];

        UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuce.frame = CGRectMake(Screen_Width/2-90, 20, 180, 35);
        zhuce.backgroundColor = RGBColor(58, 145, 246);
        [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
        [zhuce setTitle:@"注册" forState:UIControlStateNormal];
        zhuce.layer.cornerRadius=5;
        zhuce.tag=302;
        [zhuce addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:zhuce];
        
    }
    else
    {
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    zhuceTabView.separatorStyle = NO;
    return cell;
    
}
-(void)BtnClick:(UIButton *)btn
{
    if (btn.tag==302) {
       //注册
        NSLog(@"yzm:%@--textUser:%@",yzm,textUser.text);
        if (textUserName.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        }
        else if (textUserphone.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        }
        else if (textUser.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        }
        else if (textUserandpass.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        }
        else if (textPass.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        }else if (textPass.text.length<=6 || textUserandpass.text.length<=6){
            [SVProgressHUD showErrorWithStatus:@"密码不能低于6位数"];
        }
        else if ([yzm isEqualToString:textUser.text] &&[textPass.text isEqualToString:textUserandpass.text]){
            NSLog(@"注册并登录");
            [SVProgressHUD showWithStatus:@"加载中"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 处理耗时的操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[WebClient sharedClient] userName:textUserName.text PassWodr:textPass.text Iphone:textUserphone.text Deptid:deptid ResponseBlock:^(id resultObject, NSError *error) {
                        NSLog(@"resultObject=%@",resultObject);
                        NSLog(@"Message=%@",[resultObject objectForKey:@"Message"]);
                    
                        NSString *user=[resultObject objectForKey:@"Status"];
                        int aa=[user intValue];
                        if (aa==1) {
                            [[NSUserDefaults standardUserDefaults] setObject:resultObject forKey:UserInfo];
                            // [SVProgressHUD dismiss];
                            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                            [self btnCkmore];
                            
                            // [MBProgressHUD hideHUDForView:self.view animated:YES];
                        }else if (aa==0){
                            [SVProgressHUD showErrorWithStatus:@"注册失败"];
                        }
                        else
                        {
                            [SVProgressHUD showErrorWithStatus:@"网络异常"];
                        }
                        [SVProgressHUD dismiss];
                    }];
                });
            });
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"两次密码不对"];
        }
    }
    else if(btn.tag==400)
    {
        if ([self valiMobile:textUserphone.text]==YES) {
            [SVProgressHUD showWithStatus:@"加载中"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 处理耗时的操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[WebClient sharedClient] YZMIphone:textUserphone.text tvinfo:tvinfo keys:key ResponseBlock:^(id resultObject, NSError *error) {
                        NSLog(@"获取验证嘛:%@",resultObject);
                        NSString *aa=[resultObject objectForKey:@"Status"];
                        int bb=[aa integerValue];
                        NSLog(@"%d",bb);
                        if (bb==1) {
                            yzm=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                            [SVProgressHUD showSuccessWithStatus:@"获取成功,请查看手机"];
                            [self btndqsd];
                            
                        }else if(bb==0)
                        {
                            [SVProgressHUD showErrorWithStatus:@"验证码获取失败"];
                        }
                        else{
                            NSLog(@"手机号不对吧");
                        }
                        
                    }];
                });
            });

        }
        else if([self valiMobile:textUserphone.text]==NO){
            [SVProgressHUD showErrorWithStatus:@"手机格式不对"];
        }

    }
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
                [yanzheng setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
