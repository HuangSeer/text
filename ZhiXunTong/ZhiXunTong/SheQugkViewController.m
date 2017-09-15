//
//  SheQugkViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SheQugkViewController.h"
#import "PchHeader.h"
#import "SheQuModel.h"
#import "SheQugkTableViewCell.h"
#import "SheQUwebViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"


@interface SheQugkViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>{
    NSArray *titleArray;
    UIView *view;
    UIButton *button;
    UIView *kongView ;
    NSMutableArray *_viewArray;
    NSMutableArray *_buttonArray;
      UITableView *tableView;
     NSMutableArray *_dataArray;
      UIView *jiemianview;
    UILabel *_placeholderLabel;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *deptid;
}
@property(assign,nonatomic) NSInteger currentPage;

@property(strong ,nonatomic) UIWebView * webView;
@end

@implementation SheQugkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage=1;
    _dataArray=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title=@"社区概况";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
 
    [self changeButton];
    [self initTableView];
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
- (void)changeButton{
    kongView= [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width-40,30)];
    kongView.backgroundColor = [UIColor whiteColor];
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
     titleArray=@[@"社区新闻",@"社区介绍",@"人口信息",@"组织架构"];
    for (int i = 0 ; i < titleArray.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake( kongView.frame.size.width/titleArray.count*i, 5, kongView.frame.size.width/titleArray.count, 50);
        [button setFont:[UIFont systemFontOfSize:13.0f]];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(-7, 0, 7, 0);
        button.tintColor = [UIColor grayColor];
        if (i == 0) {
            button.tintColor =[UIColor redColor];
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [kongView addSubview:button];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(kongView.frame.size.width/titleArray.count*i, 42, kongView.frame.size.width/titleArray.count,2)];
        view.backgroundColor = [UIColor redColor];
        if (i) {
            view.hidden = YES;
        }
        [kongView addSubview:view];
        [kongView addSubview:button];
        [_viewArray addObject:view];
        [_buttonArray addObject:button];
        
    }
    UIView *xView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    xView.backgroundColor = [UIColor clearColor];
    [kongView addSubview:xView];
    
    [self.view addSubview:kongView];

}
-(void)loddate{
    NSLog(@"%@,%@,%@",ddtvinfo,ddkey,deptid);
    NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    NSLog(@"strpagestrpage=====%@",strpage);
    [[WebClient sharedClient] IndexNews:ddtvinfo Keys:ddkey Page:strpage Deptid:deptid PageSize:@"10" ClassId:@"3" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSArray *tempArray=[SheQuModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        if (self.currentPage==1) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:tempArray];
        [tableView reloadData];
    }];

}
- (void)buttonClick:(UIButton *)buttonClick{
    NSLog(@"%@-%@",_viewArray,_buttonArray);
    for (int i = 0; i<titleArray.count; i++) {
        view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == 0) {
            [jiemianview removeFromSuperview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*0, 42, kongView.frame.size.width/titleArray.count,3);
            [self loddate];
            if (i == 0) {
                button.tintColor =[UIColor redColor];
            }else{
                
                button.tintColor =[UIColor grayColor];
            }

        }
        else if (buttonClick.tag == 1) {
            [jiemianview removeFromSuperview];
            jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55)];
            jiemianview.backgroundColor=RGBColor(248, 248, 248);
            [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*1, 42, kongView.frame.size.width/titleArray.count,3);
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,jiemianview.frame.size.width, jiemianview.frame.size.height)];
            
            NSURL *urls=[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/api/Html/ApiResoShow.aspx?&Key=%@&TVInfoId=%@&Deptid=%@&Resoid=85",ddkey,ddtvinfo,deptid]]];
            NSLog(@"%@",urls);
            [jiemianview addSubview:self.webView];
            NSURLRequest * request = [NSURLRequest requestWithURL:urls];
            //           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
            self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            [self.webView loadRequest:request];

            if (i == 1) {
                button.tintColor =[UIColor redColor];
            }else{
                
                button.tintColor =[UIColor grayColor];
            }
            
        }
        else if (buttonClick.tag == 2) {
            [jiemianview removeFromSuperview];
            jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55)];
            jiemianview.backgroundColor=RGBColor(248, 248, 248);
            [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*2, 42, kongView.frame.size.width/titleArray.count,3);
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,jiemianview.frame.size.width,jiemianview.frame.size.height)];
            
            NSURL *urls=[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/api/Html/ApiResoShow.aspx?&Key=%@&TVInfoId=%@&Deptid=%@&Resoid=82",ddkey,ddtvinfo,deptid]]];
            NSLog(@"%@",urls);
            [jiemianview addSubview:self.webView];
            NSURLRequest * request = [NSURLRequest requestWithURL:urls];
            //           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
            self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            [self.webView loadRequest:request];
            if (i == 2) {
                button.tintColor =[UIColor redColor];
            }
            else{
                button.tintColor =[UIColor grayColor];
            }
        }else if(buttonClick.tag == 3){
            [jiemianview removeFromSuperview];
            jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55)];
            jiemianview.backgroundColor=RGBColor(248, 248, 248);
            [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*3, 42, kongView.frame.size.width/titleArray.count,3);
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,jiemianview.frame.size.width, jiemianview.frame.size.height)];
            
            NSURL *urls=[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/api/Html/ApiResoShow.aspx?&Key=%@&TVInfoId=%@&Deptid=%@&Resoid=87",ddkey,ddtvinfo,deptid]]];
            NSLog(@"%@",urls);
            [jiemianview addSubview:self.webView];
            NSURLRequest * request = [NSURLRequest requestWithURL:urls];
            //           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
            self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            [self.webView loadRequest:request];
            if (i == 3) {
                button.tintColor =[UIColor redColor];
            }
            else{
                
                button.tintColor =[UIColor grayColor];
            }
            
        }else{
            
            view.hidden = YES;
            button.tintColor = [UIColor grayColor];
        }
    }
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50,self.view.frame.size.width, self.view.frame.size.height-104) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    RGBColor(248, 248, 248);
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SheQugkTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];

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

        return 44;

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        SheQugkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        tableView.separatorStyle = NO;
        cell.SheQuM=_dataArray[indexPath.row];
        return cell;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SheQUwebViewController *SheQUwebV = [[SheQUwebViewController alloc] init];
    SheQuModel * SheQuM=_dataArray[indexPath.row];
    SheQUwebV.webid= SheQuM.NewsId;
    NSLog(@"%@",SheQUwebV.webid);
    [self.navigationController pushViewController:SheQUwebV animated:YES];
    
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
        [tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableView.mj_header endRefreshing];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
