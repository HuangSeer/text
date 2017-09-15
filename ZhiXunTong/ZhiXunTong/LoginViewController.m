//
//  LoginViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LoginViewController.h"
#import "PchHeader.h"
#import "zhuceViewController.h"
#import "wangjiViewController.h"
#import "GeRenViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *logTabView;
    UITextField *textUserName;
        NSMutableDictionary *userInfo;
    UITextField *textPass;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    userInfo=[userDefaults objectForKey:UserInfo];
    [self daohangView];
    
}

-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"登录";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    logTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    
    logTabView.delegate=self;
    logTabView.dataSource=self;
    logTabView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:logTabView];
}
-(void)btnCkmore
{
    if (_mark==YES) {
        if (userInfo==nil) {
            NSLog(@"1111111111---");
            // [self.tab setSelectedIndex:2];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.tab setSelectedIndex:3];
            [self dismissViewControllerAnimated:YES completion:NULL];
            self.tabBarController.tabBar.hidden=NO;
            
        }
        else{
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 180;
    }
    else if (indexPath.row==1)
    {
        return 50;
    }
    else if (indexPath.row==2)
    {
        return 50;
    }
    else if (indexPath.row==3)
    {
        return 44;
    }
    else if (indexPath.row==4)
    {
        return 120;
    }
    else {
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
        UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(65, 13, 0.5, 22)];
        shuxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:shuxian];
        
        UIView *fenxian=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        fenxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:fenxian];
        UIImageView *nameImg1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 28)];
        nameImg1.image=[UIImage imageNamed:@"userpass"];
        [cell.contentView addSubview:nameImg1];
        
        textPass=[[UITextField alloc] initWithFrame:CGRectMake(80, 7, Screen_Width-140, 35)];
        textPass.secureTextEntry = YES;
        textPass.placeholder=@"密码";
        [cell.contentView addSubview:textPass];
    }
    else if (indexPath.row==3)
    {
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        
        UIButton *wangji = [UIButton buttonWithType:UIButtonTypeCustom];
        wangji.frame = CGRectMake(0, 10, 100, 35);
        [wangji setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        wangji.titleLabel.font=[UIFont systemFontOfSize:17];
        [wangji setTitle:@"忘记密码" forState:UIControlStateNormal];
        wangji.tag=200;
        [wangji addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:wangji];
        
        UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuce.frame = CGRectMake(Screen_Width-60, 10, 60, 35);
        [zhuce setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
        [zhuce setTitle:@"注册" forState:UIControlStateNormal];
        zhuce.tag=201;
        [zhuce addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:zhuce];
        
    }
    else if (indexPath.row==4)
    {
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake(Screen_Width/2-90, 50, 180, 35);
        denglu.backgroundColor = RGBColor(58, 145, 246);
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"登录" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        denglu.tag=202;
        [denglu addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    logTabView.separatorStyle = NO;
    return cell;
    
}
-(void)BtnClick:(UIButton *)btn
{
    if (btn.tag==200) {
        NSLog(@"忘记密码");
        wangjiViewController *wangji=[[wangjiViewController alloc] init];
        [self.navigationController pushViewController:wangji animated:NO];
    }
    else if(btn.tag==201)
    {
        NSLog(@"注册");
        zhuceViewController *zhuce=[[zhuceViewController alloc] init];
//        self.hidesBottomBarWhenPushed = YES;
        
//        //self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:zhuce animated:NO];
        
    }
    else if(btn.tag==202)
    {
        if (textUserName.text.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        }
        else if (textPass.text.length==0){
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        }
        if (textUserName.text.length>0 && textPass.text.length>0) {
            [self dengu];
        }
    }
}
-(void)dengu{
   // [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD showProgress:0.3 status:@"loading..." maskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 处理耗时的操作
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[WebClient sharedClient] userName:textUserName.text PassWodr:textPass.text ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"成功%@",resultObject);
                
                NSString *user=[resultObject objectForKey:@"Status"];
                int aa=[user intValue];
                if (aa==1) {
                    [[NSUserDefaults standardUserDefaults] setObject:resultObject forKey:UserInfo];
                    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
                    arry=[resultObject objectForKey:@"Data"];
                    //昵称
                    NSString *aa=[[arry objectAtIndex:0] objectForKey:@"nickname"];
                    NSString *dd=[resultObject objectForKey:@"shzt"];
                    [[NSUserDefaults standardUserDefaults] setObject:aa forKey:nikName];
                    [[NSUserDefaults standardUserDefaults] setObject:dd forKey:shzts];
                    // [SVProgressHUD dismiss];
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                    [self btnCklongok];
                    
                    // [MBProgressHUD hideHUDForView:self.view animated:YES];
                }else if (aa==0){
//                    [SVProgressHUD setMinimumDismissTimeInterval:1];
                    [SVProgressHUD showErrorWithStatus:@"帐号密码错误"];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"网络异常"];
                }
                [SVProgressHUD dismiss];
            }];
        });
    });
    
}

-(void)btnCklongok{
    if (_mark==YES) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
        self.navigationController.navigationBar.hidden=YES;
        self.tabBarController.tabBar.hidden=NO;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
