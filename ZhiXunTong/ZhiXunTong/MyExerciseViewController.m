//
//  MyExerciseViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "MyExerciseViewController.h"
#import "PchHeader.h"
#import "MyExerciseModel.h"
#import "MyExerciseTableViewCell.h"
@interface MyExerciseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
}

@end

@implementation MyExerciseViewController

-(void)viewDidAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的活动";
    [self postShuju];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height)];
    //隐藏表格滚动条
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.rowHeight = 110;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    [_tableView setTableFooterView:[UIView new]];
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
-(void)postShuju{
    
    NSString *strurl=[NSString stringWithFormat:@"http://192.168.1.222:8099/api/APP1.0.aspx?method=communityactivity&Key=21218CCA77804D2BA1922C33E0151105&TVInfoId=19&DeptId=851"];
   // NSString *string2 = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"CNLove=%@",data);
        _saveArray=[MyExerciseModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        MyExerciseModel *model=[_saveArray objectAtIndex:0];
        
        NSLog(@"activityname=%@",model.activityname);
    
        [_tableView reloadData];
    } failure:^(NSError *error)
     {
         NSLog(@"---------------%@",error);
         [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
     }];
}
#pragma mark - Table view data source
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyExerciseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyExerciseTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    MyExerciseModel *model=[_saveArray objectAtIndex:indexPath.row];
    cell.lab_name.text=[NSString stringWithFormat:@"%@",model.activityname];
    [cell.img_View sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.222:8099%@",model.imageurl]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    NSLog(@"http://192.168.1.222:8099/api%@",model.imageurl);
    [cell.btn_one setTitle:model.starttime forState:UIControlStateNormal];
    [cell.btn_two setTitle:model.site forState:UIControlStateNormal];
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
