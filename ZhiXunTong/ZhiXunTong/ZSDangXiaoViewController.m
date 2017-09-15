//
//  ZSDangXiaoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ZSDangXiaoViewController.h"
#import "PchHeader.h"
#import "DangXiaoMode.h"
#import "webViewController.h"
@interface ZSDangXiaoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_TableView;
    NSMutableArray *_saveArray;
    NSString *stri;
}

@end

@implementation ZSDangXiaoViewController

-(id)initWithZS:(NSMutableArray *)webUrls Title:(NSString *)title{
    if (self=[super init]){
        _saveArray=webUrls;
        stri=title;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _TableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _TableView.delegate=self;
    _TableView.dataSource=self;
    _TableView.backgroundColor=[UIColor clearColor];
    [_TableView setTableFooterView:[UIView new]];
    [self.view addSubview:_TableView];
    [self daohang];
}
-(void)daohang
{
    self.navigationItem.title=stri;
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 4, 36, 36)];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveArray.count;
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
    DangXiaoMode *model=[_saveArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",model.title];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DangXiaoMode *model=[_saveArray objectAtIndex:indexPath.row];
    NSString *weburl=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=school&id=%@",URL,model.id];
    NSLog(@"weburl=%@",weburl);
    NSString *aa=stri;
    // NSString *aa=[NSString stringWithFormat:@"%@",mode.Title];
    webViewController *web=[[webViewController alloc] initWithCoderZW:weburl Title:aa];
    [self.navigationController pushViewController:web animated:NO];
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
