//
//  PingJViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PingJViewController.h"
#import "PchHeader.h"
#import "SpPlModel.h"
#import "FourSpXqTableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface PingJViewController ()<UITableViewDelegate, UITableViewDataSource>{
UITableView *tableViewd;
UIImageView *xingimgview;
 int xintager;
}
@property (strong,nonatomic) NSMutableArray *plArray;
@property(assign,nonatomic) NSInteger currentPage;
@end

@implementation PingJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"全部评价";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
      [self initTableView];
    [ self setupRefresh ];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)lodadeta{
_plArray=[NSMutableArray arrayWithCapacity:0];
    NSString *strurlpl=[NSString stringWithFormat:@"%@goodsEvaluate.htm?goods_id=%@&currentPage=%ld&pageSize=10",URLds,_intspid,_currentPage];
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSLog(@"sad==3333333333333333==2=2=2========%@",data);
        NSArray *plarr=[SpPlModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"] ];
        if (_currentPage==1) {
            [_plArray removeAllObjects];
        }
        [_plArray  addObjectsFromArray:plarr];
        NSLog(@"===%lu",_plArray.count);
        NSArray *tagerarray=[[data objectForKey:@"data"] valueForKey:@"evaluate_value"] ;
        xintager=[tagerarray[0] intValue];
        
        NSLog(@"%d",xintager);
        if (_plArray.count==0) {
            UILabel *labpl=[[UILabel alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-45)/2, Screen_Width, 45)];
            labpl.text=@"此件商品暂无评价!";
            labpl.textColor=[UIColor grayColor];
            labpl.textAlignment = UITextAlignmentCenter;
            labpl.font=[UIFont systemFontOfSize:16.0f];
            [self.view addSubview:labpl];
            
        }else{
            [tableViewd reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
    }];
}

- (void)initTableView {
    
    tableViewd = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStylePlain];
    tableViewd.delegate = self;
    tableViewd.dataSource = self;
    //组册cell
    tableViewd.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([FourSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Fourcell"];

    [self.view addSubview:tableViewd];
    
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
    
}
//每组cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _plArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
            return 75;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
            FourSpXqTableViewCell *cellc= [tableViewd dequeueReusableCellWithIdentifier:@"Fourcell"];

            cellc.SpPlM=_plArray[indexPath.row];
            cellc.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i = 0 ; i < xintager; i++) {
                xingimgview=[[UIImageView alloc]initWithFrame:CGRectMake(20*i, 27, 15, 15)];
                xingimgview.image=[UIImage imageNamed:@"星星"];
                [cellc.viewpf addSubview:xingimgview];
                
            }
            return cellc;
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self lodadeta];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableViewd reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableViewd.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self lodadeta];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableViewd reloadData];
        [tableViewd.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    tableViewd.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [tableViewd.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    tableViewd.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
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
