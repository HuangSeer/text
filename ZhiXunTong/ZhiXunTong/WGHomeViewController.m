//
//  WGHomeViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/10.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WGHomeViewController.h"
#import "PchHeader.h"
#import "MyCollectionViewCell.h"
#import "SYCell.h"
#import "WgRyTableViewCell.h"
#import "KaoQViewController.h"
#import "SJchuLiViewController.h"
#import "GZdataViewController.h"
#import "QingJiaViewController.h"
#import "WgModel.h"
#import "WGLoginViewController.h"
#import "TotalViewController.h"
@interface WGHomeViewController ()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>{

    UITableView *_tableView;
    CGFloat height;
       NSString *strcookie;
    NSMutableArray *ModelArray;
    NSUserDefaults *userDefaults;
    
    }
@property(nonatomic,strong)NSMutableArray  *dingdArray;
@property (strong, nonatomic) UIWebView *Webhome;
@end

@implementation WGHomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"网格管理";
    UIButton *releaseButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 50, 30)];
//    releaseButton.backgroundColor=[UIColor redColor];
    [releaseButton setTitle:@"注销" forState:normal];
    [releaseButton addTarget:self action:@selector(releaseInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
     userDefaults= [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
   [SVProgressHUD showWithStatus:@"加载中"];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/staff/getAllGridStaffById.do?pageSize=5&pageCurrent=1&field=&Cookie=%@",strcookie];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        ModelArray=[WgModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] objectForKey:@"list"]];
        
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        //[SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

    _Webhome = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    _Webhome.delegate=self;
     _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    _Webhome.scrollView.scrollEnabled = NO;
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/info/getOneAreaIntrInfo.do?Cookie=%@",strcookie];
    [_Webhome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    NSLog(@"%@",urlString);

   [self initTableView];

}
-(void)btnCkmore
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[TotalViewController class]]) {
            TotalViewController *A =(TotalViewController *)controller;
            [self.navigationController popToViewController:A animated:YES];
        }
    }
}
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WgRyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"wgcell"];
    
    [self.view addSubview:_tableView];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
      UIView *viewhj=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
        viewhj.backgroundColor=[UIColor whiteColor];
        UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, viewhj.frame.size.height-35, Screen_Width, 5)];
        viewxian.backgroundColor=RGBColor(224, 224, 224);
        [viewhj addSubview:viewxian];
   NSArray *ClassArray = @[@"考勤打卡",@"请假申请",@"事件处理",@"工作日志"];
   NSArray *classImageArray=@[@"wg02.png",@"wg03.png",@"wg02.png",@"wg01.png"];
    for (int i=0; i<ClassArray.count; i++) {
        NSInteger page = i/1;
        UIButton *butanniu=[[UIButton alloc]init];
        [butanniu setTitle:[NSString stringWithFormat:@"%@",ClassArray[i]] forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:classImageArray[i]];
        [butanniu setImage:image forState:UIControlStateNormal];
        butanniu.titleEdgeInsets = UIEdgeInsetsMake(65.0, -image.size.width, 0.0, 0.0);
        butanniu.imageEdgeInsets = UIEdgeInsetsMake(10.0, 17,20,17);
        butanniu.frame= CGRectMake(page*(Screen_Width/4),0, Screen_Width/4, viewhj.frame.size.height-45);
        butanniu.tag = i+1;

        [butanniu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        butanniu.font=[UIFont systemFontOfSize:13.0f];
        [butanniu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        labfeil.textAlignment = UITextAlignmentCenter;
        [viewhj addSubview:butanniu];
    }
    UILabel *labtou=[[UILabel alloc]initWithFrame:CGRectMake(15,viewhj.frame.size.height-20, Screen_Width/3, 20)];
    labtou.text=@"辖区介绍";
    labtou.font=[UIFont systemFontOfSize:14.0f];
        labtou.textColor=[UIColor orangeColor];
    [viewhj addSubview:labtou];
        return viewhj;
    
    }else{
        UIView *viewx2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        
        viewx2.backgroundColor=[UIColor whiteColor];
        UILabel *labtou2=[[UILabel alloc]initWithFrame:CGRectMake(15,viewx2.frame.size.height-20, Screen_Width/3, 20)];
        labtou2.text=@"网格人员信息";
        labtou2.font=[UIFont systemFontOfSize:14.0f];
        labtou2.textColor=[UIColor orangeColor];
        [viewx2 addSubview:labtou2];
        return viewx2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 120;
    }else{
        return 30;
    }
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
          return 1;
    }
    else
    {
        return ModelArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        /* 通过webview代理获取到内容高度后,将内容高度设置为cell的高 */
        return height;
    }else if(indexPath.section==1){
        return 58;
    }else{
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"awgcell"];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0){

        [cell.contentView addSubview:_Webhome];
        return cell;
    }
    else if(indexPath.section==1){
    
        WgRyTableViewCell *cellwg = [tableView dequeueReusableCellWithIdentifier:@"wgcell"];
        cellwg.WgM=ModelArray[indexPath.row];
        return cellwg;
        
    }else{
        return nil;}
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DdxiangqingViewController *Ddxiangqing = [[DdxiangqingViewController alloc] init];
//    AllModel *ALL=_dingdArray[indexPath.row];
//    Ddxiangqing.id=ALL.id;
//    Ddxiangqing.uid=self.uid;
//    Ddxiangqing.code=self.code;
//    [self.navigationController pushViewController:Ddxiangqing animated:YES];
}
#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
  CGFloat  jj= [[_Webhome stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    height=_Webhome.scrollView.contentSize.height;
    _Webhome.frame = CGRectMake(0,0, Screen_Width, height);
     _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [_tableView reloadData];
}
- (void)buttonClick:(UIButton *)buttonClick{

    if (buttonClick.tag == 1) {
    
        KaoQViewController *KaoQV=[[KaoQViewController alloc] init];
        [self.navigationController pushViewController:KaoQV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }else  if (buttonClick.tag == 2) {
        
        QingJiaViewController *QingJiaV=[[QingJiaViewController alloc] init];
        [self.navigationController pushViewController:QingJiaV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else  if (buttonClick.tag == 3) {
        
        SJchuLiViewController *SJchuLiV=[[SJchuLiViewController alloc] init];
        [self.navigationController pushViewController:SJchuLiV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else  if (buttonClick.tag == 4) {
        
        GZdataViewController *GZdataV=[[GZdataViewController alloc] init];
        [self.navigationController pushViewController:GZdataV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }


}
-(void)releaseInfo{
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/user/loginOut.do?Cookie=%@",strcookie];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
         [userDefaults removeObjectForKey:Cookie];
        userDefaults= [NSUserDefaults standardUserDefaults];
        strcookie=[userDefaults objectForKey:Cookie];
        NSLog(@"%@",strcookie);
        [self btnCkmore];
        
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];


}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
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
