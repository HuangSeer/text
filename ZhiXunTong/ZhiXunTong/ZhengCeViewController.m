//
//  ZhengCeViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ZhengCeViewController.h"
#import "ZhengCeTableViewCell.h"
#import "CBHeaderChooseViewScrollView.h"
#import "PchHeader.h"
#import "diyi.h"
#import "webViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface ZhengCeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    NSMutableArray *_arrayDiyi;
    NSMutableArray *array;
    NSMutableArray *titleArray;
    UITableView *GyouTableView;
    NSString *strcz;
    NSString *dpid;
    NSString *status;
    
}
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger currentPage;  //当前页


@end

@implementation ZhengCeViewController
-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    array = [NSMutableArray arrayWithCapacity:0];
    titleArray=[NSMutableArray arrayWithCapacity:0];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSLog(@"key=%@\n deptid=%@\n tivinfo=%@",key,   deptid,tvinfoId);
    [self getaf];
    [self initableview];
    //    [self getaf1:@"" Status:@""];
 
    
}
-(void)daohangView
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"政策信息";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    CBHeaderChooseViewScrollView *headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [self.view addSubview:headerView];
    [headerView setUpTitleArray:array titleColor:nil titleSelectedColor:nil titleFontSize:0];
    // headerView.btnChooseClickReturn(0);
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        _num=x;
        NSLog(@"点击了第%ld个按钮",x+1);
        if (x==0) {
          [titleArray removeAllObjects];
            self.currentPage=1;
            dpid=@"";
            status=@"3";
            [self getaf1];
        }
        else if (x==1){
              [titleArray removeAllObjects];
            self.currentPage=1;
            dpid=deptid;
            status=@"1";
            [self getaf1];
//            [GyouTableView reloadData];
        }
        else if (x==2){
              [titleArray removeAllObjects];
            self.currentPage=1;
            dpid=deptid;
            status=@"2";
            [self getaf1];
//            [GyouTableView reloadData];
        }
        else{
              [titleArray removeAllObjects];
            self.currentPage=1;
            diyi *mode=[_arrayDiyi objectAtIndex:x-1];
            dpid=mode.Deptid;
            status=@"";
            [self getaf1];
//           [GyouTableView reloadData];
            
        }
    };
}
-(void)initableview{
    GyouTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,40, Screen_Width, Screen_height) style:UITableViewStylePlain];
    GyouTableView.backgroundColor = [UIColor whiteColor];
    GyouTableView.dataSource = self;
    GyouTableView.delegate = self;
    [GyouTableView setTableFooterView:[UIView new]];
    //[GyouTableView reloadData];
    [self.view addSubview:GyouTableView];
    
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)getaf
{
    // 1 封装会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=DeptNewsTab&TVInfoId=%@&Key=%@",URL,tvinfoId,key];
    NSLog(@"dict====%@",dict);
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"请求成功:%@", responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"请求成功:%@", responseJSON);
        _arrayDiyi = [[NSMutableArray alloc] initWithArray:[diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
        NSLog(@"请求成功:%@", _arrayDiyi);
        for (int i=0; i<_arrayDiyi.count; i++) {
            diyi *mode=[_arrayDiyi objectAtIndex:i];
            //NSLog(@"%@",[_arrayDiyi objectAtIndex:i]);
            NSLog(@"diyi=%@",mode.DeptName);
            [array addObject:mode.DeptName];
        }
        [array insertObject:@"全部" atIndex:0];
        //NSLog(@"%@",array);
        if (array.count>0) {
            [self daohangView];
            dpid=deptid;
            status=@"3";
            [self getaf1];
            [self setupRefresh];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];
    
}
-(void)getaf1
{
    //[titleArray removeAllObjects];
    NSLog(@"%@====%@",dpid,status);
    NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    NSString *srpagesize=[NSString stringWithFormat:@"10"];
    // 1 封装会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=NewList&TVInfoId=%@&Key=%@&Page=%@&PageSize=%@&ClassId=&status=%@&DeptId=%@",URL,tvinfoId,key,strpage,srpagesize,status,dpid];
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"请求成功:%@", responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        //NSLog(@"请求成功:%@", responseJSON);
        NSArray *tempArray = [diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]];
         
        if (self.currentPage==1) {
            [titleArray removeAllObjects];
        }
        
        [titleArray addObjectsFromArray:tempArray];
        [GyouTableView reloadData];
        NSLog(@"titleArray==%@",titleArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhengCeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ZhengCeTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    //SYMovieModel *model=_saveDataArray[indexPath.item];
    //取消选中颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    diyi *mode=[titleArray objectAtIndex:indexPath.row];
    cell.title_lable.text=[NSString stringWithFormat:@"[%@]%@",mode.DeptName,mode.Title];
    cell.time_lable.text=mode.EditDate;
    return cell;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    diyi *mode=[titleArray objectAtIndex:indexPath.row];
    NSString *webu=[NSString stringWithFormat:@"%@/api/Html/news_show.html?method=home&Tvinfoid=%@&Key=%@&DeptId=%@&id=%@",URL,tvinfoId,key,deptid,mode.NewsId];
    webViewController *web=[[webViewController alloc]initWithCoderZW:webu Title:mode.ModuName];
    [self.navigationController pushViewController:web animated:NO];
    NSLog(@"id=%@",mode.NewsId);
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self getaf1];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [GyouTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [GyouTableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self getaf1];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [GyouTableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [GyouTableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    GyouTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
#warning 自动刷新(一进入程序就下拉刷新)
    [GyouTableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    GyouTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
