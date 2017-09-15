//
//  wyTuiJieViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/5.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "wyTuiJieViewController.h"
#import "PchHeader.h"
#import "ReMenModel.h"
#import "wuyetuijieTableViewCell.h"
#import "WuYewebViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface wyTuiJieViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_oneDataArray;
    UITableView *_MyTableView;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aadeid;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页

@end

@implementation wyTuiJieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _oneDataArray=[NSMutableArray arrayWithCapacity:0];
    [self DaoHang];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadeid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    
    _MyTableView=[[UITableView alloc] init];
    _MyTableView.dataSource=self;
    _MyTableView.delegate=self;
    _MyTableView.separatorStyle = NO;
    _MyTableView.showsVerticalScrollIndicator=NO;
    _MyTableView.frame=CGRectMake(0, 0, Screen_Width, Screen_height);
    [self.view addSubview:_MyTableView];
//    [self shuju];
    [self setupRefresh];
}
-(void)DaoHang
{
    self.navigationItem.title=@"物业推荐";
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)shuju
{
//
    NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] TuiJie:aatvinfo Keys:aakey UserId:aaid pagesize:@"10" page:strpage ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"物业推荐：%@",resultObject);
//        _oneDataArray=[[NSMutableArray alloc]initWithArray:[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSArray *tempArray=[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        
        if (self.currentPage==1) {
            [_oneDataArray removeAllObjects];
        }
        [_oneDataArray addObjectsFromArray:tempArray];
        [_MyTableView reloadData];
    }];
     
}
 //#pragma mark tableView代理方法
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _oneDataArray.count;
}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wuyetuijieTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"wuyetuijieTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
   // cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    ReMenModel *mode=[_oneDataArray objectAtIndex:indexPath.row];
    //对Cell要做的设置

    cell.lable_title.text=[NSString stringWithFormat:@"%@",mode.title];
    NSURL *ur=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.imgurl]];
    NSLog(@"ur=%@",ur);
    cell.lable_title.frame=CGRectMake(0, 90, Screen_Width, 30);
    cell.img_bakeg.frame=CGRectMake(0, 0, Screen_Width, 120);
    cell.lable_title.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4f];
    [cell.img_bakeg sd_setImageWithURL:ur placeholderImage:[UIImage imageNamed:@"003.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    ReMenModel *mode=[_oneDataArray objectAtIndex:indexPath.row];
    NSString *ss=[NSString stringWithFormat:@"%@",mode.url];
    NSLog(@"%@",ss);
    WuYewebViewController *web=[[WuYewebViewController alloc] initWithCoders:ss Title:mode.title];
    [self.navigationController pushViewController:web animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self shuju];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_MyTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_MyTableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self shuju];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_MyTableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_MyTableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    _MyTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [_MyTableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    _MyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
