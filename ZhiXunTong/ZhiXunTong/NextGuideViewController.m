//
//  NextGuideViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "NextGuideViewController.h"
#import "PchHeader.h"
#import "SYCell.h"
#import "GDetailsViewController.h"
#import "zhiNanModel.h"
@interface NextGuideViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *nextTableView;
    NSMutableArray *nextArray;
    NSString *nextId;
    NSString *nextTitle;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    NSMutableArray *_zhiNanArray;
}

@end

@implementation NextGuideViewController
-(id)initWithCoderNext:(NSString *)Myid Title:(NSString *)title
{
    if (self=[super init]){
        nextId=Myid;
        nextTitle=title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];//办事指南-----下一级
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    
    [self daohangView];
    [self nextGet];
    nextTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    nextTableView.delegate=self;
    nextTableView.dataSource=self;
    nextTableView.backgroundColor=[UIColor clearColor];
    [nextTableView setTableFooterView:[UIView new]];
    [self.view addSubview:nextTableView];
}
-(void)nextGet{
    [[WebClient sharedClient] BanShiNext:tvinfoId Keys:key Deptid:deptid ChuanID:nextId ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"next=%@",resultObject);
        _zhiNanArray = [[NSMutableArray alloc] initWithArray:[zhiNanModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        if (_zhiNanArray.count>0) {
            [nextTableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
    }];
}
-(void)daohangView
{
    self.navigationItem.title=nextTitle;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lvse.png"] forBarMetrics:UIBarMetricsDefault];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _zhiNanArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //nextTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    zhiNanModel *model=[_zhiNanArray objectAtIndex:indexPath.row];
    cell.textLabel.text=model.serve;
    
    nextTableView.separatorStyle = YES;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zhiNanModel *mode=[_zhiNanArray objectAtIndex:indexPath.row];
    
    GDetailsViewController *gdetails=[[GDetailsViewController alloc] initGDetaile:mode.categoryid Serve:mode.serve Procedures:mode.procedures Materials:mode.materials Responsible:mode.Responsible];
    [self.navigationController pushViewController:gdetails animated:NO];
    
    
}

@end
