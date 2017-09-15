//
//  XQTreatViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/27.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "XQTreatViewController.h"
#import "PchHeader.h"
@interface XQTreatViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *newId;//push 过来的id
    UITableView *WuTableView;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aadeid;
    
    NSString *tou;
    NSString *suqiu;
    NSString *banli;
    NSString *huifu;
    NSString *wuye;
}

@end

@implementation XQTreatViewController
-(id)initWithId:(NSString *)Aid
{
    if (self=[super init]){
        newId=Aid;
    }
    return self;
}
- (void)viewDidLoad {
    //物业处理公示
    [super viewDidLoad];
    NSLog(@"newId:%@",newId);
    [self initView];//加载导航栏
//    [self initTableView];//加载表格
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    
    [[WebClient sharedClient] XQgongshi:aatvinfo Keys:aakey AId:newId ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        tou=[NSString stringWithFormat:@"受理编号：%@\n分类性质：%@\n诉求时间：%@\n办结时间：%@\n办结状态：%@",newId,[resultObject objectForKey:@"OpinionClassName"],[resultObject objectForKey:@"EditDate"],
            [resultObject objectForKey:@"ReDate"],
            [resultObject objectForKey:@"AuditName"]];
        suqiu=[resultObject objectForKey:@"Content"];
        huifu=[resultObject objectForKey:@"ReContent"];
        NSMutableArray *array=[resultObject objectForKey:@"Data"];
        NSMutableDictionary *dic=[array objectAtIndex:0];
        NSMutableDictionary *dic1=[array objectAtIndex:1];
        //NSLog(@"%@",[dic objectForKey:@"deptName"]);
        wuye=[dic objectForKey:@"deptName"];
        banli=[NSString stringWithFormat:@"%@%@\n%@%@",
               [dic objectForKey:@"EditDate"],[dic objectForKey:@"ReContent"],[dic1 objectForKey:@"EditDate"],[dic1 objectForKey:@"ReContent"]];
        [self initTableView];//加载表格
        NSLog(@"%@",tou);
    }];
}
-(void)initView
{
    self.navigationItem.title=@"物业处理公示";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    
}
-(void)initTableView
{
    WuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //WuTableView.rowHeight = 140;
    WuTableView.delegate = self;
    WuTableView.dataSource = self;
    [self.view addSubview:WuTableView];
    WuTableView.showsVerticalScrollIndicator =NO;
    WuTableView.separatorStyle=UITableViewCellEditingStyleNone;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 105;
    }
    else if (indexPath.section==1)
    {
        return 30;
    }
    else if (indexPath.section==2)
    {
        return 50;
    }
    else {
        return 80;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    else if (section==1)
    {
        return @"诉求内容";
    }
    else if (section==2)
    {
        return @"办理跟踪信息";
    }
    else
    {
        return [NSString stringWithFormat:@"回复单位:%@",wuye];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section==0)
    {
        UITextView *atext=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, Screen_Width-20, 85)];
        atext.backgroundColor=[UIColor whiteColor];
        atext.text=tou;
        atext.editable = NO;
        [cell.contentView addSubview:atext];
        cell.backgroundColor=RGBColor(236, 236, 236);;
    }
    else if (indexPath.section==1)
    {
        UITextView *lable=[[UITextView alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-20, 30)];
        lable.text=suqiu;
        lable.editable = NO;
        [cell.contentView addSubview:lable];
    }
    else if (indexPath.section==2)
    {
        UITextView *atext=[[UITextView alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-40, 50)];
        atext.editable = NO;
        atext.text=banli;
        [cell.contentView addSubview:atext];
       // cell.backgroundColor=RGBColor(236, 236, 236);
    }
    else {
        UITextView *lable=[[UITextView alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-20, 80)];
        lable.text=huifu;
        lable.editable = NO;
        lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable];
    }
    //cell.textLabel.text=@"123456";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
