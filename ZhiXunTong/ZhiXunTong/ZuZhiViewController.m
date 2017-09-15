//
//  MainViewController.m
//  MLMSegmentPage
//
//  Created by my on 16/11/4.
//  Copyright © 2016年 my. All rights reserved.
//

#import "ZuZhiViewController.h"
#import "PchHeader.h"
#import "WebClient.h"
#import "ZUzhiModel.h"
#import "ZuZhidaTableViewCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"



#define ColorWithRGB(r,g,b,p)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p]
#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 10.0f           // 第一个按钮的Y坐标
#define Width_Space 15.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 30.0f    // 高
#define Button_Width 85.0f      // 宽
#define Width_S 115.0f
#define Button_W 100.0f
@interface ZuZhiViewController ()<UIScrollViewDelegate,UIWebViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_viewArray;
    UIPageControl *_pageControl;
    NSMutableArray *_buttonArray;
    UIView *kongView ;
    NSArray *titleArray;
    UIView *view;
    UIButton *button;
    UIView *jiemianview;
    UIButton *butsous;
    
    UILabel *_placeholderLabel;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    NSString *username;
    UITableView *tableView;
    NSMutableArray *_dataArray;
    NSString *time;
   
    
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@property(strong ,nonatomic) UIWebView * webView;
@property (strong ,nonatomic)UITextField *textFile;
@end

@implementation ZuZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    Deptid=[userDefaults objectForKey:DeptId];
    username=[[arry objectAtIndex:0] objectForKey:@"userName"];
    self.title=@"组织概况";
    [self changeButton];
//    [self scroll];
    //返回按钮
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
- (void)changeButton{
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    //2个内容切换的button
   kongView= [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.view.bounds.size.width-60,50)];
    kongView.backgroundColor = [UIColor whiteColor];
   titleArray = @[@"所在组织",@"组织介绍",@"组织架构"];
    
    for (int i = 0 ; i < titleArray.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake( kongView.frame.size.width/titleArray.count*i, 5, kongView.frame.size.width/titleArray.count, 50);
         [button setFont:[UIFont systemFontOfSize:14.0f]];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(-7, 0, 7, 0);
        button.tintColor = [UIColor grayColor];
        if (i == 0) {
            button.tintColor =[UIColor redColor];
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [kongView addSubview:button];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(kongView.frame.size.width/titleArray.count*i, 42, kongView.frame.size.width/titleArray.count,2)];
        view.backgroundColor = [UIColor redColor];
        if (i) {
            view.hidden = YES;
        }
        [kongView addSubview:view];
        [kongView addSubview:button];
        [_viewArray addObject:view];
        [_buttonArray addObject:button];
        
    }
    UIView *xView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    xView.backgroundColor = [UIColor clearColor];
    [kongView addSubview:xView];
    
    jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height/7.5)];
    jiemianview.backgroundColor=RGBColor(248, 248, 248);
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake(20,  10, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= [UIColor orangeColor].CGColor;
    _textFile.placeholder = @"请输入身份证号码";
    _textFile.layer.borderWidth= 1.0f;
    butsous=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.6+20,10,(Screen_Width-Screen_Width/1.6-40), 35)];
    [butsous.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    //    [_butdata setTitle:@"请选择时间" forState:UIControlStateNormal];
    [butsous setFont:[UIFont systemFontOfSize:14.0f]];
//    [butsous.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    butsous.layer.borderColor= [UIColor orangeColor].CGColor;
    butsous.backgroundColor=[UIColor orangeColor];
    [butsous setTitle:@"查询" forState:UIControlStateNormal];
    butsous.layer.borderWidth= 1.0f;
    [butsous addTarget:self action:@selector(butsousayuan) forControlEvents:UIControlEventTouchUpInside];
    [butsous setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jiemianview addSubview:butsous];
    [jiemianview addSubview:_textFile];
    [self.view addSubview:jiemianview];
    [self.view addSubview:kongView];
}

- (void)buttonClick:(UIButton *)buttonClick{
//    UIButton *button;
    for (int i = 0; i<titleArray.count; i++) {
      view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == 0) {
            [jiemianview removeFromSuperview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*0, 42, kongView.frame.size.width/titleArray.count,3);
            jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height/7.5)];
            jiemianview.backgroundColor=RGBColor(248, 248, 248);
            [self.view addSubview:jiemianview];
            _textFile= [[UITextField alloc]initWithFrame:CGRectMake(20,  10, Screen_Width/1.6 ,35)];
            _textFile.backgroundColor = [UIColor whiteColor];
            _textFile.font = [UIFont systemFontOfSize:14.f];
            _textFile.textColor = [UIColor blackColor];
            _textFile.textAlignment = NSTextAlignmentLeft;
            _textFile.layer.borderColor= [UIColor orangeColor].CGColor;
            _textFile.placeholder = @"请输入身份证号码";
            _textFile.layer.borderWidth= 1.0f;
            butsous=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.6+20,10,(Screen_Width-Screen_Width/1.6-40), 35)];
            [butsous.layer setMasksToBounds:YES];
            //      _but.font=[UIFont systemFontOfSize:13];
            //    [_butdata setTitle:@"请选择时间" forState:UIControlStateNormal];
            [butsous setFont:[UIFont systemFontOfSize:14.0f]];
            //    [butsous.layer setCornerRadius:5.0];//设置矩形四个圆角半径
            butsous.layer.borderColor= [UIColor orangeColor].CGColor;
            butsous.backgroundColor=[UIColor orangeColor];
            [butsous setTitle:@"查询" forState:UIControlStateNormal];
            butsous.layer.borderWidth= 1.0f;
            [butsous addTarget:self action:@selector(butsousayuan) forControlEvents:UIControlEventTouchUpInside];
            [butsous setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [jiemianview addSubview:butsous];
            [jiemianview addSubview:_textFile];

            if (i == 0) {
                button.tintColor =[UIColor redColor];
            }else{
            
               button.tintColor =[UIColor grayColor];
            }
        }
       else if (buttonClick.tag == 1) {
           [jiemianview removeFromSuperview];
           jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55)];
           jiemianview.backgroundColor=RGBColor(248, 248, 248);
            [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*1, 42, kongView.frame.size.width/titleArray.count,3);
           self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,jiemianview.frame.size.width, jiemianview.frame.size.height)];
           
           NSURL *urls=[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/api/Html/Party.aspx?&Key=%@&TVInfoId=%@&Deptid=%@&id=0",ddkey,ddtvinfo,Deptid]]];
           NSLog(@"%@",urls);
           [jiemianview addSubview:self.webView];
             NSURLRequest * request = [NSURLRequest requestWithURL:urls];
//           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
           self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
           [self.webView loadRequest:request];
           if (i == 1) {
               button.tintColor =[UIColor redColor];
           }else{
               
               button.tintColor =[UIColor grayColor];
           }
           
        }
       else if (buttonClick.tag == 2) {
           [jiemianview removeFromSuperview];
           jiemianview=[[UIView alloc]initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-55)];
           jiemianview.backgroundColor=RGBColor(248, 248, 248);
           [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*2, 42, kongView.frame.size.width/titleArray.count,3);
           self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,jiemianview.frame.size.width, jiemianview.frame.size.height)];
           
           NSURL *urls=[NSURL URLWithString:[URL stringByAppendingString:[NSString stringWithFormat:@"/api/Html/Party.aspx?&Key=%@&TVInfoId=%@&Deptid=%@&id=1",ddkey,ddtvinfo,Deptid]]];
           NSLog(@"%@",urls);
           [jiemianview addSubview:self.webView];
           NSURLRequest * request = [NSURLRequest requestWithURL:urls];
           //           NSURLRequest * request = [NSURLRequest requestWithURL:request]];
           self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
           
           [self.webView loadRequest:request];

           if (i == 2) {
               button.tintColor =[UIColor redColor];
           }
           else{
               
               button.tintColor =[UIColor grayColor];
           }
        }else{
            view.hidden = YES;
            button.tintColor = [UIColor grayColor];
        }
        
    }


}
-(void)butsousayuan{
    if (_textFile.text.length != 18){
             [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];

    }else{
        // 正则表达式判断基本 身份证号是否满足格式
        NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
        //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
        NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if([identityStringPredicate evaluateWithObject:_textFile.text]){
            //** 开始进行校验 *//
            
            //将前17位加权因子保存在数组里
            NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++) {
                NSInteger subStrIndex = [[_textFile.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                idCardWiSum+= subStrIndex * idCardWiIndex;
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            //得到最后一位身份证号码
            NSString *idCardLast= [_textFile.text substringWithRange:NSMakeRange(17, 1)];
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            NSLog(@"idCardMod==%ld",idCardMod);
            //if(idCardMod==2) {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                    [[WebClient sharedClient] Organize:ddtvinfo Keys:ddkey deptid:Deptid idcard:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                        NSLog(@"%@",resultObject);
                        _muipArray=[resultObject objectForKey:@"Data"];
                        NSArray *array=[[resultObject objectForKey:@"Data"] valueForKey:@"position"];
                          NSString *position=[array objectAtIndex:0];
                        _dataArray=[ZUzhiModel mj_objectArrayWithKeyValuesArray:_muipArray];
                        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, jiemianview.frame.size.width-10, 20)];
                        lab.font=[UIFont systemFontOfSize:13.0f];
                        lab.text=[NSString stringWithFormat:@"你所在的党组织在:%@",position];
                        
                        _dataArray=[ZUzhiModel mj_objectArrayWithKeyValuesArray:_muipArray];
                     
                          [self initTableView];
                    }];
            }else{
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码

                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                    [[WebClient sharedClient] Organize:ddtvinfo Keys:ddkey deptid:Deptid idcard:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                         NSLog(@"%@",resultObject);
                          _muipArray=[resultObject objectForKey:@"Data"];
//                        NSString *position=[[resultObject objectForKey:@"Data"] valueForKey:@"position"];
                        _dataArray=[ZUzhiModel mj_objectArrayWithKeyValuesArray:_muipArray];
                        NSArray *array=[[resultObject objectForKey:@"Data"] valueForKey:@"position"];
                        NSString *position=[array objectAtIndex:0];
                        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, jiemianview.frame.size.width-10, 20)];
                        lab.font=[UIFont systemFontOfSize:13.0f];
                        lab.text=[NSString stringWithFormat:@"你所在的党组织在:%@",position];
                        [jiemianview addSubview:lab];
                        [self initTableView];
                      
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
            }
        }
    
    }


}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/4,self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.height/4) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    RGBColor(248, 248, 248);
  
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZuZhidaTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 77;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZuZhidaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.ZUzhiM=_dataArray[indexPath.row];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    DetailsViewController *sp = [[DetailsViewController alloc] init];
    //    sp.uid=_uid;
    //    OutModel *typeShop=_dataArray[indexPath.row];
    //    sp.id=typeShop.id;
    //    [self.navigationController pushViewController:sp animated:YES];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self butsousayuan];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self butsousayuan];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        tableView.mj_footer.hidden = YES;
        [self headerRereshing];
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    [tableView.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    
}
@end
