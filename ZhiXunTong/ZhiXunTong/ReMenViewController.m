//
//  ReMenViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/10.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ReMenViewController.h"
#import "PchHeader.h"

#import "ReMemmModel.h"
#import "ReMenTableViewCell.h"
#import "TPXiaoQingViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface ReMenViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
  
    NSArray *ceshiArray;
    
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *idi;
}
@property (nonatomic, strong)NSMutableArray *saveDataArray;
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@end

@implementation ReMenViewController
-(NSMutableArray *)saveDataArray{
    if (!_saveDataArray) {
        _saveDataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _saveDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
         [self initTable];
    NSLog(@"aakey:%@  --%@--%@",aakey,aaid,aatvinfo);
//
    [self setupRefresh];
    
    
}
-(void)lodedate{
        NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] Userid:aaid Keys:aakey Tvinfo:aatvinfo pages:@"10" page:strpage ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSArray *tempArray=[ReMemmModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
      
        if (self.currentPage==1) {
            [self.saveDataArray removeAllObjects];
        }
        
        [self.saveDataArray addObjectsFromArray:tempArray];
          NSLog(@"_saveDataArray==%@",self.saveDataArray);
        [_tableView reloadData];
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1) {
            [_tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];

}
-(void)initView
{
    self.navigationItem.title=@"热门话题";
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lvse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)initTable{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    
    _tableView.rowHeight = 140;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.separatorStyle=UITableViewCellEditingStyleNone;
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.saveDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReMenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"ReMenTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    ReMemmModel *modelss=[self.saveDataArray objectAtIndex:indexPath.row];
    if ([modelss.vote containsString:@"0"]) {
        cell.labcj.text=@"已参加";
    }else{
    
    cell.labcj.text=@"未参加";
    }
    cell.lable_title.text=modelss.title;
    if (modelss.count.length>0) {
        cell.lable_cont.text=modelss.count;
    }else{
        cell.lable_cont.text=@"0";
    }
    
    NSString *ss=[NSString stringWithFormat:@"%@%@",URL,modelss.image];
    NSLog(@"ss=%@",ss);
    NSURL *url=[NSURL URLWithString:ss];
    UIImage *image=[UIImage imageNamed:@"默认图片.png"];
    [cell.image_bak sd_setImageWithURL:url placeholderImage:image];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    TPXiaoQingViewController *toupiao=[[TPXiaoQingViewController alloc] init];
    ReMemmModel *typeShop=self.saveDataArray[indexPath.row];
    toupiao.vote=typeShop.vote;
     toupiao.idi=typeShop.id;
    toupiao.titlevi=typeShop.title;
    [self.navigationController pushViewController:toupiao animated:NO];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self lodedate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self lodedate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
