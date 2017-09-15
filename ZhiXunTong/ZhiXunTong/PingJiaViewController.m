//
//  PingJiaViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/11.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PingJiaViewController.h"
#import "PchHeader.h"
@interface PingJiaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *newId;//push 过来的id
    NSString *qufen;
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
    NSMutableArray *array;
}

@end

@implementation PingJiaViewController
-(id)initWithId:(NSString *)Bid Auid:(NSString *)austr
{
    if (self=[super init]){
        newId=Bid;
        qufen=austr;
    }
    return self;
}
- (void)viewDidLoad {
    //事项评价
    [super viewDidLoad];
    NSLog(@"newId:%@",newId);
    [self initView];//加载导航栏
    [self initTableView];//加载表格
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    aatvinfo=[userDefaults objectForKey:TVInfoId];
    aakey=[userDefaults objectForKey:Key];
    aadeid=[userDefaults objectForKey:DeptId];
    [[WebClient sharedClient] XQgongshi:aatvinfo Keys:aakey AId:newId ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        tou=[NSString stringWithFormat:@"受理编号：%@\n分类性质：%@\n诉求时间：%@\n办结时间：%@\n办结状态：%@",newId,[resultObject objectForKey:@"OpinionClassName"],[resultObject objectForKey:@"EditDate"],
             [resultObject objectForKey:@"ReDate"],
             [resultObject objectForKey:@"AuditName"]];
        suqiu=[resultObject objectForKey:@"Content"];
        huifu=[resultObject objectForKey:@"ReContent"];
        array=[resultObject objectForKey:@"Data"];
        NSLog(@"array=%@",array);
        wuye=[resultObject objectForKey:@"deptName"];
        NSMutableDictionary *dic=[array objectAtIndex:0];
       // if ([qufen containsString:@"已办结"]) {
            if (array.count>1) {
                NSMutableDictionary *dic1=[array objectAtIndex:1];
                banli=[NSString stringWithFormat:@"%@%@\n%@%@",
                       [dic objectForKey:@"EditDate"],[dic objectForKey:@"ReContent"],[dic1 objectForKey:@"EditDate"],[dic1 objectForKey:@"ReContent"]];
                NSLog(@"banli:%@",banli);
                [WuTableView reloadData];
            }else{
                banli=[NSString stringWithFormat:@"%@%@",
                       [dic objectForKey:@"EditDate"],[dic objectForKey:@"ReContent"]];
                NSLog(@"banli:%@",banli);
                [WuTableView reloadData];
            }
            
//        }
//        else if([qufen containsString:@"已受理"]){
//            banli=[NSString stringWithFormat:@"%@%@",
//                   [dic objectForKey:@"EditDate"],[dic objectForKey:@"ReContent"]];
//             [WuTableView reloadData];
//        }
        
        NSLog(@"%@",tou);
    }];
}
-(void)initView
{
    self.navigationItem.title=@"事项评价";
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
        if (array.count>1) {
            return 50;
        }else
        {
            return 30;
        }
        
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
