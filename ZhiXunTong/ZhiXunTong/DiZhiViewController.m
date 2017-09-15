

//
//  DiZhiViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DiZhiViewController.h"
#import "PchHeader.h"
#import "AddDizhiViewController.h"
#import "AddressGLTableViewCell.h"
#import "SpXqViewController.h"
#import "JfXDViewController.h"
@interface DiZhiViewController () <UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    int *times;
    NSString *time;
    NSMutableDictionary *userinfo;
    NSString *cookiestr;
    NSUserDefaults *userDefaults;
     NSString *phone;
   
}
@property(assign,nonatomic) NSInteger currentPage;
@end

@implementation DiZhiViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title=@"地址管理";

    [self lodadate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 准备初始化配置参数
    
    NSString *title = @"请注意";
    
    NSString *message = @"操作完成后您需要重新选择收货地址,请选择!";
    
    NSString *okButtonTitle = @"确定";
    // 初始化
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // 创建操作
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    // 添加操作
    
    [alertDialog addAction:okAction];
    
    // 呈现警告视图
    
    [self presentViewController:alertDialog animated:YES completion:nil];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    cookiestr=[userDefaults objectForKey:Cookiestr];

    UIView *viewdib=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height-110, Screen_Width, 50)];
    UIButton *butadd=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3, 5, Screen_Width/3, viewdib.frame.size.height-10)];
//    [butadd setBackgroundImage:[UIImage imageNamed:@"adddz"] forState:UIControlStateNormal];
    butadd.backgroundColor=RGBColor(0, 162, 0);
    [butadd setTitle:@" ＋ 新建地址" forState:UIControlStateNormal];
    butadd.font=[UIFont systemFontOfSize:14.0f];
    [butadd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [butadd addTarget:self action:@selector(butaddClick) forControlEvents:UIControlEventTouchUpInside];
    [viewdib addSubview:butadd];
    [self.view addSubview:viewdib];
    [self initTableView];
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

-(void)lodadate{
    NSString *strurlpl=[NSString stringWithFormat:@"%@getAddressList.htm?currentPage=1&Cookie=%@",URLds,cookiestr];
    NSLog(@"%@",strurlpl);
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSLog(@"sad===230m fmm,v  m ff,  ==2=2=2========%@",data);
        _dataArray=[DiZhiModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"list"]];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
    }];


}
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-110) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddressGLTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 2;
   
    
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
    
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressGLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.DiZhiM=_dataArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.addToCartsBlock = ^(AddressGLTableViewCell *cell) {
        [weakSelf myFavoriteCellAddToShoppingCart:cell];
    };
    cell.lodaBlock = ^(AddressGLTableViewCell *cell) {
        [weakSelf myFavoriteCellAddTo:cell];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_strsd containsString:@"1"]) {
        
    }else{
    
    DiZhiModel *dzm=_dataArray[indexPath.row];
//    NSString  *strbab=[NSString stringWithFormat:@"%@%@",dzm.areaName,dzm.area_info];
    NSInteger  introw=indexPath.row;
    NSLog(@"%ld",introw);
//    NSString  *introw=[NSString stringWithFormat:@"%ld", indexPath.row];
    self.ceellBackBlock(introw); //1
    [self.navigationController popViewControllerAnimated:YES];

    }
}
-(void)butaddClick{
    AddDizhiViewController *AddDizhiV=[[AddDizhiViewController alloc] init];
    [self.navigationController pushViewController:AddDizhiV animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;

}
- (void)myFavoriteCellAddToShoppingCart:(AddressGLTableViewCell *)cell{
    NSString *strid=[NSString stringWithFormat:@"%@",cell.DiZhiM.id];
   
    NSString *strurlpl=[NSString stringWithFormat:@"%@address_del.htm?id=%@",URLds,strid];
    NSLog(@"%@",strurlpl);
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSString *msg=[data objectForKey:@"msg"];
         [SVProgressHUD showSuccessWithStatus:msg];
        [self lodadate];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
    }];
  
  
}
- (void)myFavoriteCellAddTo:(AddressGLTableViewCell *)cell{
    AddDizhiViewController *AddDizhiV=[[AddDizhiViewController alloc] init];
    AddDizhiV.xiugaiid=cell.DiZhiM.id;
    [self.navigationController pushViewController:AddDizhiV animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
