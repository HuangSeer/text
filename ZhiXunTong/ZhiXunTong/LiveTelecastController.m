//
//  LiveTelecastController.m
//  LOL
//
//  Created by Kean on 16/7/11.
//  Copyright © 2016年 Kean. All rights reserved.
//

#import "LiveTelecastController.h"
#import "PchHeader.h"
#import "LiveCollectionViewCell.h"
#import "DQModel.h"
#import "LiveWebViewController.h"

#import "MJRefresh.h"
#import "MJExtension.h"

@interface LiveTelecastController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {

    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *deptid;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页

@end

@implementation LiveTelecastController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.currentPage=1;
    _dataArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userDefaults objectForKey:TVInfoId];
    aakey=[userDefaults objectForKey:Key];
     deptid=[userDefaults objectForKey:DeptId];
    self.navigationItem.title = @"党群活动";
//    [self loadData];
    [self initCollectionView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    [self setupRefresh];
    // Do any additional setup after loading the view.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}

/**
 *   加载数据
 */
- (void)loadData {
      NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] HuoDong:aatvinfo Keys:aakey Deptid:deptid pagesize:@"10" page:strpage ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        
        NSArray *tempArray=[DQModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];

        if (self.currentPage==1) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:tempArray];
        [_collectionView reloadData];
    }];
    
}

/**
 *  创建 CollectionView
 */
- (void)initCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
     [_collectionView setBackgroundColor:[UIColor whiteColor]];
//注册
//    [_collectionView registerClass:[LiveCollectionViewCell class] forCellWithReuseIdentifier:@"collectioncell"];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"collectioncell"];
    [self.view addSubview:_collectionView];

}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSLog(@"_dataArray.count==%ld",_dataArray.count);
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    cell.DQM = _dataArray[indexPath.row];
    
    return cell;

}


#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DQModel *DQM=[[DQModel alloc]init];
    DQM=_dataArray[indexPath.row];
    LiveWebViewController *LiveWebV=[[LiveWebViewController alloc] init];
    LiveWebV.webid=DQM.id;
    [self.navigationController pushViewController:LiveWebV animated:NO];
    
}


#pragma mark UICollectionViewDelegateFlowLayout


// 设置cell 坐标
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 2, 5, 2);
    
}



// 设置cell大小可以改变一行有多少个cell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width-14)/2, (self.view.frame.size.width / 2.15));

}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self loadData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_collectionView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_collectionView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self loadData];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        
        [_collectionView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_collectionView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    _collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _collectionView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [_collectionView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
