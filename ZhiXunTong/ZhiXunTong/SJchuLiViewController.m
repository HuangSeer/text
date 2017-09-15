//
//  SJchuLiViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SJchuLiViewController.h"
#import "PchHeader.h"
#import "DatarzTableViewCell.h"
#import "AddSJViewController.h"
#import "SJxqViewController.h"
#import "SjModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"

@interface SJchuLiViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UIButton *button;
    UIView *kongView ;
    NSArray *titleArray;
    NSArray *imageArray;
    UIView *view;
    NSMutableArray *_viewArray;
    UITableView *_tableView;
    NSMutableArray *_buttonArray;
    NSString *strcookie;
    NSMutableArray *ModelArray;
    NSMutableArray *str;
    NSMutableArray *str2;
    NSMutableArray *str3;
    NSMutableArray *str4;
     NSMutableArray *str5;
    
  int strss;
    int eventStatus;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@property (strong ,nonatomic)UITextField *textFile;
@end

@implementation SJchuLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ModelArray=[NSMutableArray arrayWithCapacity:0];
    str=[NSMutableArray arrayWithCapacity:0];
    str2=[NSMutableArray arrayWithCapacity:0];
    str3=[NSMutableArray arrayWithCapacity:0];
    str4=[NSMutableArray arrayWithCapacity:0];
    str5=[NSMutableArray arrayWithCapacity:0];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
      self.navigationItem.title=@"事件处理";
//    [self loddatesj];
    [self inittoubusj];
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
-(void)loddatesj{
    NSLog(@"%ld",_currentPage);
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/getAllEventInfoById.do?pageSize=10&pageCurrent=%ld&field=&eventStatus=%d&Cookie=%@",_currentPage,eventStatus,strcookie];

    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *tempArray=[SjModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] objectForKey:@"list"]];
        NSArray *tempArray1=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventLevel"] valueForKey:@"eventLevelName"];
        NSArray *tempArray2=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventType"] valueForKey:@"eventTypeName"];
        NSArray *tempArray3=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"sourceType"] valueForKey:@"sourceTypeName"];
        NSArray *tempArrays=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"gridStaffApp"] valueForKey:@"gridStaffName"];
        NSArray *tempArray4=[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventContent"];
        NSLog(@"%@",tempArray);
        if (self.currentPage==1) {
            [ModelArray removeAllObjects];
            [str removeAllObjects];
            [str2 removeAllObjects];
            [str3 removeAllObjects];
            [str4 removeAllObjects];
            [str5 removeAllObjects];
        }
        
        [ModelArray addObjectsFromArray:tempArray];
         NSLog(@"%@",ModelArray);
        [str addObjectsFromArray:tempArray1];
        [str2 addObjectsFromArray:tempArray2];
        [str3 addObjectsFromArray:tempArray3];
        [str4 addObjectsFromArray:tempArrays];
        [str5 addObjectsFromArray:tempArray4];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];


}
-(void)inittableviews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, Screen_Width, Screen_height-180) style:UITableViewStyleGrouped];
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DatarzTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
}
-(void)inittoubusj{
    eventStatus=0;
    strss=0;
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    //2个内容切换的button
    kongView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,110)];
    //    kongView.backgroundColor = [UIColor redColor];
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake(10,  5, Screen_Width/1.34,30)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(210, 210, 210).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [kongView addSubview:_textFile];
    
    UIButton  *buttj=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.25,5, Screen_Width/6,30)];
    buttj.backgroundColor=[UIColor orangeColor];
    buttj.clipsToBounds=YES;
    buttj.layer.cornerRadius=5;
    [buttj addTarget:self action:@selector(buttjsousuo) forControlEvents:UIControlEventTouchUpInside];
    [buttj setTitle:@"搜索" forState:UIControlStateNormal];
    [kongView addSubview:buttj];
    
    titleArray = @[@"待处理",@"处理中",@"已处理"];
    imageArray=@[@"dcl01.png",@"clz01.png",@"ybj01.png"];
    
    for (int i = 0 ; i < titleArray.count; i++) {
        int page=i/1;
       button=[[UIButton alloc]init];
        button.frame = CGRectMake(page*(Screen_Width/3), 40,Screen_Width/3, 60);
        [button setFont:[UIFont systemFontOfSize:14.0f]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i]]];
        [button setImage:image forState:UIControlStateNormal];
         [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(45.0, -image.size.width, 0.0, 0.0);
        button.imageEdgeInsets = UIEdgeInsetsMake(5.0, 35,20,35);
        
        UIView *viewxi=[[UIView alloc]initWithFrame:CGRectMake((page+1)*Screen_Width/3,40, 1, button.frame.size.height)];
        viewxi.backgroundColor=RGBColor(238, 238, 238);
        [kongView addSubview:viewxi];
        if (i == 0) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [kongView addSubview:button];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(page*(Screen_Width/3),100,Screen_Width/3,7)];
        view.backgroundColor = [UIColor redColor];
        if (i) {
            view.hidden = YES;
        }
        [kongView addSubview:view];
        [kongView addSubview:button];
        [_viewArray addObject:view];
        [_buttonArray addObject:button];
        
    }
    //    [self.view addSubview:jiemianview];
    

    
    [self.view addSubview:kongView];
    
}

- (void)buttonClick:(UIButton *)buttonClick{
    for (int i = 0; i<titleArray.count; i++) {
        view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == 0) {
            strss=0;
            view.hidden = NO;
            view.frame=CGRectMake(0, 100, Screen_Width/3,7);
            [ModelArray removeAllObjects];
            [str removeAllObjects];
            [str2 removeAllObjects];
            [str3 removeAllObjects];
            [str4 removeAllObjects];
            [str5 removeAllObjects];
            eventStatus=0;
    [self headerRereshing];
            if (i == 0) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else{
                
         [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }
        else if (buttonClick.tag == 1) {
            strss=1;
            view.hidden = NO;
            view.frame=CGRectMake(Screen_Width/3, 100,Screen_Width/3,7);
            [ModelArray removeAllObjects];
            [str removeAllObjects];
            [str2 removeAllObjects];
            [str3 removeAllObjects];
            [str4 removeAllObjects];
            [str5 removeAllObjects];
            eventStatus=1;
           [self headerRereshing];
            if (i == 1) {
             [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else{
                
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
        }
        else if (buttonClick.tag == 2) {
            strss=2;
            view.hidden = NO;
            view.frame=CGRectMake((Screen_Width/3)*2, 100,Screen_Width/3,7);
        
            eventStatus=2;
          [self headerRereshing];
            if (i == 2) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            else{
              [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        }else{
            view.hidden = YES;
            button.tintColor = [UIColor grayColor];
        }
        
    }
    
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
    cell.SjM=ModelArray[indexPath.row];
    
     cell.labqt.text=[NSString stringWithFormat:@"%@",str[indexPath.row]];
    cell.labren.text=[NSString stringWithFormat:@"%@",str2[indexPath.row]];

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
    [butwei setTitle:[NSString stringWithFormat:@"添加事件"] forState:UIControlStateNormal];
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
       SJxqViewController *SJxqV = [[SJxqViewController alloc] init];
       SjModel *SjM=ModelArray[indexPath.row];
       SJxqV.eventId=SjM.eventId;
       SJxqV.biaoti=SjM.eventTitle;
       SJxqV.time=SjM.editEventDate;
       SJxqV.leix=[NSString stringWithFormat:@"%@",str2[indexPath.row]];
       SJxqV.strcd=[NSString stringWithFormat:@"%@",str[indexPath.row]];
       SJxqV.strly=[NSString stringWithFormat:@"%@",str3[indexPath.row]];
       SJxqV.strname=[NSString stringWithFormat:@"%@",str4[indexPath.row]];
       SJxqV.xiangq=[NSString stringWithFormat:@"%@",str5[indexPath.row]];
        SJxqV.image=SjM.eventPic;
       [self.navigationController pushViewController:SJxqV animated:YES];

    

}
-(void)buttjxuz{
 AddSJViewController *AddSJV = [[AddSJViewController alloc] init];
    [self.navigationController pushViewController:AddSJV animated:YES];

}
-(void)buttjsousuo{
          NSString *strtextview=[[NSString stringWithFormat:@"%@",_textFile.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/getAllEventInfoById.do?pageSize=10&pageCurrent=%ld&field=%@&eventStatus=%d&Cookie=%@",_currentPage,strtextview,eventStatus,strcookie];
    
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *tempArray=[SjModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] objectForKey:@"list"]];
        NSArray *tempArray1=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventLevel"] valueForKey:@"eventLevelName"];
        NSArray *tempArray2=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventType"] valueForKey:@"eventTypeName"];
        NSArray *tempArray3=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"sourceType"] valueForKey:@"sourceTypeName"];
        NSArray *tempArrays=[[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"gridStaffApp"] valueForKey:@"gridStaffName"];
        NSArray *tempArray4=[[[data objectForKey:@"data"] objectForKey:@"list"] valueForKey:@"eventContent"];
        NSLog(@"%@",tempArray);
        if (self.currentPage==1) {
            [ModelArray removeAllObjects];
            [str removeAllObjects];
            [str2 removeAllObjects];
            [str3 removeAllObjects];
            [str4 removeAllObjects];
            [str5 removeAllObjects];
        }
        
        [ModelArray addObjectsFromArray:tempArray];
        NSLog(@"%@",ModelArray);
        [str addObjectsFromArray:tempArray1];
        [str2 addObjectsFromArray:tempArray2];
        [str3 addObjectsFromArray:tempArray3];
        [str4 addObjectsFromArray:tempArrays];
        [str5 addObjectsFromArray:tempArray4];
        [_tableView reloadData];
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
}


@end
