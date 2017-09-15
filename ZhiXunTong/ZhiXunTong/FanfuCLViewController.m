//
//  ViewController.m
//  LeBao
//
//  Created by 小黄人 on 2017/4/13.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import "FanfuCLViewController.h"
#import "PchHeader.h"
#import "FanfuTableViewCell.h"
#import "FanfuModel.h"
#import "FanfuwebViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"


@interface FanfuCLViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_dataArray;
   
    UITableView *_tableView;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *Deptid;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页


@end

@implementation FanfuCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userDefaults objectForKey:TVInfoId];
    aakey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    
    self.navigationItem.title=@"反腐倡廉";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    [self initTableView];
//    [self HWLodel];
    [self setupRefresh];
    
    
    // Do any additional setup after loading the view.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)HWLodel{
           NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] Corruption:aatvinfo Keys:aakey deptid:Deptid page:strpage Pagesize:@"10" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"strpage%@",strpage);
//        NSArray *tempArray=[FanfuModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        NSArray *tempArray=[FanfuModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
    
        if (self.currentPage==1) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:tempArray];
        [_tableView reloadData];
    }];
    
   }
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FanfuTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    //    return _tableView;
    [self.view addSubview:_tableView];
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"我气%ld",_dataArray.count);
    return _dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 86;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FanfuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.FanfuM=_dataArray[indexPath.row];
    
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FanfuwebViewController *FanfuwebV = [[FanfuwebViewController alloc] init];
    FanfuModel *typeShop=_dataArray[indexPath.row];
    FanfuwebV.webid=typeShop.id;
    
    
    [self.navigationController pushViewController:FanfuwebV animated:YES];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self HWLodel];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self HWLodel];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//       _tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)

    [_tableView.mj_header beginRefreshing];

    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
   _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
