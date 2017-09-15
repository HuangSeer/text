//
//  CheWeiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "CheWeiViewController.h"
#import "PchHeader.h"
#import "KaiSuoViewController.h"
#import "CheWeiTableViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CheWeiModel.h"
#import "AddCheWeiViewController.h"
#import "ZJInptutView.h"//在view界面展示内容
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self
@interface CheWeiViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,UIWebViewDelegate>
{
    UITableView *GuanliTableView;
    NSMutableArray *ShuArray;
    UIView * backView;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aaPagesize;
    NSString *aapage;
    NSString *aa;
    NSString *MyId;
    NSString *lockKey;
    
    UIView *home;
}
@property(strong,nonatomic)CBCentralManager* CM;
@property (nonatomic,strong) ZJInptutView *view_inputView;
@end

@implementation CheWeiViewController
//车位管理
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    
    [self panduan];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"车位管理";
  //  self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    [self DaoHang];
}
-(void)panduan{
    [[WebClient sharedClient] PanDuan:aatvinfo Keys:aakey State:@"3" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSString *ss=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"URL"]];
        if (ss.length>0) {
         //   home=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
           // [self.view addSubview:home];
            NSString *str=[NSString stringWithFormat:@"%@%@",URL,ss];
            NSLog(@"str=======%@",str);
           NSString *url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height-64)];
            _webView.scalesPageToFit = YES;
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            [self.view addSubview:_webView];
        }else{
           [self shuju];
            
        }
        if (error!=nil) {
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
        }
    }];
}

-(void)shuju
{
    [ShuArray removeAllObjects];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[WebClient sharedClient] CWSuo:aatvinfo Keys:aakey UserId:aaid PageSize:@"10" Page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"re=----------%@",resultObject);
        ShuArray=[CheWeiModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        NSString *sta=[resultObject objectForKey:@"Status"];
        int dd=[sta intValue];
        if (dd==1) {
            if (ShuArray.count>0) {
                [SVProgressHUD showSuccessWithStatus:@"数据加载成功"];
            }
            else{
                [SVProgressHUD showSuccessWithStatus:@"没有设备,请添加设备"];
            }
        }else if(dd==0){
            [SVProgressHUD showErrorWithStatus:@"0"];
        }
        NSLog(@"%@",ShuArray);
        [GuanliTableView reloadData];
    }];
}
-(void)DaoHang
{
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setTitle:@"添加" forState:UIControlStateNormal];
    //[backFen setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 220)];
    imgView.image=[UIImage imageNamed:@"背景1"];
    UIImageView *tubiao=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width/2-80, 30, 160, 160)];
    tubiao.image=[UIImage imageNamed:@"logoChewei"];
    [imgView addSubview:tubiao];
    
    GuanliTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    GuanliTableView.tableHeaderView=imgView;
    GuanliTableView.rowHeight=80;
    GuanliTableView.delegate=self;
    GuanliTableView.dataSource=self;
    GuanliTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:GuanliTableView];
    [GuanliTableView setTableFooterView:[UIView new]];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ShuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheWeiTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"CheWeiTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    CheWeiModel *model=[ShuArray objectAtIndex:indexPath.row];
    cell.lable_Tiele.text=model.lockName;
    [cell.btn_delete addTarget:self action:@selector(btndelete:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_delete.tag=indexPath.row;
    [cell.btn_revise addTarget:self action:@selector(btnrevise:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_revise.tag=indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    CheWeiModel *model=[ShuArray objectAtIndex:indexPath.row];
    
    NSString *SheBeiId=[NSString stringWithFormat:@"%@",model.lockNum];
    // NSLog(@"%@",[SheBeiId substringFromIndex:6]);
    MyId=[SheBeiId substringFromIndex:6];
    lockKey=[NSString stringWithFormat:@"%@",model.lockKey];
    
}
//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:{
            NSLog(@"蓝牙已打开,请扫描外设");
            KaiSuoViewController *kaisuo=[[KaiSuoViewController alloc] initLockKey:lockKey LockNum:MyId];
            [self.navigationController pushViewController:kaisuo animated:NO];
        }
            break;
        case CBCentralManagerStatePoweredOff:{
            NSLog(@"%ld",(long)central.state);
          //  [SVProgressHUD showErrorWithStatus:@"您还没有打开蓝牙"];
        }
            break;
            
        default:
            
            break;
    }
}
-(void)tianjia{
    NSLog(@"添加唉");
    AddCheWeiViewController *add=[[AddCheWeiViewController alloc] init];
    [self.navigationController pushViewController:add animated:NO];
}
-(void)btndelete:(UIButton *)sender
{
   // NSLog(@"删除------%ld",sender.tag);
    CheWeiModel *mode=[ShuArray objectAtIndex:sender.tag];
    NSString *bb=[NSString stringWithFormat:@"%d",mode.id];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[WebClient sharedClient] CWSuoDelete:aatvinfo Keys:aakey UserId:bb ResponseBlock:^(id resultObject, NSError *error) {
        NSString *sta=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
        int qq=[sta intValue];
        if (qq==1) {
            [SVProgressHUD showSuccessWithStatus:@"成功删除"];
            [self shuju];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
        }
        if (error!=nil) {
            [SVProgressHUD showErrorWithStatus:@"出错了"];
        }
        NSLog(@"删除=%@",resultObject);
    }];
    
}
-(void)btnrevise:(UIButton *)sender
{
    //NSLog(@"修改-------%ld",sender.tag);
    
    CheWeiModel *mode=[ShuArray objectAtIndex:sender.tag];
    aa=[NSString stringWithFormat:@"%d",mode.id];
    [self popInputSubview];

}
//展示 弹出框的输入内容 ybh7
- (void) popInputSubview
{
    NSLog(@"hahah");
    WS(weakSelf);// 防止循环引用
    self.view_inputView = [[ZJInptutView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height) andTitle:@"请输入设备名称" andPlaceHolderTitle:@"请输入"];
    [self.view addSubview:self.view_inputView];
    //    NSLog(@"%@-%@-%@-",ddkey,ddtvinfo,notid);
    self.view_inputView.removeView = ^(NSString *title){
        NSLog(@"hehehe--%@",title);
        [SVProgressHUD showWithStatus:@"加载中"];
        [[WebClient sharedClient] CWSuoRevise:aatvinfo Keys:aakey UserId:aa LockAddress:title ResponseBlock:^(id resultObject, NSError *error) {
            NSString *sta=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
            int duibi=[sta intValue];
            if (duibi==1) {
                [self shuju];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
            NSLog(@"修改=====%@",resultObject);
            
        }];
        
        // [weakSelf.button_popView setTitle:title forState:0];
        
        [weakSelf.view_inputView removeFromSuperview];
    };
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
