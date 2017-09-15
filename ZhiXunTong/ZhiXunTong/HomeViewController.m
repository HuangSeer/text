//
//  HomeViewController.m
//  zhixun
//
//  Created by Mou on 2017/5/24.
//  Copyright © 2017年 air. All rights reserved.
//

#import "HomeViewController.h"
#import <AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "MyCollectionViewCell.h"
#import "HomeTypeCell.h"
#import "PchHeader.h"
#import "NoitceCell.h"
#import "ScrollData.h"
#import "SYCell.h"
#import "SYMovieModel.h"
#import "lunBoModel.h"//第一个轮播
#import "erLunBoModel.h"//第一个轮播
#import "TouTiaoModel.h"
#import "AddressViewController.h"//首页小区选择
#import "TotalViewController.h" //全部分类
#import "GuideViewController.h" //办事指南
#import "AgreementViewController.h"//诉求提交
#import "DesireViewController.h"//故障报修
#import "OpenViewController.h"//一键开门
#import "ZhengCeViewController.h"//政策信息
#import "webViewController.h"//去网页看详情
#import "BanShiViewController.h"//预约办事
#import "WuYewebViewController.h"
#import "LoginViewController.h"
#import "ZhiNengViewController.h"//智能家居
#import "SGAdvertScrollView.h"
#import "SGHelperTool.h"
#import "JiaJuViewController.h"
#import "shbkCollectionViewCell.h"//生活百科cell
#import "SHBKModel.h"
#import "YiCollectionReusableView.h"
#import "ErCollectionReusableView.h"
#import "ShengHuoViewController.h"//社区生活
#import "BaiKeViewController.h"//生活百科
#import "BaiKeXqViewController.h"//百科详情
@interface HomeViewController ()<UIWebViewDelegate,SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SGAdvertScrollViewDelegate>{
    NSArray *ClassArray;
    NSArray *classImageArray;
    NSString *title;
    NSString *phone;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    
    NSMutableArray *_lunBoArray;//第一次请求用
    NSMutableArray *ad_lunBoArrayad;//第二次使用
    NSMutableArray *dpNameArray;
    NSMutableArray *titleArray;
    NSMutableArray *toutiaoArray;
    NSMutableArray *lodArray;
    UICollectionView *homec;
    //上下轮播二次开发
    NSMutableArray *wodeArray;
    NSMutableArray *goodArray;
    UIButton * button;
    NSMutableDictionary *userInfo;
    int sh;
     id<AnjubaoSDK> sdk;
    NSMutableArray *sqshArray;
    NSString *aaid;
    NSArray *sqshArray2;
    NSArray *shbaikeArray;
}

@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;
@property (strong,nonatomic) SGAdvertScrollView *sgad;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (nonatomic , strong) NSArray *dataArr;

@property (nonatomic,strong)NSMutableArray *imageUrlArray;

@end
//首页
@implementation HomeViewController
static HomeViewController* instance;
@synthesize  serverAddress, appType, appTypeValue, areaTypeValue, isVersion2;
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.tabBar.hidden=NO;
    [self getAddress];
}
-(void)connectService
{
    isVersion2 = YES;
    [sdk setVersion2:YES];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [sdk connectService];
    });
}
- (void)getAddress{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    title=[userDefaults objectForKey:navtitle];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSString *ss=[userDefaults objectForKey:shzts];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    sh=[ss intValue];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAddress];
     [self myCollect];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    NSLog(@"%@",phone);
    instance = self;
    
    isVersion2 = NO;
    
    sdk = [AnjubaoSDK instance];
    
    [sdk setDebug:YES];
    [sdk setOfflineDelegate:self];
    //    NSString* areaType = [self.areaTypePicker text];
    areaTypeValue = 1;
    appTypeValue = 2;
    //    serverAddress = [self.serverAddressPicker text];
    [self connectService];

     NSLog(@"tit=%@",title);
    if (!title) {
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showAllQuestions) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"titletitle%@",title);

        __weak typeof(self) weakSelf = self;
        AddressViewController *address=[[AddressViewController alloc] init];
        address.addressBlock = ^(NSString *strAddress) {
            NSLog(@"strAddressstrAddress==%@",strAddress);
            [weakSelf getAddress];
            [button setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
           // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [weakSelf getone];
        };
        [self presentViewController:address animated:YES completion:nil];
        
    }else{
        button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showAllQuestions) forControlEvents:UIControlEventTouchUpInside];
    
        [button setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
    }
       //设置导航栏不透明
   // self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    ClassArray = @[@"政策信息",@"诉求提交",@"预约办事",@"办事指南",@"智能家居",@"故障报修",@"一键开门",@"全部分类"];
    classImageArray=@[@"001.png",@"002.png",@"003.png",@"004.png",@"005.png",@"006.png",@"007.png",@"008.png",];
    dpNameArray=[NSMutableArray arrayWithCapacity:0];
    _imageUrlArray=[NSMutableArray arrayWithCapacity:0];
    _lunBoArray=[NSMutableArray arrayWithCapacity:0];
    titleArray=[NSMutableArray arrayWithCapacity:0];
    lodArray=[NSMutableArray arrayWithCapacity:0];
    toutiaoArray=[NSMutableArray arrayWithCapacity:0];
    goodArray=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.titleView =button;
   
    if (title.length>0) {
        [self getone];
    }
//    [self SheQuShengHuo];
}
//轮播图请求
-(void)getone{
//    [SVProgressHUD showWithStatus:@"加载中"];
    [_lunBoArray removeAllObjects];
    [[WebClient sharedClient] getlod:tvinfoId Keys:key Deptid:deptid ResponseBlock:^(id  _Nullable responseObject,NSError * _Nonnull error){
        //NSLog(@"轮播图请求----------=%@",responseObject);
        [titleArray removeAllObjects];
        [_imageUrlArray removeAllObjects];
        ad_lunBoArrayad=[[NSMutableArray alloc]initWithArray:[erLunBoModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"Data"]]];
        //NSLog(@"ad_lunBoArrayad=%@",ad_lunBoArrayad);
        if (ad_lunBoArrayad.count>0) {
            erLunBoModel *mode=[ad_lunBoArrayad objectAtIndex:0];
            for (int i=0; i<mode.ad.count; i++) {
                [_lunBoArray addObject:[mode.ad objectAtIndex:i]];
            }
            for (int j=0; j<mode.News.count; j++) {
                [_lunBoArray addObject:[mode.News objectAtIndex:j]];
            }
            for (int k=0; k<_lunBoArray.count; k++) {
                NSString *cc=[[_lunBoArray objectAtIndex:k] objectForKey:@"Imgurl"];
                if (cc!=nil) {
                    NSString *aa=[NSString stringWithFormat:@"%@%@",URL,cc];
                    [_imageUrlArray addObject:aa];
                }
                NSString *dd=[[_lunBoArray objectAtIndex:k] objectForKey:@"ImageIndex"];
                if (dd!=nil) {
                    NSString *nn= [NSString stringWithFormat:@"%@%@",URL,dd];
                    // NSLog(@"nn==%@",nn);
                    [_imageUrlArray addObject:nn];
                }
                
                [titleArray addObject:[[_lunBoArray objectAtIndex:k] objectForKey:@"Title"]];
            }
            NSLog(@"_lunBoArray22=%@",_lunBoArray);
            [homec reloadData];
           // if (_imageUrlArray.count>0 && dpNameArray>0) {
                // [HUD hide:YES];
                //[SVProgressHUD showSuccessWithStatus:@"数据加载成功"];
            
            //}
            _topPhotoBoworr.imageURLStringsGroup = _imageUrlArray;
            _topPhotoBoworr.titlesGroup =titleArray;
        }
         [self getContent];
        if (error!=nil) {
            NSLog(@"error:请求失败%@",error);
        }
    }];
}
//首页内容请求
-(void)getContent
{
    [toutiaoArray removeAllObjects];
    [[WebClient sharedClient] ChuiZhi:tvinfoId Keys:key Depid:deptid Pagsize:@"6" Status:@"3" Page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
        lodArray=[[NSMutableArray alloc]initWithArray:[TouTiaoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
//        NSLog(@"data=%@",[resultObject objectForKey:@"Data"]);
//        NSLog(@"lodArray=:%@",lodArray);
        for (int i=0; i<lodArray.count; i++) {
            TouTiaoModel *mode=[lodArray objectAtIndex:i];
            [toutiaoArray addObject:mode.Title];
        }
        if (toutiaoArray.count>0 && _imageUrlArray.count>0 && lodArray.count>0) {
            [homec reloadData];
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        wodeArray=[[NSMutableArray alloc]initWithArray:[lunBoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        for (int i=0; i<wodeArray.count; i++) {
            lunBoModel *model=[wodeArray objectAtIndex:i];
           // NSLog(@"轮播二：%@",model.Title);
            [goodArray addObject:model.Title];
        }
       // NSLog(@"%ld",wodeArray.count);
        _sgad.titleArray=toutiaoArray;
        [homec reloadData];
        [self SheQuShengHuo];
        if (error!=nil) {
            NSLog(@"失败error:%@",error);
        }
    }];
}
//社区生活
-(void)SheQuShengHuo
{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method= allpost&TVInfoId=&Key=&DeptId=&Uid=&Page=&PageSize=
    //tvinfoId Keys:key Depid:deptid
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=allpost&TVInfoId=%@&Key=%@&DeptId=%@&Uid=%@&Page=1&PageSize=2",URL,tvinfoId,key,deptid,aaid];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        sqshArray=[TouTiaoModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        sqshArray2=[[data objectForKey:@"Data"] valueForKey:@"title"];
        [self shbaike];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
//生活百科
-(void)shbaike
{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=alllist&TVInfoId=%@&Key=%@&DeptId=%@&Page=1&PageSize=2",URL,tvinfoId,key,deptid];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        shbaikeArray=[SHBKModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
//        sqshArray2=[[data objectForKey:@"Data"] valueForKey:@"title"];
        [homec reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height-64) collectionViewLayout:layout];
    NSLog(@"%@",layout);
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [homec registerClass:[HomeTypeCell class] forCellWithReuseIdentifier:@"homeId"];
    [homec registerClass:[SYCell class] forCellWithReuseIdentifier:@"syId"];
    [homec registerClass:[shbkCollectionViewCell class] forCellWithReuseIdentifier:@"shbk"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    [homec registerClass:[YiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    [homec registerClass:[ErCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView"];
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
        return 8;
    }
    else if(section==1)
    {
        return sqshArray.count;
    }
    else if(section==2)
    {
        return shbaikeArray.count;
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
    }else if (indexPath.section==1)
    {
        SYCell *cell=(SYCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"syId" forIndexPath:indexPath];
        TouTiaoModel *mode=[sqshArray objectAtIndex:indexPath.item];
        //添加数据
        cell.titlelabel.text=[NSString stringWithFormat:@"%@",[sqshArray2 objectAtIndex:indexPath.row]];
        cell.titlelabel.frame=CGRectMake(10, 0, Screen_Width-53, 40);
        cell.titlelabel.numberOfLines=2;
        cell.addrelabel.text=[NSString stringWithFormat:@"%@  %@",mode.type,mode.time];
        cell.addrelabel.textColor=[UIColor grayColor];
        cell.addrelabel.font=[UIFont systemFontOfSize:13];
//        cell.timlabel.text=mode.EditDate;
//        cell.timlabel.textColor=[UIColor grayColor];
//        cell.timlabel.font=[UIFont systemFontOfSize:13];
        cell.topImage.frame=CGRectMake(Screen_Width-90, 5, 70, 70);
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        cell.cellXian.frame=CGRectMake(10, cell.frame.size.height, Screen_Width-20, 0.5);
        
//        cell.backgroundColor=RGBColor(236, 236, 236);
        return cell;
    }
    else if(indexPath.section==2)
    {
        shbkCollectionViewCell *cell=(shbkCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"shbk" forIndexPath:indexPath];
        
        SHBKModel *mode=[shbaikeArray objectAtIndex:indexPath.item];
        cell.bklabelTit.text=mode.title;
        cell.bklabel.text=mode.type;
        [cell.bkImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
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
    if (indexPath.section==0)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(Screen_Width, 80);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(Screen_Width, 156);
    }
    else
    {
        return CGSizeMake(Screen_Width, 0);
    }
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 35);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 0.0001);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 0.0001);
    }
    else
    {
        return CGSizeMake(Screen_Width, 0.0001);
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, Screen_Width / 2+10);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 23);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else
    {
        return CGSizeMake(0, 0);
    }
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    else if (section==1)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else if (section==2)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
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
        if (indexPath.section==0)
        {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            if (_lunBoArray.count>0) {
                [headerView addSubview:self.topPhotoBoworr];
            }
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;

        }
        else if (indexPath.section==1)
        {
            ErCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
//            headerView.erLable.frame=CGRectMake(10, 0, 80, 29);
            headerView.erLable.font=[UIFont systemFontOfSize:15];
            headerView.erLable.textColor=RGBColor(65, 140, 12);
            headerView.erLable.text=@"社区生活";
            headerView.erLable.frame=CGRectMake(20, 3, 100, 29);
            headerView.erLable.textAlignment=NSTextAlignmentLeft;
            [headerView.erButton setTitle:@"更多>>" forState:UIControlStateNormal];
            headerView.erButton.frame=CGRectMake(Screen_Width-80, 0, 80, 30);
            headerView.erButton.tag=3000;
            [headerView.erButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [headerView.erButton addTarget:self action:@selector(hmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            headerView.backgroundColor = [UIColor clearColor];
            headerView.xianView2.hidden=YES;
            
            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 10, 5, 15)];
            aa.backgroundColor=RGBColor(65, 140, 12);
            [headerView addSubview:aa];
            return headerView;

        }
        else if(indexPath.section==2)
        {
            YiCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
//            headerView.yiLable.frame=CGRectMake(10, 0, 80, 29);
            headerView.yiLable.font=[UIFont systemFontOfSize:15];
            headerView.yiLable.textColor=RGBColor(65, 140, 12);
            headerView.yiLable.text=@"生活百科";
            headerView.yiLable.frame=CGRectMake(20, 3, 100, 29);
            headerView.yiLable.textAlignment=NSTextAlignmentLeft;
            [headerView.yiButton setTitle:@"更多>>" forState:UIControlStateNormal];
            headerView.yiButton.frame=CGRectMake(Screen_Width-80, 0, 80, 30);
            headerView.yiButton.tag=3001;
            [headerView.yiButton addTarget:self action:@selector(hmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            headerView.xianView.frame=CGRectMake(10, 29, Screen_Width-20, 1);
            headerView.backgroundColor = [UIColor clearColor];
            headerView.xianView.hidden=YES;
            
            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 10, 5, 15)];
            aa.backgroundColor=RGBColor(65, 140, 12);
            [headerView addSubview:aa];
            return headerView;
        }
    }
    else
    {
        if (indexPath.section==0)
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            SGAdvertScrollView *advertScrollView = [[SGAdvertScrollView alloc] init];
            advertScrollView.frame = CGRectMake(0, 2.5, self.view.frame.size.width, 30);
            advertScrollView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            advertScrollView.timeInterval=4;
            advertScrollView.image = [UIImage imageNamed:@"toutiao"];
            advertScrollView.titleArray =toutiaoArray;
            advertScrollView.titleFont = [UIFont systemFontOfSize:14];
            advertScrollView.advertScrollViewDelegate = self;
            [footerView addSubview:advertScrollView];
            return footerView;
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
    return nil;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.item==0)
        {
            ZhengCeViewController *zhengce=[[ZhengCeViewController alloc] init];
            [self.navigationController pushViewController:zhengce animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==1)
        {
            AgreementViewController *agreement=[[AgreementViewController alloc] init];
            [self.navigationController pushViewController:agreement animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==2)
        {
            BanShiViewController *banshi=[[BanShiViewController alloc] init];
            [self.navigationController pushViewController:banshi animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==3)
        {
            GuideViewController *guide=[[GuideViewController alloc] init];
            [self.navigationController pushViewController:guide animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else if (indexPath.item==4)
        {
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
        else if (indexPath.item==5) {
            if (userInfo.count>0) {
                if (sh==1) {
                    NSLog(@"444444");
                    DesireViewController *desire=[[DesireViewController alloc] init];
                    [self.navigationController pushViewController:desire animated:NO];
                    self.tabBarController.tabBar.hidden=YES;
                }else{
                     [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
                }
            }else
            {
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
        }
        else if (indexPath.item==6) {
            if (userInfo.count>0) {
                NSLog(@"444444");
                
                if (sh==1)
                {
                    OpenViewController *open=[[OpenViewController alloc] init];
                    [self.navigationController pushViewController:open animated:NO];
                    self.navigationController.navigationBarHidden=NO;
                    self.tabBarController.tabBar.hidden=YES;
                   // [SVProgressHUD showErrorWithStatus:@"该小区尚未开通"];
                }else
                {
                    [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
                }
//                DesireViewController *desire=[[DesireViewController alloc] init];
//                [self.navigationController pushViewController:desire animated:NO];
            }else{
                LoginViewController *login=[[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            }
            
        }
        else if (indexPath.item==7) {
            TotalViewController *total=[[TotalViewController alloc] init];
            [self.navigationController pushViewController:total animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
    }
    else if(indexPath.section==1)
    {
        NSLog(@"社区生活%ld--------%ld",indexPath.section,indexPath.item);
        TouTiaoModel *mode=[sqshArray objectAtIndex:indexPath.item];
        BaiKeXqViewController *BaiKeXq=[[BaiKeXqViewController alloc] init];
        BaiKeXq.mid=mode.id;
        BaiKeXq.mTitle=@"社会生活";
        [self.navigationController pushViewController:BaiKeXq animated:NO];
        self.tabBarController.tabBar.hidden=YES;

    }
    else if(indexPath.section==2)
    {
        SHBKModel *mode=[shbaikeArray objectAtIndex:indexPath.item];
        NSLog(@"社会百科%ld--------%ld",indexPath.section,indexPath.item);
        BaiKeXqViewController *BaiKeXq=[[BaiKeXqViewController alloc] init];
        BaiKeXq.mid=mode.id;
        BaiKeXq.mTitle=@"生活百科";
        [self.navigationController pushViewController:BaiKeXq animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
}
//社区头条代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    lunBoModel *mode=[wodeArray objectAtIndex:index];
    
    NSLog(@"NewsId=%@",mode.NewsId);
    NSString *weburl=[NSString stringWithFormat:@"%@/api/Html/news_show.html?method=home&Tvinfoid=%@&Key=%@&DeptId=%@&id=%@",URL,tvinfoId,key,deptid,mode.NewsId];
    
    NSString *aa=mode.ModuName;
    NSLog(@"weburl=%@",weburl);
    // NSString *aa=[NSString stringWithFormat:@"%@",mode.Title];
    webViewController *web=[[webViewController alloc] initWithCoderZW:weburl Title:aa];
    [self.navigationController pushViewController:web animated:NO];
    self.tabBarController.tabBar.hidden=YES;

}

//第一个滚动视图
- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/2) delegate:self placeholderImage:[UIImage imageNamed:@"默认图片"]];
        _topPhotoBoworr.boworrWidth = Screen_Width - 30;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 30;
        _topPhotoBoworr.imageURLStringsGroup = _imageUrlArray;
        _topPhotoBoworr.titlesGroup =titleArray;
    }
    return _topPhotoBoworr;
}
//点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"lodArray=%@",lodArray);
    NSString *pp=[[_lunBoArray objectAtIndex:index] objectForKey:@"NewsId"];
    NSString *gg=[[_lunBoArray objectAtIndex:index] objectForKey:@"Id"];
    erLunBoModel *mode= [ad_lunBoArrayad objectAtIndex:0];
        if (mode.ad.count>index) {
            NSString *webu=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=recommended&Tvinfoid=%@&Key=%@&DeptId=%@&id=%@",URL,tvinfoId,key,deptid,gg];
            NSString *aa=[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:index]];
            
            webViewController *web=[[webViewController alloc] initWithCoderZW:webu Title:aa];
            [self.navigationController pushViewController:web animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
        else {
            NSString *webu=[NSString stringWithFormat:@"%@/api/Html/news_show.html?method=home&Tvinfoid=%@&Key=%@&DeptId=%@&id=%@",URL,tvinfoId,key,deptid,pp];
            NSString *aa=[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:index]];
            
            webViewController *web=[[webViewController alloc] initWithCoderZW:webu Title:aa];
            [self.navigationController pushViewController:web animated:NO];
            self.tabBarController.tabBar.hidden=YES;
        }
}
-(void)showAllQuestions{
    __weak typeof(self) weakSelf = self;
    AddressViewController *address=[[AddressViewController alloc] init];
    address.addressBlock = ^(NSString *strAddress) {
           NSLog(@"strAddressstrAddress==%@",strAddress);
        [weakSelf getAddress];
         [button setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [weakSelf getone];
        [weakSelf getContent];
    };
    [self presentViewController:address animated:NO completion:nil];
}
#pragma 二个更多按钮
-(void)hmBtnClick:(UIButton *)btn
{
    if (btn.tag==3000) {
        NSLog(@"3000 社区生活");
        ShengHuoViewController *ShengHuo=[[ShengHuoViewController alloc] init];
        [self.navigationController pushViewController:ShengHuo animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else if (btn.tag==3001)
    {
      NSLog(@"3001 生活百科");
        BaiKeViewController *BaiKe=[[BaiKeViewController alloc] init];
        [self.navigationController pushViewController:BaiKe animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
