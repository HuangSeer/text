//
//  ShengHuoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ShengHuoViewController.h"
#import "PchHeader.h"
#import "FaTieViewController.h"
#import "CBHeaderChooseViewScrollView.h"
#import "TouTiaoModel.h"
#import "ShengHuoTableViewCell.h"
@interface ShengHuoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    NSMutableArray *titleArray;
    
    NSString *aaid;
    NSMutableDictionary *userInfo;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    NSArray *sqshArray2;
//    YJSegmentedControl * segment;
}

@end

@implementation ShengHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray=[NSMutableArray arrayWithCapacity:0];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-64)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    
    [self fatie];
}
-(void)daohang{
    self.navigationItem.title=@"社区生活";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setTitle:@"发帖" forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(fatieClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
    
    CBHeaderChooseViewScrollView *headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [self.view addSubview:headerView];
    [headerView setUpTitleArray:titleArray titleColor:nil titleSelectedColor:[UIColor greenColor] titleFontSize:0];
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        [_saveArray removeAllObjects];
        NSLog(@"点击了第%ld个按钮",x+1);
        [SVProgressHUD showSuccessWithStatus:[titleArray objectAtIndex:x]];
        if (x==0) {
//            [titleArray removeAllObjects];
//            self.currentPage=1;
//            [self SheQuShengHuo];
            
        }else{
            [self SheQuShengHuo:[NSString stringWithFormat:@"%ld",x-1]];
        }
    };
}
-(void)fatie{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method=ModnewpostsType&TVInfoId=&Key=
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=ModnewpostsType&TVInfoId=%@&Key=%@",URL,tvinfoId,key];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *neiArray=[data objectForKey:@"Data"];
        for (int i=0; i<neiArray.count; i++) {
//            NSLog(@"%@",);
            [titleArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"type"]];
        }
        NSLog(@"titleArray=%@",titleArray);
        [titleArray insertObject:@"全部" atIndex:0];
        if (titleArray.count>0) {
            [self daohang];
            [self SheQuShengHuo:@""];
        }
       
//        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}

//社区生活
-(void)SheQuShengHuo:(NSString *)sender
{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method= allpost&TVInfoId=&Key=&DeptId=&Uid=&Page=&PageSize=
    //tvinfoId Keys:key Depid:deptid
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=allpost&TVInfoId=%@&Key=%@&DeptId=%@&Uid=3%@&Page=1&PageSize=10&typeid=%@",URL,tvinfoId,key,deptid,aaid,sender];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        _saveArray=[TouTiaoModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        sqshArray2=[[data objectForKey:@"Data"] valueForKey:@"title"];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _saveArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShengHuoTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ShengHuoTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    TouTiaoModel *mode=[_saveArray objectAtIndex:indexPath.item];
    
    [cell.imgVie sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    cell.lab_tit.text=[NSString stringWithFormat:@"%@",[sqshArray2 objectAtIndex:indexPath.row]];
    cell.lab_time.text=[NSString stringWithFormat:@"%@  %@",mode.type,mode.time];
    return  cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选了了第%ld行",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fatieClick
{
    FaTieViewController *FaTie=[[FaTieViewController alloc] init];
    [self.navigationController pushViewController:FaTie animated:NO];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
