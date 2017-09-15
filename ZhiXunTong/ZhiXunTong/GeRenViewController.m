//
//  GeRenViewController.m
//  zhixun
//
//  Created by Mou on 2017/5/24.
//  Copyright © 2017年 air. All rights reserved.
//

#import "GeRenViewController.h"
#import "PchHeader.h"
#import "LoginViewController.h"
#import "shezhiViewController.h"
#import "LianXiViewController.h"
#import "WYXiaoXiViewController.h"
#import "FangWuBDViewController.h"
#import "MyQuanBuViewController.h"//我的订单
#import "MyExerciseViewController.h"//我的活动
#import "GRXiaoXiViewController.h"//消息提醒
#import "GRRuanJianViewController.h"//软件设置
#import "LZCartViewController.h"//购物车
@interface GeRenViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *classImageArray;
    NSArray *classArray;
    
    NSArray *yiArray;
    NSArray *erArray;
    NSArray *sanArray;
    NSArray *imgyiArray;
    NSArray *imgerArray;
    NSArray *imgsanArray;
    NSMutableDictionary *userInfo;
    NSString *imgString;
    NSString *username;
    NSString *sh;
}

@end
//个人
@implementation GeRenViewController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBarHidden=YES;//隐藏导航栏
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    username=[userDefaults objectForKey:nikName];
    sh=[userDefaults objectForKey:shzts];
    NSDictionary *ttxx=[userDefaults objectForKey:TX];
    [_tableView reloadData];
    
    NSLog(@"%@----%@",userInfo,ttxx);
    if (userInfo.count>0) {
        NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
        arry=[userInfo objectForKey:@"Data"];
        NSLog(@"%@",ttxx);
        if (ttxx!=nil)
        {
            imgString=[userDefaults objectForKey:TX];
        }
        else
        {
            imgString=[[arry objectAtIndex:0] objectForKey:@"Head_portrait"];
        }
        //  username=[[arry objectAtIndex:0] objectForKey:@"nickname"];
        [_tableView reloadData];
    }else{
        username=@"未登录。。";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabelView];
}
- (void)initTabelView{
    //    classImageArray=@[@"geren01.png",@"geren02.png",@"geren03.png",@"geren04.png",@"geren05.png"];@"门禁绑定",
    classArray=@[@"个人资料",@"房屋绑定",@"物业消息",@"软件版本",@"应用分享",];
    yiArray=@[@"购物车",@"我的订单"];
    erArray=@[@"消息提醒",@"我的活动",@"个人资料"];
    sanArray=@[@"软件设置",@"软件版本",@"应用分享"];
    imgyiArray=@[@"gr_buy_car.png",@"gr_oder.png"];
    imgerArray=@[@"grXiaoxi.png",@"grHuodong.png",@"grZhiliao.png"];
    imgsanArray=@[@"gr_rj_sz.png",@"grBanben.png",@"grFenxiang.png"];
    self.navigationController.navigationBarHidden=YES;
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, -20, Screen_Width, self.view.bounds.size.height+20)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView setTableFooterView:[UIView new]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 170;
    }
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        UIImageView *Movie_View = [[UIImageView alloc]init];
        Movie_View.image=[UIImage imageNamed:@"bakge.png"];
        tableView.tableHeaderView = Movie_View;
        Movie_View.userInteractionEnabled=YES;
        UIImageView *touImag=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width/2-40, 50, 80, 80)];
        touImag.userInteractionEnabled = YES;//打开用户交互
        touImag.layer.masksToBounds=YES;
        touImag.layer.cornerRadius=touImag.bounds.size.width*0.5;
        //touImag.layer.borderWidth=5;
        touImag.layer.borderColor=[UIColor whiteColor].CGColor;
        touImag.backgroundColor=[UIColor clearColor];
        NSString *str=[NSString stringWithFormat:@"%@%@",URL,imgString];
        NSURL *url=[NSURL URLWithString:str];
        [touImag addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gerenBtn)]];
        if (userInfo.count>0) {
            
            NSLog(@"%@",imgString);
            //设置网络图片--默认图片
            [touImag sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headimg.png"]];
            [Movie_View addSubview:touImag];
        }else{
            url=nil;
            [touImag sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headimg.png"]];
            [Movie_View addSubview:touImag];
        }
        
        
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-60, 15, 120, 36)];
        [lable setText:@"个人中心"];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.textColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:21];
        [Movie_View addSubview:lable];
        
        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-60, 130, 120, 36)];
        if (username.length>0) {
            // username=[userDefaults objectForKey:nikName];
            [lable1 setText:[NSString stringWithFormat:@"%@",username]];
        }else{
            [lable1 setText:@"您好,用户名"];
        }
        lable1.textAlignment=NSTextAlignmentCenter;
        lable1.textColor=[UIColor whiteColor];
        lable1.font=[UIFont systemFontOfSize:13];
        [Movie_View addSubview:lable1];
        return tableView.tableHeaderView;
        
    }
    else
    {
        UIView *separateLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0,0,Screen_Width, 5)];
        [separateLineBottom setBackgroundColor:RGBColor(236, 236, 236)];
        [tableView.tableHeaderView addSubview:separateLineBottom];
        return separateLineBottom;
    }
    
}
//个人中心
-(void)gerenBtn
{
    NSLog(@"个人中心");
    if (userInfo.count>0) {
        shezhiViewController *shehzi=[[shezhiViewController alloc] init];
        [self.navigationController pushViewController:shehzi animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }else{
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(55, 0, 80, 44)];
    //nameLabel.text=[NSString stringWithFormat:@"%@",[classArray objectAtIndex:indexPath.section]];
    //[cell.contentView addSubview:nameLabel];
    UIView *Xian=[[UIView alloc] initWithFrame:CGRectMake(10,cell.frame.size.height, Screen_Width-20, 0.5)];
    Xian.backgroundColor=RGBColor(231, 231, 231);
    [cell.contentView addSubview:Xian];
    
    //    youjiantou
    UIImageView *youjiantou=[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width-35, 10, 16, 24)];
    youjiantou.image=[UIImage imageNamed:@"youjiantou.png"];
    [cell.contentView addSubview:youjiantou];
    if(indexPath.section==0){
        //
        nameLabel.text=[NSString stringWithFormat:@"%@",[yiArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:nameLabel];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 24, 24)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgyiArray objectAtIndex:indexPath.row]]];
        [cell.contentView addSubview:imageView];
        
        
    }
    else if (indexPath.section==1)
    {
        nameLabel.text=[NSString stringWithFormat:@"%@",[erArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:nameLabel];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 24, 24)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgerArray objectAtIndex:indexPath.row]]];
        [cell.contentView addSubview:imageView];
    }
    else if (indexPath.section==2)
    {
        nameLabel.text=[NSString stringWithFormat:@"%@",[sanArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:nameLabel];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 24, 24)];
        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgsanArray objectAtIndex:indexPath.row]]];
        [cell.contentView addSubview:imageView];
        if (indexPath.row==1) {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSLog(@"当前应用软件版本:%@",appCurVersion);
            UILabel *lableBB=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-100, 0, 80, 44)];
            lableBB.textAlignment=NSTextAlignmentRight;
            
            lableBB.text=[NSString stringWithFormat:@"V%@",appCurVersion];
            [cell.contentView addSubview:lableBB];
            youjiantou.hidden=YES;
        }else if (indexPath.row==2){
            youjiantou.hidden=YES;
        }
    }
    return cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (userInfo.count>0)
    {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
//                [SVProgressHUD showSuccessWithStatus:@"购物车"];
//                GouWuCheViewController *GouWuChe=[[GouWuCheViewController alloc] init];
//                [self.navigationController pushViewController:GouWuChe animated:NO];
                LZCartViewController *LZCartVi=[[LZCartViewController alloc]init];
                [self.navigationController pushViewController:LZCartVi animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }else{
//                [SVProgressHUD showSuccessWithStatus:@"我的订单"];
                MyQuanBuViewController *Order=[[MyQuanBuViewController alloc] init];
                [self.navigationController pushViewController:Order animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        else if(indexPath.section==1){
            if (indexPath.row==0) {
//                [SVProgressHUD showSuccessWithStatus:@"消息提醒"];
                GRXiaoXiViewController *GRXiaoXi=[[GRXiaoXiViewController alloc]init];
                [self.navigationController pushViewController:GRXiaoXi animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
//                WYXiaoXiViewController *WYXiaoXi=[[WYXiaoXiViewController alloc] init];
//                [self.navigationController pushViewController:WYXiaoXi animated:NO];
            }else if(indexPath.row==1){
//                [SVProgressHUD showSuccessWithStatus:@"我的活动"];
                MyExerciseViewController *MyExercise=[[MyExerciseViewController alloc] init];
                [self.navigationController pushViewController:MyExercise animated:NO];
            }
            else{
//                [SVProgressHUD showSuccessWithStatus:@"个人资料"];
                //个人资料
                shezhiViewController *she=[[shezhiViewController alloc] init];
                [self.navigationController pushViewController:she animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        else if(indexPath.section==2){
            if (indexPath.row==0) {
//                [SVProgressHUD showSuccessWithStatus:@"软件设置"];
                GRRuanJianViewController *GRRuanJian=[[GRRuanJianViewController alloc] init];
                [self.navigationController pushViewController:GRRuanJian animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }else if(indexPath.row==1){
//                [SVProgressHUD showSuccessWithStatus:@"软件版本"];
            }
            else{
//                [SVProgressHUD showSuccessWithStatus:@"应用分享"];
                LianXiViewController *lianxi=[[LianXiViewController alloc] init];
                [self.navigationController pushViewController:lianxi animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        //
        //        if (indexPath.section==0) {
        //            //个人资料
        //            shezhiViewController *she=[[shezhiViewController alloc] init];
        //            [self.navigationController pushViewController:she animated:NO];
        //            self.navigationController.navigationBarHidden=NO;
        //            self.tabBarController.tabBar.hidden=YES;
        //        }
        //        else if (indexPath.section==1){
        //            //房屋绑定
        //            FangWuBDViewController *fangwu=[[FangWuBDViewController alloc] init];
        //            [self.navigationController pushViewController:fangwu animated:NO];
        //            self.navigationController.navigationBarHidden=NO;
        //            self.tabBarController.tabBar.hidden=YES;
        //        }
        //        else if (indexPath.section==2){
        //            if (sh!=nil) {
        //                //物业消息
        //                WYXiaoXiViewController *wuye=[[WYXiaoXiViewController alloc] init];
        //                [self.navigationController pushViewController:wuye animated:YES];
        //                self.navigationController.navigationBarHidden=NO;
        //                self.tabBarController.tabBar.hidden=YES;
        //            }
        //            else
        //            {
        //                [SVProgressHUD showErrorWithStatus:@"您未绑定小区"];
        //            }
        //        }
        //        else if (indexPath.section==3){
        //            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        //            NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        //            NSLog(@"当前应用软件版本:%@",appCurVersion);
        //        }
        //        else if (indexPath.section==4){
        //            //应用分享
        //            LianXiViewController *lianxi=[[LianXiViewController alloc] init];
        //            [self.navigationController pushViewController:lianxi animated:NO];
        //            self.navigationController.navigationBarHidden=NO;
        //            self.tabBarController.tabBar.hidden=YES;
        //        }
    }
    else{
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
