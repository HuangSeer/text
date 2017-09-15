//
//  MainViewController.m
//  MLMSegmentPage
//
//  Created by my on 16/11/4.
//  Copyright © 2016年 my. All rights reserved.
//

#import "BangfuViewController.h"
#import "PchHeader.h"
#import "WebClient.h"
#import "ZCModel.h"
#import "BfzcTableViewCell.h"
#import "BfllModel.h"
#import "BfllTableViewCell.h"
#import "BFdxModel.h"
#import "BFdxTableViewCell.h"
#import "quntmodel.h"
#import "BfHdTableViewCell.h"
#import "BFhdModel.h"
#import "BFwebViewController.h"


#define ColorWithRGB(r,g,b,p)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:p]
#define Start_X 10.0f           // 第一个按钮的X坐标
#define Start_Y 10.0f           // 第一个按钮的Y坐标
#define Width_Space 15.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 30.0f    // 高
#define Button_Width 85.0f      // 宽
#define Width_S 115.0f
#define Button_W 100.0f
@interface BangfuViewController ()<UIScrollViewDelegate,UIWebViewDelegate,UITableViewDelegate, UITableViewDataSource>
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
     NSString *time;
    UITableView *tableView;
    NSMutableArray *_dataArray;
    NSMutableArray * modeArray;
    NSMutableArray *dictArray;
    NSMutableArray *_bfliArray;
    NSMutableArray *_bfhdArray;
     NSMutableArray *_bfdxArray;
    
}
@property(strong ,nonatomic) UIWebView * webView;
@property (strong ,nonatomic)UITextField *textFile;
@end

@implementation BangfuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];

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
    [self initTableView];
}
- (void)changeButton{
    [[WebClient sharedClient] JZBF:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
//        NSLog(@"%@",resultObject);
        titleArray=[[resultObject objectForKey:@"Data"] valueForKey:@"sort"];
//         NSLog(@"%@",titleArray);
        for (int i = 0 ; i < titleArray.count; i++) {
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake( kongView.frame.size.width/titleArray.count*i, 5, kongView.frame.size.width/titleArray.count, 50);
            [button setFont:[UIFont systemFontOfSize:13.0f]];
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
    }];
    //button的tag值
    time=@"0";
    [[WebClient sharedClient]BFZC:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        //今天开始拖控件，
        _dataArray=[ZCModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        [tableView reloadData];
    }];
    
    
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    //2个内容切换的button
    kongView= [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width-40,30)];
    kongView.backgroundColor = [UIColor whiteColor];
//    titleArray = @[@"帮扶政策",@"帮扶力量",@"帮扶力量",@"帮扶活动"];

    UIView *xView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    xView.backgroundColor = [UIColor clearColor];
    [kongView addSubview:xView];
    
    [self.view addSubview:jiemianview];
    [self.view addSubview:kongView];
}

- (void)buttonClick:(UIButton *)buttonClick{
    //    UIButton *button;
    time=[NSString stringWithFormat:@"%ld",(long)buttonClick.tag ];
    for (int i = 0; i<titleArray.count; i++) {
        view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == 0) {
            [jiemianview removeFromSuperview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*0, 42, kongView.frame.size.width/titleArray.count,3);
            [[WebClient sharedClient]BFZC:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"%@",resultObject);
                
                //今天开始拖控件，
                _dataArray=[ZCModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                [tableView reloadData];
            }];
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
            [[WebClient sharedClient]BFLL:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"BFLL==%@",resultObject);
                //今天开始拖控件，
                _bfliArray=[BfllModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                [self initTableView];
//                  [tableView reloadData];
            }];
            if (i == 1) {
                button.tintColor =[UIColor redColor];
            }else{
                
                button.tintColor =[UIColor grayColor];
            }
            
        }
        else if (buttonClick.tag == 2) {
           dictArray = @[
                                          @{
                                              @"title" : @"老年群体",
                                              @"image" : @"老年2"
                                              
                                              },
                                          @{
                                              @"title" : @"中年群体",
                                              @"image" : @"中年2"

                                              
                                              },
                                          @{
                                              @"title" :@"青年群体",
                                              @"image" : @"青年2"

                                              
                                              },
                                          @{
                                              @"title" : @"少年群体",
                                              @"image" : @"少年"
         
                                              
                                              } ,
                                          @{
                                              @"title" : @"其他群体",
                                              @"image" : @"其他2"
                                        
                                              
                                              } ];
            modeArray=[quntmodel mj_objectArrayWithKeyValuesArray:dictArray];
            NSLog(@"%@",modeArray);

            [jiemianview removeFromSuperview];
                      view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*2, 42, kongView.frame.size.width/titleArray.count,3);
            [[WebClient sharedClient]BFDX:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
                _bfdxArray=[BFdxModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
//                [self initTableView];
                  [tableView reloadData];
            }];
            if (i == 2) {
                button.tintColor =[UIColor redColor];
            }
            else{
                
                button.tintColor =[UIColor grayColor];
            }
        }else if(buttonClick.tag == 3){
            [jiemianview removeFromSuperview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*3, 42, kongView.frame.size.width/titleArray.count,3);
            [[WebClient sharedClient]BFHD:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"%@",resultObject);
                _bfhdArray=[BFhdModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
//                [self initTableView];
                [tableView reloadData];
            }];
            if (i == 3) {
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
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50,self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    RGBColor(248, 248, 248);
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BfzcTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
     [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BfllTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell2"];
         [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BFdxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell3"];
     [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BfHdTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell4"];
    [self.view addSubview:tableView];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([time containsString:@"1"]) {
        
        return _bfliArray.count;
    }else if ([time containsString:@"2"]){
    
     return _bfdxArray.count;
    }
    else if ([time containsString:@"3"]){
        
        return _bfhdArray.count;
    }
    else{
     return _dataArray.count;
        
    }
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([time containsString:@"1"]) {
    
      return 135;
    }
    else if ([time containsString:@"2"]){
        
        return 119;
    } else if ([time containsString:@"3"]){
        
        return 90;
    }else{
      return 44;
    
    }
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"time===%@",time);
    if ([time containsString:@"1"]) {
        BfllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.BfllM=_bfliArray[indexPath.row];
        return cell;
    }
    else if ([time containsString:@"2"]){
        BFdxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        quntmodel *quntm=modeArray[indexPath.row];
    [ cell.imagebf setImage:[UIImage imageNamed:quntm.image]];
        cell.labqt.text=[NSString stringWithFormat:@"%@",quntm.title];
        cell.BFdxM=_bfdxArray[indexPath.row];
        return cell;
    }
    else if ([time containsString:@"3"]){
        BfHdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        tableView.separatorStyle = NO;
//        quntmodel *quntm=modeArray[indexPath.row];
        cell.BFhdM=_bfhdArray[indexPath.row];
        return cell;
    }else{
    
    BfzcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.ZCM=_dataArray[indexPath.row];
    return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([time containsString:@"0"]){
            BFwebViewController *BFwebV = [[BFwebViewController alloc] init];
            ZCModel *ZCM=_dataArray[indexPath.row];
         BFwebV.panduanstr=@"0";
            BFwebV.webid=ZCM.id;
            [self.navigationController pushViewController:BFwebV animated:YES];
    
    
    }else if ([time containsString:@"3"]){
        BFwebViewController *BFwebV2 = [[BFwebViewController alloc] init];
        BFhdModel * BFhdMo=_bfhdArray[indexPath.row];
        BFwebV2.panduanstr=@"3";
        BFwebV2.webid= BFhdMo.id;
        [self.navigationController pushViewController:BFwebV2 animated:YES];
        
        
    }
    //    DetailsViewController *sp = [[DetailsViewController alloc] init];
    //    sp.uid=_uid;
    //    OutModel *typeShop=_dataArray[indexPath.row];
    //    sp.id=typeShop.id;
    //    [self.navigationController pushViewController:sp animated:YES];
}

@end
