//
//  FujinViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FujinViewController.h"
#import "FuJinCell.h"
#import "PchHeader.h"
#import "FuJinModel.h"
#import <CoreLocation/CoreLocation.h>
#import "MJExtension.h"
#import "MJRefresh.h"
@interface FujinViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{ NSString  *weidustr;
    NSString  *jindustr;
    UITableView *_tableView;
    NSMutableArray *_ModelArray;
    NSString *strcookie;
    NSUserDefaults *userDefaults;
}
@property(assign,nonatomic) NSInteger currentPage;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
//附近店铺
@implementation FujinViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"附近店铺";
    userDefaults= [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookiestr];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
     _ModelArray=[NSMutableArray arrayWithCapacity:0];
    [self startLocation];
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
-(void)loddate{

    NSString *strurl=[NSString stringWithFormat:@"%@userNearStore.htm?longitude=%@&latitude=%@&currentPage=%ld&pageSize=6&Cookie=%@",URLds,weidustr,jindustr,_currentPage,strcookie];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"postFJ==%@",data);
        NSArray *array=[FuJinModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        if (_currentPage==1) {
            [_ModelArray removeAllObjects];
        }
        [_ModelArray addObjectsFromArray:array];
        if (_ModelArray.count==0) {
            [SVProgressHUD showErrorWithStatus:@"暂无数据!"];
        }else{
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [_locationManager stopUpdatingLocation];
    /*旧值*/
    CLLocation * currentLocation = [locations lastObject];
    
    /*打印当前经纬度*/
    NSLog(@"%.2f%.2f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    jindustr=[NSString stringWithFormat:@"%.2f",currentLocation.coordinate.latitude];
     weidustr=[NSString stringWithFormat:@"%.2f",currentLocation.coordinate.longitude];
    [self setupRefresh];
    
    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ModelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuJinCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"FuJinCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FuJinModel *model=[_ModelArray objectAtIndex:indexPath.row];
    [cell.log_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.logo]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    cell.lable_name.text=[NSString stringWithFormat:@"%@",model.store_name];
    cell.labnr.text=[NSString stringWithFormat:@"%@",model.store_address];
    return cell;
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self loddate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    [self loddate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
