//
//  BanShiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BanShiViewController.h"
#import "PchHeader.h"
#import "YJSegmentedControl.h"
#import "banshiModel.h"
#import "beiyongModel.h"
#import "webViewController.h"
#import "BSLieBiaoViewController.h"
@interface BanShiViewController ()<YJSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *leftTableView;
    UITableView *RigeTableView;
    
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    
    NSMutableArray *titleId;
    NSMutableArray *titleName;
    
    NSMutableArray *array;
    
    NSMutableArray *leftArray;
    NSMutableArray *rigeArray;
    NSArray *hangArray;
    
    BOOL _isRelate;
    NSString *strone;
    NSString *strtwo;
}
@property (assign, nonatomic) NSIndexPath *selIndex;
@end

@implementation BanShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];//预约办事
    titleId=[NSMutableArray arrayWithCapacity:0];
    titleName=[NSMutableArray arrayWithCapacity:0];
    leftArray=[NSMutableArray arrayWithCapacity:0];
    rigeArray=[NSMutableArray arrayWithCapacity:0];
    [self BanShiTitle];
    [self leftView];
    [self RigeView];
    
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"预约办事";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    NSArray * btnDataSource = titleName;
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) titleDataSource:btnDataSource backgroundColor:[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor orangeColor] buttonDownColor:[UIColor redColor] Delegate:self];
    [self.view addSubview:segment];
    
    [self segumentSelectionChange:0];
    
}
-(void)BanShiTitle
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    [[WebClient sharedClient] tvinfo:tvinfoId Deptid:deptid Keys:key ResponseBlock:^(id resultObject, NSError *error) {
        
        for (NSDictionary *arry in [resultObject objectForKey:@"Data"]) {
            //NSLog(@"arry=%@",arry);
            [titleName addObject:[arry objectForKey:@"genre"]];
            [titleId addObject:[arry objectForKey:@"id"]];
        }
        if (titleId.count>0 && titleName.count>0)
        {
            
        }
        if (error!=nil) {
            NSLog(@"出错了%@",error);
        }
        [self daohangView];
    }];
}

#pragma mark -- 遵守代理 实现代理方法
//1-------2 办事
- (void)segumentSelectionChange:(NSInteger)selection{
    //    NSLog(@"%@",)
    strone=[NSString stringWithFormat:@"%@",[titleName objectAtIndex:selection]];
    NSLog(@"id :%@",[titleName objectAtIndex:selection]);
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    [SVProgressHUD showWithStatus:@"加载中"];
    // 1 封装会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?TVInfoId=%@&date=%@&deptId=%@&method=booking&id=%@&Key=%@",URL,tvinfoId,DateTime,deptid,[titleId objectAtIndex:selection],key];
    NSLog(@"dict====%@",dict);
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"请求成功:%@", responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // NSLog(@"请求成功:%@", string);
        NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        array = [[NSMutableArray alloc] initWithArray:[banshiModel mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
        NSLog(@"array%@",array);
        if (array.count>0) {
            if (leftArray.count>0) {
                [leftArray removeAllObjects];
            }
            for (int i=0; i<array.count; i++)
            {
                banshiModel *mode=[array objectAtIndex:i];
                NSLog(@"genre=%@",mode.id);
                //hangArray=mode.Data;
                [leftArray addObject:mode.genre];
            }
            
            banshiModel *mode=[array objectAtIndex:0];
            strtwo=mode.genre;
            NSLog(@"mode.data==%@",mode.genre);
            hangArray=mode.Data;
            //默认选中表格第一行
            
            [leftTableView reloadData];
            [RigeTableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            if ([leftTableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
                [leftTableView.delegate tableView:leftTableView willSelectRowAtIndexPath:indexPath];
            }
            [leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
            
            if ([leftTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                
                [leftTableView.delegate tableView:leftTableView didSelectRowAtIndexPath:indexPath];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];
}
-(void)leftView
{
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 100, Screen_height-64) style:UITableViewStylePlain];
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    [leftTableView setTableFooterView:[UIView new]];
    [self.view addSubview:leftTableView];
}
-(void)RigeView
{
    RigeTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 44, Screen_Width-100, Screen_height-108) style:UITableViewStylePlain];
    RigeTableView.backgroundColor = [UIColor clearColor];
    RigeTableView.dataSource = self;
    RigeTableView.delegate = self;
    [self.view addSubview:RigeTableView];
    [RigeTableView setTableFooterView:[UIView new]];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == leftTableView)
    {
        return leftArray.count;
    }
    else if (tableView== RigeTableView)
    {
        return hangArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == leftTableView) {
        cell.textLabel.text = [leftArray objectAtIndex:indexPath.row];
        cell.backgroundColor=RGBColor(236, 236, 236);
        if(_selIndex==indexPath)
        {
            cell.textLabel.highlightedTextColor = [UIColor redColor];
            [cell.textLabel setTextColor:[UIColor redColor]];
        }
        else
        {
            cell.textLabel.highlightedTextColor = [UIColor blackColor];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }
    }
    else if (tableView==RigeTableView)
    {
        cell.textLabel.text=[[hangArray objectAtIndex:indexPath.row] objectForKey:@"genre"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==leftTableView) {
        UITableViewCell *cell = [leftTableView cellForRowAtIndexPath:_selIndex];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];
        [cell.textLabel setTextColor:[UIColor blackColor]];
        _selIndex=indexPath;
        NSLog(@"%@",_selIndex);
        
        UITableViewCell *celled = [leftTableView cellForRowAtIndexPath:indexPath];
        celled.textLabel.highlightedTextColor = [UIColor redColor];
        [celled.textLabel setTextColor:[UIColor redColor]];
        
        banshiModel *mode=[array objectAtIndex:indexPath.row];
        strtwo=mode.genre;
        NSLog(@"mode.data==%@",mode.genre);
        hangArray=mode.Data;
        [RigeTableView reloadData];
        [leftTableView reloadData];
    }
    else if (tableView==RigeTableView)
    {
        // banshiModel *model=[hangArray objectAtIndex:indexPath.row];
        NSString *aa=[[hangArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        NSString *titlestr=[[hangArray objectAtIndex:indexPath.row] objectForKey:@"genre"];
        NSLog(@"aa=%@",aa);
        BSLieBiaoViewController *bans=[[BSLieBiaoViewController alloc] initWithXZQ:aa];
        bans.strtitle=[NSString stringWithFormat:@"%@----->%@----->%@",strone,strtwo,titlestr];
        [self.navigationController pushViewController:bans animated:NO];
        NSLog(@"去超越");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
