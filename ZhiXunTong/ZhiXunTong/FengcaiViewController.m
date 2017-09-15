//
//  ViewController.m
//  LeBao
//
//  Created by 小黄人 on 2017/4/13.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import "FengcaiViewController.h"
#import "PchHeader.h"
#import "WebClient.h"
#import "FengcTableViewCell.h"
#import "FengcModel.h"
#import "FCwebViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"


@interface FengcaiViewController () <UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *tableView;
    NSMutableArray *_dataArray;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *Deptid;

}
@property(assign,nonatomic) NSInteger currentPage;

@end

@implementation FengcaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray arrayWithCapacity:0];

    self.navigationItem.title=@"党员风采";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    [self initTableView];
//    [self loadData];
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

-(void)loadData
{
          NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    
    [[WebClient sharedClient] pioneer:ddtvinfo Keys:ddkey deptid:Deptid page:strpage Pagesize:@"10" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSArray *tempArray=[FengcModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        
        if (self.currentPage==1) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:tempArray];
        [tableView reloadData];
    }];
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FengcTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 83;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FengcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.FengcM=_dataArray[indexPath.row];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FengcModel *Fengc=[[FengcModel alloc]init];
    Fengc=_dataArray[indexPath.row];
    FCwebViewController *FCwebV=[[FCwebViewController alloc] init];
    FCwebV.webid=Fengc.id;
    [self.navigationController pushViewController:FCwebV animated:NO];
    
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
        [tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableView.mj_header endRefreshing];
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
        
        
        [tableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [tableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
