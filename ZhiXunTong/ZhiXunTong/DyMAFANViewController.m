//
//  DyMAFANViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DyMAFANViewController.h"
#import "PchHeader.h"
#import "DyTableViewCell.h"

@interface DyMAFANViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArray;
    UIView *view;
    UIButton *button;
    NSMutableArray *_viewArray;
    NSMutableArray *_buttonArray;
      UIView *kongView ;
    UITableView *tableView;
    NSMutableArray *_dataArray;
    UIView *jiemianview;
    UILabel *_placeholderLabel;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    NSString *Status;
}

@end

@implementation DyMAFANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userInfo objectForKey:@"TVInfoId"];
    ddkey=[userInfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    Deptid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    [self changeButton];
     [self initTableView];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 4, 36, 36)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];

    // Do any additional setup after loading the view.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)changeButton{
    kongView= [[UIView alloc] initWithFrame:CGRectMake(70, 0, self.view.bounds.size.width-140,30)];
    kongView.backgroundColor = [UIColor whiteColor];
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    titleArray=@[@"党员",@"流动党员"];
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
    [[WebClient sharedClient] party:ddtvinfo Keys:ddkey deptid:Deptid shzt:@"0" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        Status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
        [tableView reloadData];
    }];
    UIView *xView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    xView.backgroundColor = [UIColor clearColor];
    [kongView addSubview:xView];
    
    [self.view addSubview:kongView];
    
}

- (void)buttonClick:(UIButton *)buttonClick{
    NSLog(@"%@-%@",_viewArray,_buttonArray);
    for (int i = 0; i<titleArray.count; i++) {
        view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == 0) {
            [jiemianview removeFromSuperview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*0, 42, kongView.frame.size.width/titleArray.count,3);
            [[WebClient sharedClient] party:ddtvinfo Keys:ddkey deptid:Deptid shzt:@"0" ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"%@",resultObject);
                Status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
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
            jiemianview.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:jiemianview];
            view.hidden = NO;
            view.frame=CGRectMake(kongView.frame.size.width/titleArray.count*1, 42, kongView.frame.size.width/titleArray.count,3);
            [[WebClient sharedClient] party:ddtvinfo Keys:ddkey deptid:Deptid shzt:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"%@",resultObject);
                 Status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                [self initTableView];
            }];
            
            if (i == 1) {
                button.tintColor =[UIColor redColor];
            }else{
                
                button.tintColor =[UIColor grayColor];
            }
   
            
        }else{
            
            view.hidden = YES;
            button.tintColor = [UIColor grayColor];
        }
        
    }
    
    
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60,Screen_Width, self.view.frame.size.height-60) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
     tableView.separatorStyle = NO;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if ([Status containsString:@"1"]) {
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 35)];
//        view.backgroundColor=[UIColor redColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, Screen_Width/9.4117, 35)];
    lab.text=@"姓名";
    lab.font=[UIFont systemFontOfSize:9.0f];
     lab.textAlignment = NSTextAlignmentCenter;
    lab.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    lab.layer.borderWidth = 0.5;//边框宽度
    UILabel *labfy=[[UILabel alloc]initWithFrame:CGRectMake(8+Screen_Width/9.4117, 0, Screen_Width/10.3225, 35)];
    labfy.text=@"年龄";
    labfy.font=[UIFont systemFontOfSize:9.0f];
     labfy.textAlignment = NSTextAlignmentCenter;
    labfy.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    labfy.layer.borderWidth = 0.5;//边框宽度
    UILabel *labdbd=[[UILabel alloc]initWithFrame:CGRectMake(8+Screen_Width/9.4117+Screen_Width/10.3225, 0, Screen_Width/4.3835, 35)];
    labdbd.text=@"部队";
    labdbd.font=[UIFont systemFontOfSize:9.0f];
         labdbd.textAlignment = NSTextAlignmentCenter;
    labdbd.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    labdbd.layer.borderWidth = 0.5;//边框宽度
    UILabel *labmingzu=[[UILabel alloc]initWithFrame:CGRectMake(8+Screen_Width/9.4117+Screen_Width/10.3225+Screen_Width/4.3835, 0, Screen_Width/9.69696, 35)];
    labmingzu.text=@"民族";
    labmingzu.font=[UIFont systemFontOfSize:9.0f];
       labmingzu.textAlignment = NSTextAlignmentCenter;
    labmingzu.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    labmingzu.layer.borderWidth = 0.5;//边框宽度
 
    UILabel *labnianyu=[[UILabel alloc]initWithFrame:CGRectMake(8+Screen_Width/9.4117+Screen_Width/10.3225+Screen_Width/4.3835+Screen_Width/9.69696, 0, Screen_Width/4.507, 35)];
    labnianyu.text=@"出生年月";
    labnianyu.font=[UIFont systemFontOfSize:9.0f];
      labnianyu.textAlignment = NSTextAlignmentCenter;
    labnianyu.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    labnianyu.layer.borderWidth = 0.5;//边框宽度
    UILabel *labdianhua=[[UILabel alloc]initWithFrame:CGRectMake(8+Screen_Width/9.4117+Screen_Width/10.3225+Screen_Width/4.3835+Screen_Width/9.69696+ Screen_Width/4.507, 0, Screen_Width/5.1612, 35)];
    labdianhua.text=@"联系方式";
    labdianhua.font=[UIFont systemFontOfSize:9.0f];
    labdianhua.textAlignment = NSTextAlignmentCenter;
    labdianhua.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    labdianhua.layer.borderWidth = 0.5;//边框宽度
    [view addSubview:labdianhua];
    [view addSubview:labnianyu];
    [view addSubview:labmingzu];
    [view addSubview:labdbd];
    [view addSubview:labfy];
    [view addSubview:lab];
    return view;
    }else{
    
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([Status containsString:@"1"]) {
         return  35;
    }else{
    
        return 0;
    }
   
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
    
    return 34;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        DyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    cell.DyMo=_dataArray[indexPath.row];
    return cell;
//    return nil;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SheQUwebViewController *SheQUwebV = [[SheQUwebViewController alloc] init];
//    SheQuModel * SheQuM=_dataArray[indexPath.row];
//    SheQUwebV.webid= SheQuM.NewsId;
//    NSLog(@"%@",SheQUwebV.webid);
//    [self.navigationController pushViewController:SheQUwebV animated:YES];
//    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
