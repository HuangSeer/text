

//
//  TieJViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TieJViewController.h"
#import "PinPCollectionViewCell.h"
#import "PchHeader.h"
#import "TieJCollectionReusableView.h"
#import "SpXqViewController.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface TieJViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *homec;
    UIView *views;
    int xsd;
    NSString *phone;
    NSString *cookiestr;
    NSString *integral;
    NSMutableDictionary *userinfo;
TieJCollectionReusableView *headerView;

}
@property(assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) NSMutableArray *ModelArray;
@end

@implementation TieJViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏

     self.navigationItem.title=@"特价商品";

    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
  
    [self myCollect];
    [self setupRefresh];
    
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

-(void)lodadate{
    [homec reloadData];
    //获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    //请求数据
    NSString *strurlfl=[NSString stringWithFormat:@"%@bargainGoods.htm?bg_time=%@&currentPage=%ld&pageSize=10",URLds,DateTime,_currentPage];
    NSLog(@"%@",strurlfl);
    [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
        NSLog(@"sad===2==2=2=2========%@",data);
        NSString *msg=[data objectForKey:@"msg"];
        NSArray *array=[TieJModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        if (_currentPage==1) {
            [_ModelArray removeAllObjects];
        }
        [_ModelArray addObjectsFromArray:array];
        if (_ModelArray.count==0) {
            [SVProgressHUD showErrorWithStatus:msg];
        }else{
        [views removeFromSuperview];
        NSString *strxs=[NSString stringWithFormat:@"%lu",(_ModelArray.count)];
        CGFloat result = [strxs floatValue]/2;
        NSString *strsa=[NSString stringWithFormat:@"%.1f", result];
        if ([strsa containsString:@"5"]) {
            NSArray *array = [strsa componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
            NSString *xs=[NSString stringWithFormat:@"%@",array[0]];
            xsd=[xs intValue]+1;
            NSLog(@"%d",xsd);
            views=[[UIView alloc]initWithFrame:CGRectMake(9,40, 2,210*xsd)];
            views.backgroundColor=RGBColor(96, 211, 120);
            [homec addSubview:views];
            [homec reloadData];
        }else{
            views=[[UIView alloc]initWithFrame:CGRectMake(9,40, 2,210*(_ModelArray.count)/2)];
            views.backgroundColor=RGBColor(96, 211, 120);
            [homec addSubview:views];
            [homec reloadData];
        }
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height-10) collectionViewLayout:layout];
    NSLog(@"%@",layout);
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerNib:[UINib nibWithNibName:NSStringFromClass([PinPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width,40);
    
    [homec registerClass:[TieJCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
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
            
                return headerView;
        }else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width,40);
    }
    else {
        return CGSizeMake(0, 0);
    }
}
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ModelArray.count;
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 200);
}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PinPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.TieJMo = _ModelArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.addToCartsBlock = ^(PinPCollectionViewCell *cell) {
        [weakSelf myFavoriteCellAddToShoppingCart:cell];
    };
    
    
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TieJModel *TieJMo = _ModelArray[indexPath.row];
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            integral=[[data objectForKey:@"data"] valueForKey:@"integral"];
            NSString *xstr=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
            SpXqVi.intasid=TieJMo.goods_id;
            [self.navigationController pushViewController:SpXqVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            //                [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }

}
- (void)myFavoriteCellAddToShoppingCart:(PinPCollectionViewCell *)cell{
    
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            integral=[[data objectForKey:@"data"] valueForKey:@"integral"];
            NSString *xstr=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
            SpXqVi.intasid=cell.TieJMo.goods_id;
            [self.navigationController pushViewController:SpXqVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            //                [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }

}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self lodadate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [homec reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [homec.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self lodadate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [homec reloadData];
        [homec.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    homec.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
        
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [homec.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    homec.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}


@end
