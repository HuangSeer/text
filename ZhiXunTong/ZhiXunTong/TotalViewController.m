//
//  TotalViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TotalViewController.h"
#import "PchHeader.h"
#import "MyCollectionViewCell.h"
#import "ShuJIViewController.h"
#import "ZuZhiViewController.h"
#import "DangYuanViewController.h"
#import "FengcaiViewController.h"
#import "LiveTelecastController.h"
#import "FanfuCLViewController.h"//防腐倡廉
#import "BangfuViewController.h"//精准帮扶
#import "SheQugkViewController.h"//社区概况

#import "DangXiaoViewController.h"//掌上党校
#import "ZhengCeViewController.h"//政策信息
#import "AgreementViewController.h"//诉求提交
#import "QuiryViewController.h"//结果查询
#import "GuideViewController.h" //办事指南
#import "DesireViewController.h"//故障报修
#import "OpenViewController.h"//一键开门
#import "BanShiViewController.h"//预约办事
//#import ""//物业推荐
#import "WuYeQuectViewController.h"//物业查询
#import "GonggaoViewController.h"//小区公告
#import "KuaiDiWebViewController.h"//快递查询
#import "TreatViewController.h"//物业处理公示
#import "WuYewebViewController.h"//web 快递
#import "DangXiaoViewController.h"//掌上党校
#import "ReMenViewController.h"//热门话题
#import "wyTuiJieViewController.h"//物业推荐
#import "TrusteeshipViewController.h"//物业托管
#import "LoginViewController.h"
#import "ZhiNengViewController.h"//智能家居
#import "WGLoginViewController.h"//网格登录
#import "WGHomeViewController.h"//网格home
#import "CheWeiViewController.h"
#import "JiaJuViewController.h"
@interface TotalViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *ClassArray;
    NSArray *classImageArray;
    NSArray *wyClassArray;
    NSArray *wyclassImageArray;
    NSArray *dqClassArray;
    NSArray *dqclassImageArray;
    NSMutableDictionary *userInfo;
    NSString *strcookie;
    NSString *dbCookie;
    NSString *wgname;
    NSString *wgpass;
   NSString *phone;
    int sh;
    id<AnjubaoSDK> sdk;
}

@end

@implementation TotalViewController
static TotalViewController* instance;
@synthesize  serverAddress, appType, appTypeValue, areaTypeValue, isVersion2;
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    strcookie=[userDefaults objectForKey:Cookie];
    wgname=[userDefaults objectForKey:WGname];
    wgpass=[userDefaults objectForKey:WGpass];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
     arry=[userInfo objectForKey:@"Data"];
     phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    NSString *ss=[userDefaults objectForKey:shzts];
    sh=[ss intValue];

}
-(void)connectService
{
    isVersion2 = YES;
    [sdk setVersion2:YES];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [sdk connectService];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self daohangView];
    
    ClassArray = @[@"政策信息",@"诉求提交",@"结果查询",@"办事指南",@"预约办事",@"精准帮扶",@"社区概况",@"网格管理"];
    classImageArray=@[@"zw01.png",@"zw02.png",@"zw03.png",@"zw04.png",@"zw05.png",@"zw06.png",@"zw07.png",@"zw08"];
    wyClassArray = @[@"故障报修",@"物业查询",@"物业托管",@"快递查询",@"智能家居",@"一键开门",@"小区公告",@"热门话题",@"处理公示",@"物业推荐",@"车位管理"];
    wyclassImageArray=@[@"wy01.png",@"wy02.png",@"wy03.png",@"wy04.png",@"wy05.png",@"wy06.png",@"wy07.png",@"wy08.png",@"wy09.png",@"wy10.png",@"wy11.png"];
    dqClassArray = @[@"组织概况",@"书记信箱",@"掌上党校",@"党员管理",@"反腐倡廉",@"党员风采",@"党群活动"];
    dqclassImageArray=@[@"dq01.png",@"dq02.png",@"dq03.png",@"dq04.png",@"dq05.png",@"dq06.png",@"dq07.png",];
    
    [self myCollect];
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title = @"全部分类";
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
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    UICollectionView *homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"new"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    //设置footView的尺寸大小
    layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
    
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return ClassArray.count;
    }
    else if(section==1)
    {
        return wyClassArray.count;
    }
    else if(section==2)
    {
        return dqClassArray.count;
    }
    else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[ClassArray objectAtIndex:indexPath.item]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    else if (indexPath.section==1)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[wyclassImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[wyClassArray objectAtIndex:indexPath.item]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==2)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[dqclassImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[dqClassArray objectAtIndex:indexPath.item]];
        //cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float with = (self.view.bounds.size.width-100) / 4;
    if (indexPath.section==0)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(with, with+20);
    }
    else
    {
        return CGSizeMake(with, with+20);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 0);
    }else if (section==1)
    {
        return CGSizeMake(Screen_Width, 0);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 15);
    }
    else
    {
        return CGSizeMake(Screen_Width, 0);
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 35);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   // if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 3, 80, 29)];
            zclable.textColor=[UIColor whiteColor];
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
            if (zclable.text.length==0) {
                if (indexPath.section==0) {
                    zclable.text=@"政策服务";
                }else if (indexPath.section==1)
                {
                    zclable.text=@"物业服务";
                }else if(indexPath.section==2)
                {
                    zclable.text=@"党群服务";
                }
            }
            [headerView addSubview:zclable];
            headerView.backgroundColor = RGBColor(236, 236, 236);
            return headerView;
        }
    
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor clearColor];
            return footerView;
        }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *msg = cell.botlabel.text;
    //政务服务
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            ZhengCeViewController *zhence=[[ZhengCeViewController alloc] init];
            [self.navigationController pushViewController:zhence animated:NO];
        }else if (indexPath.item==1){
            if (userInfo.count>0) {
                AgreementViewController *agree=[[AgreementViewController alloc] init];
                [self.navigationController pushViewController:agree animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        else if (indexPath.item==2){
            
            QuiryViewController *quiry=[[QuiryViewController alloc] init];
            [self.navigationController pushViewController:quiry animated:NO];
       
        }
        else if (indexPath.item==3){
            GuideViewController *Guide=[[GuideViewController alloc] init];
            [self.navigationController pushViewController:Guide animated:NO];
        }
        else if (indexPath.item==4){
            BanShiViewController *banshi=[[BanShiViewController alloc] init];
             [self.navigationController pushViewController:banshi animated:NO];
        }
        else if (indexPath.item==5){
         
            BangfuViewController * BangfuV=[[BangfuViewController alloc]init];
            [self.navigationController pushViewController:BangfuV animated:NO];
        }
        else if (indexPath.item==6){
         
            SheQugkViewController * SheQugkV=[[SheQugkViewController alloc]init];
            [self.navigationController pushViewController:SheQugkV animated:NO];
        }else if(indexPath.item==7){
            NSString *xstr=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/user/login.do?userName=%@&password=%@",wgname,wgpass];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                NSLog(@"tempCookie------%@",tempCookie.value);
                dbCookie=tempCookie.value;
            }
            if ([dbCookie isEqualToString:strcookie]) {
                NSLog(@"直接去home");
                WGHomeViewController *wgHome=[[WGHomeViewController alloc] init];
                [self.navigationController pushViewController:wgHome animated:NO];
            }else{
                WGLoginViewController *wglog=[[WGLoginViewController alloc] init];
                [self.navigationController pushViewController:wglog animated:NO];
            }
            
            
        }
    }
    //物业服务
    else if (indexPath.section==1)
    {
        if (indexPath.item==0)
        {
            if (userInfo.count>0) {
                NSLog(@"444444");
                DesireViewController *Desire=[[DesireViewController alloc] init];
                [self.navigationController pushViewController:Desire animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        else if (indexPath.item==1){
            if (userInfo.count>0) {
                NSLog(@"444444");
                WuYeQuectViewController *wyquect=[[WuYeQuectViewController alloc] init];
                [self.navigationController pushViewController:wyquect animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
  
        }
        else if (indexPath.item==2){
            if (userInfo.count>0) {
                NSLog(@"444444");
                TrusteeshipViewController *truste=[[TrusteeshipViewController alloc] init];
                [self.navigationController pushViewController:truste animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
     
        }
        else if (indexPath.item==3){
            NSString *aa=@"http://www.skyky.cn";
            NSString *bb=@"快递查询";
            WuYewebViewController *kuaidi=[[WuYewebViewController alloc]initWithCoders:aa Title:bb];
            [self.navigationController pushViewController:kuaidi animated:NO];
        }
        else if (indexPath.item==4){
            NSLog(@"智能家居");
            
            if (userInfo.count>0)
            {
                if (sh==1)
                {
                    int result =[sdk thirdPartyLogin:phone  subAccounts:nil isMainAccountLogin:YES deviceId:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
                    NSLog(@"%@ %d========%@", @"thirdPartyLogin", result,phone);
                    if (result == ErrorCode_ERR_OK) {
                        //                        [iOSToast toast:@"账号登录成功" :1];
                        JiaJuViewController *JiaJuV=[[JiaJuViewController alloc] init];
                        [self.navigationController pushViewController:JiaJuV animated:NO];
                        self.tabBarController.tabBar.hidden=YES;
                        
                    } else {
                        //                        [iOSToast toast:@"账号登录失败" :1];
                    }
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
                }
            }
            else
            {
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }

        }
        else if (indexPath.item==5){
            if (userInfo.count>0) {
               // [SVProgressHUD showErrorWithStatus:@"该小区尚未开通"];
                OpenViewController *open=[[OpenViewController alloc] init];
                [self.navigationController pushViewController:open animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
            
//
        }
        else if (indexPath.item==6){
            if (userInfo.count>0) {
                NSLog(@"444444");
                GonggaoViewController *ggao=[[GonggaoViewController alloc] init];
                [self.navigationController pushViewController:ggao animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }

        }
        else if (indexPath.item==7){
            if (userInfo.count>0) {
                NSLog(@"444444");
                ReMenViewController *remen=[[ReMenViewController alloc] init];
                [self.navigationController pushViewController:remen animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
         
        }
        else if (indexPath.item==8){
            if (userInfo.count>0) {
                NSLog(@"444444");
                TreatViewController *Treat=[[TreatViewController alloc] init];
                [self.navigationController pushViewController:Treat animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
         
        }
        else if (indexPath.item==9){
            if (userInfo.count>0) {
                wyTuiJieViewController *wuye=[[wyTuiJieViewController alloc] init];
                [self.navigationController pushViewController:wuye animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
      
        }
        else if (indexPath.item==10){
            if (userInfo.count>0) {
                CheWeiViewController *CheWei=[[CheWeiViewController alloc] init];
                [self.navigationController pushViewController:CheWei animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
            
        }
    
    }
    //党群服务
    else if(indexPath.section==2){
        if (indexPath.item==0) {
            ZuZhiViewController * ZuZhiV=[[ZuZhiViewController alloc]init];
            [self.navigationController pushViewController:ZuZhiV animated:NO];
        }else if (indexPath.item==1){
            
                ShuJIViewController * ShuJIV=[[ShuJIViewController alloc]init];
                [self.navigationController pushViewController:ShuJIV animated:NO];
                NSLog(@"书记信箱");
      
      
            
        }
        else if (indexPath.item==2){
            DangXiaoViewController *daoxiao=[[DangXiaoViewController alloc] init];
            [self.navigationController pushViewController:daoxiao animated:NO];
             NSLog(@"掌上党校");
        }
        else if (indexPath.item==3){
            DangYuanViewController * DangYuanV=[[DangYuanViewController alloc]init];
            [self.navigationController pushViewController:DangYuanV animated:NO];
             NSLog(@"党员管理");
        }
        else if (indexPath.item==4){
         
                FanfuCLViewController *  FanfuCLV=[[FanfuCLViewController alloc]init];
                [self.navigationController pushViewController: FanfuCLV animated:NO];
                NSLog(@"反腐倡廉");
        
    
        }
        else if (indexPath.item==5){
   
                FengcaiViewController *  FengcaiV=[[FengcaiViewController alloc]init];
                [self.navigationController pushViewController: FengcaiV animated:NO];
                NSLog(@"党员风采");
      
        
            
        }
        else{
                
                LiveTelecastController *  LiveCollectionV=[[LiveTelecastController alloc]init];
                [self.navigationController pushViewController: LiveCollectionV animated:NO];
                NSLog(@"党群活动");
         
            
       
            
        }
        
    
    
    }
    NSLog(@"%@",msg);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
