


//
//  PinPViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PinPViewController.h"
#import "LiuXSegmentView.h"
#import "PchHeader.h"
#import "PinPCollectionViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SpXqViewController.h"
#import "LoginViewController.h"

@interface PinPViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *homec;
    NSArray *imageArray;
    NSArray *idArray;
    NSString *intagestr;
    NSMutableArray *modelArray;
    NSString *phone;
    NSString *cookiestr;
    NSString *integral;
    NSMutableDictionary *userinfo;
}
@property(assign,nonatomic) NSInteger currentPage;
@end

@implementation PinPViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
    self.navigationItem.title=@"品牌专题";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    modelArray=[NSMutableArray arrayWithCapacity:0];
    NSString *strurlphone=[NSString stringWithFormat:@"%@brandCategory.htm",URLds];
        [self myCollect];
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        NSLog(@"sad===2==2=2=2========%@",data);
        imageArray=[[data objectForKey:@"data"] valueForKey:@"image"];
          idArray=[[data objectForKey:@"data"] valueForKey:@"gb_id"];
        LiuXSegmentView *LiuXSe=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width, 40) titles:imageArray ids:idArray clickBlick:^void(NSInteger index) {
           
            intagestr=[NSString stringWithFormat:@"%ld",index];
            
             self.currentPage=1;
             [self lodadate];
        }];
        [self setupRefresh];
        [self.view  addSubview:LiuXSe];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
 
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)lodadate
{
    NSString *strurlima=[NSString stringWithFormat:@"%@goodsBrandList.htm?gb_id=%@&currentPage=%ld&pageSize=6",URLds,intagestr,_currentPage];
      NSLog(@"---------------%@",strurlima);
    [ZQLNetWork getWithUrlString:strurlima success:^(id data) {
        NSArray *tempArray=[PinPModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
//        if (tempArray.count==0) {
//            [SVProgressHUD showErrorWithStatus:@"暂无更多数据!"];
//        }
        if (self.currentPage==1) {
        [modelArray removeAllObjects];
        }
        [modelArray addObjectsFromArray:tempArray];
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
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, Screen_Width,Screen_height-50) collectionViewLayout:layout];
    NSLog(@"%@",layout);
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerNib:[UINib nibWithNibName:NSStringFromClass([PinPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
}
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return modelArray.count;
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 200);
}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PinPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.PinPM = modelArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.addToCartsBlock = ^(PinPCollectionViewCell *cell) {
        [weakSelf myFavoriteCellAddToShoppingCart:cell];
    };
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
      PinPModel *PinPM = modelArray[indexPath.row];
    SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
    SpXqVi.intasid=PinPM.goodsId;
    
    [self.navigationController pushViewController:SpXqVi animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;


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
        //        tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [homec.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    homec.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}
- (void)myFavoriteCellAddToShoppingCart:(PinPCollectionViewCell *)cell{
                  SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
                  SpXqVi.intasid=cell.PinPM.goodsId;
               
                  [self.navigationController pushViewController:SpXqVi animated:NO];
                  self.navigationController.navigationBarHidden=NO;
                  self.tabBarController.tabBar.hidden=YES;
  
          

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
