//
//  GonggaoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GonggaoViewController.h"
#import "GongGaoModel.h"
#import "WuYewebViewController.h"
#import "GonggaoTableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface GonggaoViewController (){
    NSString *ggdeptid;
    NSString *ggkey;
    NSString *ggtvinfo;
    NSMutableDictionary *userinfo;
    NSMutableArray *_savaArray;
    
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    NSString *strpd;

}
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@end

@implementation GonggaoViewController

-(void)viewWillAppear:(BOOL)animated{
    
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    oneArray=[NSMutableArray arrayWithCapacity:0];
    twoArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    ggtvinfo=[userinfo objectForKey:@"TVInfoId"];
    ggkey=[userinfo objectForKey:@"Key"];
    ggdeptid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    [self daohangView];
 
      [self segumentSelectionChange:0];
      [self leftView];
      [self setupRefresh];
    
}
-(void)daohangView
{
    self.navigationItem.title=@"物业公告";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    NSArray * btnDataSource = @[@"公告",@"公示"];
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) titleDataSource:btnDataSource backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor greenColor] buttonDownColor:[UIColor clearColor] Delegate:self];
    UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Screen_Width, 0.5)];
    xian.backgroundColor=[UIColor grayColor];
    [segment addSubview:xian];
    UIView *shuxian=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2, 0, 0.5, 44)];
    shuxian.backgroundColor=[UIColor grayColor];
    [segment addSubview:shuxian];
    
    [self.view addSubview:segment];
 
}
//拿数据
-(void)getShuju
{
    NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] Page:strpage PageSize:@"10" DePtid:ggdeptid Tvinfo:ggtvinfo Keys:ggkey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObject=%@",resultObject);
        _savaArray=[[NSMutableArray alloc]initWithArray:[GongGaoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        for (int i=0; i<_savaArray.count; i++) {
            GongGaoModel *model=[_savaArray objectAtIndex:i];
            NSString *aid=model.Aid;
            int aa=[aid intValue];
            if ( aa==1) {
                
                [oneArray addObject:model];
//                [self leftView];
                [leftTableView reloadData];
            }else{
                [twoArray addObject:model];
                [leftTableView reloadData];
            }
         
            }
//        NSString *ss=[resultObject objectForKey:@"Atime"];
//        [self leftView];
    }];
}
#pragma mark -- 遵守代理 实现代理方法
//1-------2 办事
- (void)segumentSelectionChange:(NSInteger)selection{
    NSLog(@"id%ld",selection);
    if (selection==1) {
        strpd=[NSString stringWithFormat:@"1"];
        [leftTableView reloadData];
    }else{
          strpd=[NSString stringWithFormat:@"2"];
        [leftTableView reloadData];
          }
}
-(void)leftView
{
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-44) style:UITableViewStylePlain];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
//    [leftTableView setTableFooterView:[UIView new]];
     [leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GonggaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([GonggaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell2"];

    [self.view addSubview:leftTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([strpd containsString:@"1"])
    {
        return oneArray.count;
       // return 15;
    }
    else if ([strpd containsString:@"2"])
    {
        return twoArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    if ([strpd containsString:@"1"]) {
//        GongGaoModel *mode=[oneArray objectAtIndex:indexPath.row];
        GonggaoTableViewCell *cell = [leftTableView dequeueReusableCellWithIdentifier:@"cell"];
        leftTableView.separatorStyle = NO;
        cell.GongGaoM=oneArray[indexPath.row];
        return cell;
    }
    else
    {
        GonggaoTableViewCell *cell = [leftTableView dequeueReusableCellWithIdentifier:@"cell2"];
        leftTableView.separatorStyle = NO;
        cell.GongGaoM=twoArray[indexPath.row];
        return cell;
    }
//    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryNone;
//    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([strpd containsString:@"1"]) {
        NSString *title=@"公告";
        GongGaoModel *model=[oneArray objectAtIndex:indexPath.row];
        NSString *myid=model.id;
        NSLog(@"%@",myid);
        NSString *url=[NSString stringWithFormat:@"%@/api/Html/Announce.aspx?TVInfoId=%@&DeptId=%@&Key=%@&id=%@",URL,ggtvinfo,ggdeptid,ggkey,myid];
        WuYewebViewController *gao=[[WuYewebViewController alloc] initWithCoders:url Title:title];
        [self.navigationController pushViewController:gao animated:NO];
       
    } else if([strpd containsString:@"2"]){
        NSString *title=@"公示";
        GongGaoModel *model=[twoArray objectAtIndex:indexPath.row];
        NSString *myid=model.id;
        NSLog(@"%@",myid);
        NSString *url=[NSString stringWithFormat:@"%@/api/Html/Announce.aspx?TVInfoId=%@&DeptId=%@&Key=%@&id=%@",URL,ggtvinfo,ggdeptid,ggkey,myid];
        WuYewebViewController *gao=[[WuYewebViewController alloc] initWithCoders:url Title:title];
        [self.navigationController pushViewController:gao animated:NO];
    }
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    
    self.currentPage=1;
    // 1.数据操作
    [oneArray  removeAllObjects];
    [twoArray  removeAllObjects];
    NSLog(@"%@",_savaArray);

    [self getShuju];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [leftTableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [leftTableView.mj_header endRefreshing];
    });
}
- (void)footerRereshing
{
    self.currentPage++;
    NSLog(@"_currentPage=%ld",_currentPage);
    [self getShuju];

    // 2.2秒后刷新表格UI
//    if (_savaArray.count == 0) {
//        [leftTableView.mj_footer endRefreshingWithNoMoreData];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            leftTableView.mj_footer.hidden = YES;
            [leftTableView reloadData];
            [leftTableView.mj_footer endRefreshing];
        });
 
}
/**
 *  集成刷新控件
 */
-(void)setupRefresh{
  
    leftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          leftTableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
#warning 自动刷新(一进入程序就下拉刷新)
    [leftTableView.mj_header beginRefreshing];
  
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing
    leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];


    
  
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
