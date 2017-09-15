//
//  ZhengWuViewController.m
//  zhixun
//
//  Created by Mou on 2017/5/24.
//  Copyright © 2017年 air. All rights reserved.
//

#import "ZhengWuViewController.h"
#import "SDCycleScrollView.h"
#import <AFNetworking.h>
#import "PchHeader.h"
#import <MJExtension.h>
#import "MJAd.h"
#import "ScrollData.h"
#import "MyCollectionViewCell.h"
#import "NoitceCell.h"
#import "HomeTypeCell.h"
#import "GovernmentCell.h"
#import "PublicCell.h"
#import "YiCollectionReusableView.h"
#import "ErCollectionReusableView.h"
#import "SanCollectionReusableView.h"
#import "lunBoModel.h"
#import "WuYewebViewController.h"
#import "webViewController.h"

#import "wuyetuijieTableViewCell.h"
#import "ReMenModel.h"
#import "DQModel.h"
#import "ZhengCeViewController.h"
#import "AgreementViewController.h"//诉求提交
#import "BanShiViewController.h"//预约办事
#import "QuiryViewController.h"
#import "GDetailsViewController.h"//办理证件
#import "TotalViewController.h"//全部分类  -更多
#import "DangXiaoViewController.h"//掌上党校
#import "ZuZhiViewController.h"//组织概况
#import "ShuJIViewController.h"//书记信箱
#import "DangYuanViewController.h"//党员管理
#import "LoginViewController.h"
@interface ZhengWuViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    //政务服务
    NSArray *classImageArray;
    NSArray *ClassArray;
    //党群服务
    NSArray *dqImageArray;
    NSArray *dqassArray;
    //办事攻略
    NSMutableArray *banImageArray;
//    NSArray *bsassArray;
    //办事指南
    NSMutableArray *zhinanArray;
    //党群风采
    NSMutableArray *dyFengCaiArray;//dyFengCaiArray
    //党群活动
    NSMutableArray *dqHuodongArray;
    UICollectionView *homec;
    YiCollectionReusableView *headerView;
    ErCollectionReusableView *headerView2;
    SanCollectionReusableView *headerView3;
    NSString *akey;
    NSString *apeid;
    NSString *atvinfo;
    NSMutableArray *_LunBoArray;
    UITableView *_zwTableView;
    NSMutableDictionary *userInfo;
}
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;
@property (strong,nonatomic) NSMutableArray *imageUrlArray;
@property (strong,nonatomic) NSMutableArray *titleUrlArray;
@property (strong,nonatomic) NSMutableArray *arrayData;

@end
//政务
@implementation ZhengWuViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      userInfo=[userDefaults objectForKey:UserInfo];
    akey=[userDefaults objectForKey:Key];
    apeid=[userDefaults objectForKey:DeptId];
    atvinfo=[userDefaults objectForKey:TVInfoId];
    _imageUrlArray=[NSMutableArray arrayWithCapacity:0];
    _titleUrlArray=[NSMutableArray arrayWithCapacity:0];
    [self DaoHangView];
    [self getLunBo];
    [self myCollect];
    [self gonglie];//办事攻略
   
}
-(void)DaoHangView
{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"政务";
    ClassArray = @[@"政策信息",@"诉求提交",@"结果查询",@"预约办事"];
    classImageArray=@[@"001.png",@"zw02.png",@"zw03.png",@"zw05.png"];
    
    dqImageArray=@[@"dq01.png",@"dq03.png",@"dq04.png",@"dq02.png"];
    dqassArray=@[@"组织概况",@"掌上党校",@"党员管理",@"书记信箱"];
    
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-64) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [homec registerClass:[HomeTypeCell class] forCellWithReuseIdentifier:@"homeId"];
    [homec registerClass:[NoitceCell class] forCellWithReuseIdentifier:@"notiId"];
    [homec registerClass:[GovernmentCell class] forCellWithReuseIdentifier:@"mentId"];
    [homec registerClass:[PublicCell class] forCellWithReuseIdentifier:@"publicId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    //第一组头视图
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[YiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    [homec registerClass:[ErCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView"];
    [homec registerClass:[SanCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"disanView"];
    
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    
    //设置footView的尺寸大小
    layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
}
#pragma 办事攻略请求
-(void)gonglie
{
    [[WebClient sharedClient] GongLie:atvinfo Keys:akey Deptid:apeid pagesize:@"5" page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
        banImageArray=[[NSMutableArray alloc]initWithArray:[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
            [_zwTableView reloadData];
             [self fengcai];//党员风采
    }];
}
-(void)fengcai{
    [[WebClient sharedClient] FengCai:atvinfo Keys:akey Deptid:apeid pagesize:@"3" page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
        //NSLog(@"党员风采=%@",resultObject);
        dyFengCaiArray=[[NSMutableArray alloc]initWithArray:[DQModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        
        [self huodong];
    }];
}
-(void)huodong
{
    NSLog(@"%@",apeid);
    [[WebClient sharedClient] HuoDong:atvinfo Keys:akey Deptid:apeid pagesize:@"3" page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"党群活动=%@",resultObject);
        dqHuodongArray=[[NSMutableArray alloc]initWithArray:[DQModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        
        //if (dqHuodongArray.count>0) {
           // [homec reloadData];
            [self zwLiuxiang];
        //}
    }];
}
-(void)zwLiuxiang
{
    [[WebClient sharedClient] ZWLiuXiang:atvinfo Keys:akey Deptid:apeid ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"政务六项=%@",resultObject);
        zhinanArray=[[NSMutableArray alloc]initWithArray:[DQModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        //if (dqHuodongArray.count>0) {
            [homec reloadData];
        //}
    }];
}
- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/2) delegate:self placeholderImage:[UIImage imageNamed:@"默认图片"]];
        _topPhotoBoworr.boworrWidth = Screen_Width - 30;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 30;
        //        self.view.userInteractionEnabled
        //        _topPhotoBoworr.autoScroll = NO;
        NSLog(@"%ld",_imageUrlArray.count);
        _topPhotoBoworr.imageURLStringsGroup =_imageUrlArray ;
        _topPhotoBoworr.titlesGroup = _titleUrlArray;
    }
    return _topPhotoBoworr;
}
//点击事件
#pragma 轮播的点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    lunBoModel *mode=[_LunBoArray objectAtIndex:index];
   // NSLog(@"%@",mode.ModuName);
    NSString *webu=[NSString stringWithFormat:@"%@/api/Html/news_show.html?method=home&Tvinfoid=%@&Key=%@&DeptId=%@&id=%@",URL,atvinfo,akey,apeid,mode.NewsId];
    webViewController *web=[[webViewController alloc] initWithCoderZW:webu Title:mode.ModuName];
    [self.navigationController pushViewController:web animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)getLunBo
{
    NSLog(@"%@",apeid);
    [[WebClient sharedClient] getlod:atvinfo Keys:akey Depid:apeid Pagsize:@"6" Status:@"3" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"轮播=%@",resultObject);
        _LunBoArray=[[NSMutableArray alloc]initWithArray:[lunBoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        for (int i=0; i<_LunBoArray.count; i++) {
            lunBoModel *model=[_LunBoArray objectAtIndex:i];
            NSLog(@"ImageIndex==%@  --\n-Title%@",model.ImageIndex,model.Title);
            [_imageUrlArray addObject:model.ImageIndex];
            [_titleUrlArray addObject:model.Title];
        }
        NSLog(@"_imageUrlArray=%@",_imageUrlArray);
       
        _topPhotoBoworr.imageURLStringsGroup = _imageUrlArray;
        _topPhotoBoworr.titlesGroup =_titleUrlArray;
        [self gonglie];
        // [homec reloadData];
    }];
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    else if(section==1)
    {
        return zhinanArray.count;
    }
    else if(section==2)
    {
        return 0;
    }
    else if(section==3)
    {
        return 4;
    }
    else if(section==4)
    {
        return dqHuodongArray.count;
    }
    else if(section==5)
    {
        return dyFengCaiArray.count;
    }
    else
    {
        return 0;
    }
}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.topImage.image=[UIImage imageNamed:[classImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[ClassArray objectAtIndex:indexPath.item]]
        ;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==1)
    {
        //办事指南
        GovernmentCell *cell = (GovernmentCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"mentId" forIndexPath:indexPath];
        DQModel *model=[zhinanArray objectAtIndex:indexPath.item];
        NSString *ss=[NSString stringWithFormat:@"%@%@",URL,model.pic];
        NSURL *myUrl=[NSURL URLWithString:ss];
        [cell.mentImage sd_setImageWithURL:myUrl placeholderImage:[UIImage imageNamed:@""]];
        cell.mentlabel.text = [NSString stringWithFormat:@"%@",model.serve];
        return cell;
    }
    else if (indexPath.section==2)
    {//办事攻略
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==3)
    {//党群服务
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.topImage.image=[UIImage imageNamed:[dqImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[dqassArray objectAtIndex:indexPath.item]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==4)
    {
        //党群活动
        DQModel *model=[dqHuodongArray objectAtIndex:indexPath.item];
        PublicCell *cell = (PublicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"publicId" forIndexPath:indexPath];
        for (UIView *view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
        cell.backgroundColor = RGBColor(236, 236, 236);
        cell.publicTitle.text = [NSString stringWithFormat:@"%@",model.title];
        NSString *urlString=[NSString stringWithFormat:@"%@%@",URL,model.CoverImg];
        cell.publicName.enabled=YES;
        NSLog(@"%@",urlString);
        NSURL *myurl=[NSURL URLWithString:urlString];
        [cell.publicImage sd_setImageWithURL:myurl placeholderImage:[UIImage imageNamed:@"默认图片"]];
        NSString *time=[NSString stringWithFormat:@"%@",model.time];
        NSArray *array = [time componentsSeparatedByString:@" "];
        
        cell.publicTime.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        [cell.contentView addSubview:cell.publicTitle];
        [cell.contentView addSubview:cell.publicImage];
        [cell.contentView addSubview:cell.publicTime];
        return cell;
        
    }
    else if (indexPath.section==5)
    {
        DQModel *model=[dyFengCaiArray objectAtIndex:indexPath.item];
        //党员风采
        PublicCell *cell = (PublicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"publicId" forIndexPath:indexPath];
        cell.backgroundColor =RGBColor(236, 236, 236);
        cell.publicTitle.text = [NSString stringWithFormat:@"%@",model.title];
        NSString *urlString=[NSString stringWithFormat:@"%@%@",URL,model.CoverImg];
        cell.publicTime.enabled=YES;
        NSURL *myurl=[NSURL URLWithString:urlString];
        [cell.publicImage sd_setImageWithURL:myurl placeholderImage:[UIImage imageNamed:@"默认图片"]];
        cell.publicName.text=[NSString stringWithFormat:@"%@",model.intro];
        return cell;
    }
    else
    {
        NoitceCell *cell = (NoitceCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"notiId" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor orangeColor];
        return cell;
    }
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float with = (self.view.bounds.size.width-100) / 4;
    float with1=(self.view.bounds.size.width-60)/2;
    //float with2=(self.view.bounds.size.width-90)/2;
    float with3=self.view.bounds.size.width-20;
    if (indexPath.section==0)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(with1, 60);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(self.view.bounds.size.width, 0.00001);
    }
    else if (indexPath.section==3)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==4)
    {
        return CGSizeMake(with3, 100);
    }
    else if (indexPath.section==5)
    {
        return CGSizeMake(with3, 100);
    }
    else
    {
        return CGSizeMake(Screen_Width, 10);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 10);
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, Screen_Width / 2);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 150);
    }
    else if (section==3)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else if (section==4)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else if (section==5)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 上 左 下 右
    if (section==0) {
        return UIEdgeInsetsMake(40, 20, 10, 20);
    }
    else if (section==1)
    {
        return UIEdgeInsetsMake(6, 20, 20, 20);
    }
    else if (section==2)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else if (section==3)
    {
        return UIEdgeInsetsMake(10, 20, 15, 20);
    }
    else if (section==4)
    {
        return UIEdgeInsetsMake(10, 30, 15, 30);
    }
    else if (section==5)
    {
        return UIEdgeInsetsMake(10, 30, 15, 30);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
#pragma mark ----- 重用的问题
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]==YES)
    {
        if(indexPath.section==0)
        {
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
            if (_LunBoArray.count>0) {
                [headerView addSubview:self.topPhotoBoworr];
                headerView.yiLable.text=@"政务服务";
                
                UIButton *buttoubgd=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-Screen_Width/4.8, Screen_height/3.65, Screen_Width/6, Screen_height/15)];
                [buttoubgd setTitle:@"更多>>" forState:UIControlStateNormal];
                buttoubgd.backgroundColor = [UIColor clearColor];
                [buttoubgd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                buttoubgd.titleLabel.font=[UIFont systemFontOfSize:13];
                [buttoubgd addTarget:self action:@selector(buttoubcellrigh) forControlEvents:UIControlEventTouchUpInside];
                [homec addSubview:buttoubgd];
                headerView.backgroundColor = [UIColor orangeColor];
            }
            
            
            return headerView;
        }
        else if (indexPath.section==1)
        {
            headerView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            headerView2.erLable.text=@"办事指南";
            headerView2.xianView2.backgroundColor=[UIColor whiteColor];
            
            return headerView2;
        }
        else if (indexPath.section==2)
        {
            headerView3 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"disanView" forIndexPath:indexPath];
            
            headerView3.erLable.text=@"办事攻略";
            _zwTableView=[[UITableView alloc] init];
            _zwTableView.dataSource=self;
            _zwTableView.delegate=self;
            _zwTableView.separatorStyle = NO;
            //对TableView要做的设置
            _zwTableView.transform=CGAffineTransformMakeRotation(-M_PI / 2);
            _zwTableView.showsVerticalScrollIndicator=NO;
            _zwTableView.frame=CGRectMake(0, 31, Screen_Width, 110);
            [headerView3 addSubview:_zwTableView];

            return headerView3;
        }
        else if (indexPath.section==3)
        {
            headerView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            headerView2.erLable.text=@"党群服务";
            return headerView2;
        }
        else if (indexPath.section==4)
        {
            headerView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            headerView2.xianView2.backgroundColor=[UIColor blackColor];
            headerView2.erLable.text=@"党群活动";
            
            return headerView2;
        }
        else if (indexPath.section==5)
        {
            headerView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
           
            headerView2.erLable.text=@"党员风采";
            return headerView2;
        }
        else
        {
            headerView2 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            for (UIView *view in headerView2.subviews) {
                [view removeFromSuperview];
            }
            return headerView2;
        }
    }
    else
    {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            for (UIView *view in footerView.subviews) {
                [view removeFromSuperview];
            }
            footerView.backgroundColor = RGBColor(236, 236, 236);

            return footerView;
    }
}

#pragma 三个更多按钮
-(void)zwBtnClick:(UIButton *)btn
{
    if (btn.tag==10000) {
        NSLog(@"10000");
//        ReMenViewController *remen=[[ReMenViewController alloc] init];
//        [self.navigationController pushViewController:remen animated:NO];
//        self.tabBarController.tabBar.hidden=YES;//隐藏tabbar
    }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //MyCollectionViewCell
        if (indexPath.item==0)
        {
            ZhengCeViewController *zc=[[ZhengCeViewController alloc] init];
            [self.navigationController pushViewController:zc animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==1)
        {
            AgreementViewController *am=[[AgreementViewController alloc] init];
            [self.navigationController pushViewController:am animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==2)
        {
            //查询
            QuiryViewController *qu=[[QuiryViewController alloc] init];
            [self.navigationController pushViewController:qu animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==3)
        {
            BanShiViewController *bs=[[BanShiViewController alloc] init];
            [self.navigationController pushViewController:bs animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
    }
    else if (indexPath.section==1)
    {//办理证件
        DQModel *mode=[zhinanArray objectAtIndex:indexPath.item];
        NSLog(@"%@----%@",mode.serve,mode.Eid);
        GDetailsViewController *gdetails=[[GDetailsViewController alloc] initGDetaile:mode.categoryid Serve:mode.serve Procedures:mode.procedures Materials:mode.materials Responsible:mode.Responsible];
        [self.navigationController pushViewController:gdetails animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else if (indexPath.section==2)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NSString *msg = cell.botlabel.text;
        NSLog(@"%@",msg);
    }
    else if (indexPath.section==3)
    {
        if (indexPath.item==0) {
            ZuZhiViewController *zuzhi=[[ZuZhiViewController alloc] init];
            [self.navigationController pushViewController:zuzhi animated:NO];
        }
        else if(indexPath.item==1)
        {
            NSLog(@"222222");
            DangXiaoViewController *daa=[[DangXiaoViewController alloc] initDangQun:_imageUrlArray Serve:_titleUrlArray];
          
            [self.navigationController pushViewController:daa animated:NO];
            
        }
        else if(indexPath.item==2)
        {
            NSLog(@"333333");
            DangYuanViewController *dangyuan=[[DangYuanViewController alloc] init];
            [self.navigationController pushViewController:dangyuan animated:NO];
        }
        else if(indexPath.item==3) {
            
            if (userInfo.count>0) {
                NSLog(@"444444");
                ShuJIViewController *shuji=[[ShuJIViewController alloc] init];
                [self.navigationController pushViewController:shuji animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
       
        }
        self.tabBarController.tabBar.hidden=YES;
    }
    else if (indexPath.section==4)
    {//党群活动
        DQModel *model=[dqHuodongArray objectAtIndex:indexPath.item];
        NSLog(@"id=%@",model.id);
        NSString *strurl=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=Activities&id=%@&Key=%@&TVInfoId=%@&Deptid=%@",URL,model.id,akey,atvinfo,apeid];
        ///api/Html/pion.html
        
        webViewController *webs=[[webViewController alloc] initWithCoderZW:strurl Title:@"党群活动"];
        [self.navigationController pushViewController:webs animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else if(indexPath.section==5)
    {
        //党员风采
        NSLog(@"%ld",indexPath.item);
        DQModel *model=[dyFengCaiArray objectAtIndex:indexPath.item];
        NSLog(@"党员风采id=%@",model.id);
        NSString *strurl=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=pioneer&id=%@",URL,model.id];
        webViewController *webs=[[webViewController alloc] initWithCoderZW:strurl Title:@"党员风采"];
        [self.navigationController pushViewController:webs animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    
}



//#pragma mark tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return _oneDataArray.count;
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_Width-60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wuyetuijieTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"wuyetuijieTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    if (banImageArray.count>0) {
        ReMenModel *mode=[banImageArray objectAtIndex:indexPath.row];
        //对Cell要做的设置
        
        cell.lable_title.frame=CGRectMake(10, 80, Screen_Width-80, 30);
        cell.img_bakeg.frame=CGRectMake(10, 10, Screen_Width-80, 100);
        cell.lable_title.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4f];
        NSString *url=[NSString stringWithFormat:@"%@%@",URL,mode.imgurl];
        NSURL *myUrl=[NSURL URLWithString:url];
        [cell.img_bakeg sd_setImageWithURL:myUrl placeholderImage:[UIImage imageNamed:@"默认图片.png"]];
        // cell.img_bakeg.backgroundColor=[UIColor blueColor];
        cell.lable_title.text=mode.title;
    }
    else{
        
    }
    
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"biao:%ld",(long)indexPath.row);
    if (banImageArray.count>0) {
        ReMenModel *mode=[banImageArray objectAtIndex:indexPath.row];
        NSString *ss=[NSString stringWithFormat:@"%@",mode.url];
        WuYewebViewController *wuye=[[WuYewebViewController alloc] initWithCoders:ss Title:mode.title];
        [self.navigationController pushViewController:wuye animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    
}
-(void)buttoubcellrigh{
    TotalViewController *TotalV=[[TotalViewController alloc]init];
    [self.navigationController pushViewController:TotalV animated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
