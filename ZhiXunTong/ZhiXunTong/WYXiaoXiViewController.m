//
//  WYXiaoXiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WYXiaoXiViewController.h"
#import "PchHeader.h"
#import "WYXiaoXiTableViewCell.h"
#import "WYXiaoxiModel.h"
#import "webXqViewController.h"
@interface WYXiaoXiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_saveDataArray;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aaPagesize;
    NSString *aapage;
    
    NSMutableArray *idArray;
}

@end

@implementation WYXiaoXiViewController

-(void)viewDidAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangView];
    idArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadeptid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    
    aaPagesize=@"10";
    aapage=@"1";
    NSLog(@"%@-%@-%@",aaid,aadeptid,aatvinfo);
     [self post];
   
}
-(void)daohangView
{
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"物业消息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)intableview
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height)];
    //隐藏表格滚动条
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.rowHeight = 70;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    [_tableView setTableFooterView:[UIView new]];
    //注册
    [_tableView registerNib:[UINib nibWithNibName:@"WYXiaoXiTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)post{
    NSLog(@"%@-----%@---%@---%@--%@",aapage,aakey,aatvinfo,aadeptid,aaid);
    [[WebClient sharedClient] aPagesi:aaPagesize aPage:aapage aKeys:aakey aTVinfo:aatvinfo aDeptd:aadeptid aUserId:aaid ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObject=%@",resultObject);
        _saveDataArray=[[NSMutableArray alloc]initWithArray:[WYXiaoxiModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSLog(@"_saveDataArray=%@",_saveDataArray);
        [self intableview];
    }];
}

#pragma mark - Table view data source
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveDataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYXiaoXiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"WYXiaoXiTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    WYXiaoxiModel *model=_saveDataArray[indexPath.row];
    NSString *string=model.time;
    NSArray *strarray = [string componentsSeparatedByString:@" "];
    NSString *aa=strarray[0];
    NSString *str3 = [aa stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    cell.lable_title.text=model.type;
    cell.lable_time.text=str3;
    cell.lable_neirong.text=model.title;
    //取消选中颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYXiaoxiModel *mode=_saveDataArray[indexPath.row];
    NSString *weburl=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=propertynotice&Tvinfoid=%@&Key=%@&id=%@",URL,aatvinfo,aakey,mode.id];
    webXqViewController *web=[[webXqViewController alloc] initWithCoder:weburl];
    [self.navigationController pushViewController:web animated:NO];
    self.tabBarController.tabBar.hidden=YES;
    NSLog(@"mode%@",mode.id);
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
