//
//  GRXiaoXiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GRXiaoXiViewController.h"
#import "YJSegmentedControl.h"
#import "PchHeader.h"
#import "GRXiaoXiModel.h"
#import "GRXiaoXiTableViewCell.h"
@interface GRXiaoXiViewController ()<UITableViewDataSource,UITableViewDelegate,YJSegmentedControlDelegate>{
    UITableView *_tableView;
    NSArray *titleArray;
}

@end

@implementation GRXiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"消息提醒";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-60)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    titleArray = @[@"全部",@"社区消息",@"物业消息",@"系统消息"];
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor greenColor] buttonDownColor:[UIColor greenColor] Delegate:self];
    [self.view addSubview:segment];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -- 遵守代理 实现代理方法
//1-------2 办事
- (void)segumentSelectionChange:(NSInteger)selection{
    NSLog(@"%@",[titleArray objectAtIndex:selection]);

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRXiaoXiTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"GRXiaoXiTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    return cell;
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
