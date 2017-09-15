//
//  BaiKeViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BaiKeViewController.h"
#import "PchHeader.h"
#import "CBHeaderChooseViewScrollView.h"
#import "SHBKModel.h"
#import "BaiKeTableViewCell.h"
#import "BaiKeXqViewController.h"
@interface BaiKeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *titleArray;
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    
    NSString *aaid;
    NSMutableDictionary *userInfo;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    NSArray *shbaikeArray;
    NSInteger aNun;
}
@end

@implementation BaiKeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray =[NSMutableArray arrayWithCapacity:0];
   
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-64)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    [self baike];
}
-(void)daohang{
    self.navigationItem.title=@"生活百科";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    CBHeaderChooseViewScrollView *headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [self.view addSubview:headerView];
    [headerView setUpTitleArray:titleArray titleColor:nil titleSelectedColor:[UIColor greenColor] titleFontSize:0];
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        NSLog(@"点击了第%ld个按钮",x+1);
        [SVProgressHUD showSuccessWithStatus:[titleArray objectAtIndex:x]];
        [_saveArray removeAllObjects];
        
        if (x==0) {
            [self shbaike:@""];
//            aNun=0;
            //            self.currentPage=1;
            //            [self SheQuShengHuo];
        }else{
//            aNun=x-1;
            [self shbaike:[NSString stringWithFormat:@"%ld",x-1]];
        }
    };
}
-(void)baike{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method=livingtypes&TVInfoId=&Key=
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
            [self shbaike:@""];
        }
        
        //        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
//生活百科
-(void)shbaike:(NSString *)sender
{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=alllist&TVInfoId=%@&Key=%@&DeptId=%@&Page=1&PageSize=10&typeid=%@",URL,tvinfoId,key,deptid,sender];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        _saveArray=[SHBKModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
        //        sqshArray2=[[data objectForKey:@"Data"] valueForKey:@"title"];
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
    
    return 156;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaiKeTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"BaiKeTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    SHBKModel *mode=[_saveArray objectAtIndex:indexPath.row];
    cell.lab_tit.text=mode.title;
    cell.lab_nei.text=mode.type;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    return  cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选了了第%ld行",indexPath.row);
    SHBKModel *mode=[_saveArray objectAtIndex:indexPath.row];
    BaiKeXqViewController *BaiKeXq=[[BaiKeXqViewController alloc] init];
    BaiKeXq.mid=mode.id;
    [self.navigationController pushViewController:BaiKeXq animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
