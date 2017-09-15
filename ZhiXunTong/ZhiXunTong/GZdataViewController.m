//
//  GZdataViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GZdataViewController.h"
#import "PchHeader.h"
#import "WSDatePickerView.h"
#import "DatarzTableViewCell.h"
#import "TJdataViewController.h"
#import "DataXQViewController.h"
#import "ShiJModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface GZdataViewController ()<UITableViewDelegate, UITableViewDataSource>{

    UITableView *_tableView;
       UIButton *butxiala;
       NSString *date2;
     NSString *strcookie;
     NSMutableArray *ModelArray;
    NSMutableArray *blogTypeArray;
 //   NSArray *ablogType;
    
    NSArray *dd;
    NSString *e;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@property (strong ,nonatomic)UITextField *textFile;
@end

@implementation GZdataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ModelArray=[NSMutableArray arrayWithCapacity:0];
     blogTypeArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
   
   self.navigationItem.title=@"工作日志";
    [self initui];
    [self inittableviews];
     [self setupRefresh];
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
-(void)inittableviews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Screen_Width, Screen_height-140) style:UITableViewStyleGrouped];
  _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DatarzTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];

}
-(void)initui{

    UIView *viewhj=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    viewhj.backgroundColor=[UIColor whiteColor];
    UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, viewhj.frame.size.height-5, Screen_Width, 5)];
    viewxian.backgroundColor=RGBColor(238, 238, 238);
    [viewhj addSubview:viewxian];
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake(10,  10, Screen_Width/1.4,30)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(210, 210, 210).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewhj addSubview:_textFile];
    
    UIButton  *buttj=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4+20+Screen_Width/2.1,10, Screen_Width/6,30)];
    buttj.backgroundColor=[UIColor orangeColor];
    buttj.clipsToBounds=YES;
    buttj.layer.cornerRadius=5;
    [buttj addTarget:self action:@selector(buttjsousuo) forControlEvents:UIControlEventTouchUpInside];
    [buttj setTitle:@"搜索" forState:UIControlStateNormal];
    [viewhj addSubview:buttj];
    [self.view addSubview:viewhj];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ModelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        
    DatarzTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // NSString *aa=[ablogType objectAtIndex:indexPath.row];
    ShiJModel *mode=[ModelArray objectAtIndex:indexPath.row];
//    NSLog(@"blogType==========%@",mode.blogType);
    NSArray *array = [mode.blogType componentsSeparatedByString:@","];
    NSLog(@"%@",array);
    NSString *a = [mode.blogType stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSString *b = [a stringByReplacingOccurrencesOfString:@"1" withString:@"巡查"];
    NSString *c = [b stringByReplacingOccurrencesOfString:@"2" withString:@"宣传"];
    NSString *d = [c stringByReplacingOccurrencesOfString:@"3" withString:@"走访"];
     e= [d stringByReplacingOccurrencesOfString:@"4" withString:@"处理"];
    NSLog(@"eeeeeee==%@",e);
    cell.labqt.text=[NSString stringWithFormat:@"%@",e];
   // NSArray *titleslab=@[@"巡查",@"宣传",@"走访",@"处理"];
   cell.labren.text=[NSString stringWithFormat:@"%@",blogTypeArray[indexPath.row] ];
   cell.ShiJM=ModelArray[indexPath.row];
    
    return cell;
        
  
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewwei=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    viewwei.backgroundColor=[UIColor whiteColor];
    UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 5)];
    viewxian.backgroundColor=RGBColor(238, 238, 238);
    [viewwei addSubview:viewxian];
    UIButton *butwei=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/2.5)/2, 20, Screen_Width/2.5, 30)];
    butwei.backgroundColor=[UIColor redColor];
    [butwei setTitle:[NSString stringWithFormat:@"添加日志"] forState:UIControlStateNormal];
    butwei.clipsToBounds=YES;
      [butwei addTarget:self action:@selector(buttjxuz) forControlEvents:UIControlEventTouchUpInside];
    butwei.layer.cornerRadius=5;
    [viewwei addSubview:butwei];
    return viewwei;
    
    
}
//设置标题尾的宽度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        DataXQViewController *DataXQVi = [[DataXQViewController alloc] init];
       ShiJModel *ShiJMo=ModelArray[indexPath.row];
    DataXQVi.biaoti=ShiJMo.blogName;
    DataXQVi.wgy=[NSString stringWithFormat:@"%@",blogTypeArray[indexPath.row] ];
    NSArray *array = [ShiJMo.blogType componentsSeparatedByString:@","];
    NSLog(@"%@",array);
    NSString *a = [ShiJMo.blogType stringByReplacingOccurrencesOfString:@"," withString:@" "];
    NSString *b = [a stringByReplacingOccurrencesOfString:@"1" withString:@"巡查"];
    NSString *c = [b stringByReplacingOccurrencesOfString:@"2" withString:@"宣传"];
    NSString *d = [c stringByReplacingOccurrencesOfString:@"3" withString:@"走访"];
    e= [d stringByReplacingOccurrencesOfString:@"4" withString:@"处理"];
    DataXQVi.leix=[NSString stringWithFormat:@"%@",e];
    DataXQVi.xiangq=ShiJMo.blogContent;
    DataXQVi.image=ShiJMo.blogPic;
    [self.navigationController pushViewController:DataXQVi animated:YES];
}

-(void)dataxuz{
WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        
        
        date2= [startDate stringWithFormat:@"yyyy-MM-dd"];
//        strpangd=[[NSString stringWithFormat:@"%@",date2]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"时间： %@",date2);
        [butxiala setTitle:date2 forState:UIControlStateNormal];
    
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];

}
-(void)buttjxuz{
    TJdataViewController *TJdataV=[[TJdataViewController alloc] init];
    [self.navigationController pushViewController:TJdataV animated:NO];

}

-(void)buttjsousuo{
    NSString  *strend=[[NSString stringWithFormat:@"%@",_textFile.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/blog/getOneStaffBlogById.do?pageSize=10&pageCurrent=%ld&field=%@&Cookie=%@",_currentPage,strend,strcookie];
    //计算开始时间到结束时间的天数
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data========%@",data);
        NSArray *tempArray2=[ShiJModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] objectForKey:@"list"]];
        
//        ShiJModel *mode=[ModelArray objectAtIndex:0];
//        NSLog(@"list=%@",mode.blogType);
        
        NSArray *tempArray=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"gridStaffApp"] valueForKey:@"gridStaffName"];
        if (self.currentPage==1) {
            [ModelArray removeAllObjects];
            [blogTypeArray removeAllObjects];
          
        }
        
        [ModelArray addObjectsFromArray:tempArray2];
        NSLog(@"%@",ModelArray);
        [blogTypeArray addObjectsFromArray:tempArray];

        [_tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"数据加载成功"];
        

        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self buttjsousuo];
    
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
    [self buttjsousuo];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
