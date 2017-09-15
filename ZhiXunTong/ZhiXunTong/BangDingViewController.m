//
//  BangDingViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/21.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BangDingViewController.h"
#import "PchHeader.h"
#import "XiaoQuModele.h"
@interface BangDingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_saveArray;
    NSMutableDictionary *userinfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *ddid;
    NSString *ddxqid;
    
    NSString *xiaoqu;
    NSString *xiaoquId;
    UIButton *_btnLogin;
}
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *zhongTableView;
@property (nonatomic,strong) UITableView *rightTableView;

@property (nonatomic,strong) NSMutableArray *arrayDiyi;
@property (nonatomic,strong) NSMutableArray *arrayDiyi1;
@property (nonatomic,strong) NSMutableArray *arrayDiyi2;

@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@end

@implementation BangDingViewController

-(void)postLeft
{
    [[WebClient sharedClient] BiDepd:ddid Keys:ddkey TVinfo:ddtvinfo ResponseBlock:^(id resultObject, NSError *error) {
        _arrayDiyi=[[NSMutableArray alloc]initWithArray:[XiaoQuModele mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSLog(@"111111resultObject=%@",resultObject);
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1) {
           // [self.view addSubview:self.leftTableView];
            [_leftTableView reloadData];
             [SVProgressHUD showSuccessWithStatus:@"请选择"];
        }else{
            NSLog(@"没有数据");
            [_leftTableView reloadData];
            [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
        
        
    }];
}
-(void)postZhong:(NSString *)axqid
{
    [[WebClient sharedClient] BiDepd:ddid Keys:ddkey TVinfo:ddtvinfo Xqid:axqid ResponseBlock:^(id resultObject, NSError *error) {
        _arrayDiyi1=[[NSMutableArray alloc]initWithArray:[XiaoQuModele mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSLog(@"222222resultObject=%@",resultObject);
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1) {
           // [self.view addSubview:self.zhongTableView];
            [SVProgressHUD showSuccessWithStatus:@"请选择"];
            [_zhongTableView reloadData];
        }else{
            NSLog(@"没有数据:%@",[resultObject objectForKey:@"Message"]);
            [_zhongTableView reloadData];
             [SVProgressHUD showErrorWithStatus:@"没有数据"];
        }
       
    }];
}
-(void)postRight:(NSString *)infod
{
    [[WebClient sharedClient] BiDepd:ddid Keys:ddkey TVinfo:ddtvinfo Xqid:ddxqid Infoid:infod ResponseBlock:^(id resultObject, NSError *error) {
        _arrayDiyi2=[[NSMutableArray alloc]initWithArray:[XiaoQuModele mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSLog(@"3333333resultObject=%@",resultObject);
       // [self.view addSubview:self.rightTableView];
        
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1) {
            [SVProgressHUD showSuccessWithStatus:@"请选择"];
            [_rightTableView reloadData];
        }
        else
        {
            NSLog(@"没有数据:%@",[resultObject objectForKey:@"Message"]);
             [SVProgressHUD showErrorWithStatus:@"没有数据"];
             [_rightTableView reloadData];
        }
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];//绑定小区
    [self daohangView];
    [self btnLaike];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    ddkey=[userinfo objectForKey:@"Key"];
    ddtvinfo=[userinfo objectForKey:@"TVInfoId"];
    ddid=[[arry objectAtIndex:0] objectForKey:@"id"];
    [self postLeft];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.zhongTableView];
    [self.view addSubview:self.rightTableView];
}
-(void)btnLaike
{
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    img.backgroundColor=[UIColor grayColor];
    img.userInteractionEnabled=YES;
    _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLogin.frame = CGRectMake(Screen_Width-70, 2, 50, 40);
    [_btnLogin setTitle:@"确定" forState:UIControlStateNormal];
    _btnLogin.userInteractionEnabled=NO;
    _btnLogin.tag=200;
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnLogin.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btnLogin addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:_btnLogin];
    [self.view addSubview:img];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 0, Screen_Width/4, 40);
    [_btn2 setTitle:@"请选择" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn.tag=100;
    _btn.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(Screen_Width/4, 0, Screen_Width/4, 40);
    [_btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn1.tag=100+1;
    _btn1.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame = CGRectMake(Screen_Width/4*2, 0, Screen_Width/4, 40);
    [_btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn2.tag=100+2;
    _btn2.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
}
-(void)BtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            [btn setTitle:@"请选择" forState:UIControlStateNormal];
            [_btn1 setTitle:@"" forState:UIControlStateNormal];
            [_btn2 setTitle:@"" forState:UIControlStateNormal];
            _btnLogin.userInteractionEnabled=NO;
            self.leftTableView.frame=CGRectMake(0, 44, Screen_Width, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
            
            self.rightTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
        }
            break;
        case 101:
        {
            [_btn1 setTitle:@"请选择" forState:UIControlStateNormal];
            [_btn2 setTitle:@"" forState:UIControlStateNormal];
            _btnLogin.userInteractionEnabled=NO;
            self.leftTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(0, 44, Screen_Width, Screen_height-104);
            
            self.rightTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
        }
            break;
        case 102:
        {
            [_btn2 setTitle:@"请选择" forState:UIControlStateNormal];
            _btnLogin.userInteractionEnabled=NO;
            self.leftTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(0, 44, 0, Screen_height-104);
            self.rightTableView.frame=CGRectMake(0, 44, Screen_Width, Screen_height-104);
        }
            break;
        case 200:
        {
            //[self getaf:strlongin];
            NSLog(@"确定");
            xiaoqu=[NSString stringWithFormat:@"%@ %@ %@",_btn.titleLabel.text,_btn1.titleLabel.text,_btn2.titleLabel.text];
            NSLog(@"xiaoqu:--%@",xiaoqu);
            if (self.frstBlock) {
                //self.frstBlock(xiaoqu);
                self.frstBlock(xiaoqu, xiaoquId);
            }
           [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        default:
            break;
    }
}
//-(void)testANewBlock:(Myblock)block{
//    
//    block(@"测试");
//}
-(void)daohangView
{
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"绑定小区";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 4, 36, 36)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView)
    {
        return _arrayDiyi.count;
    }
    else if (tableView== _zhongTableView)
    {
        return _arrayDiyi1.count;
    }
    else if (tableView== _rightTableView)
    {
        return _arrayDiyi2.count;
    }
    else
    {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.leftTableView) {
        
        XiaoQuModele *model = [_arrayDiyi objectAtIndex:indexPath.row];
        NSLog(@"%@",model.qu_name);
        cell.textLabel.text = model.qu_name;
    }
    else if (tableView==self.zhongTableView)
    {
        XiaoQuModele *model = [_arrayDiyi1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.buildName;
    }
    else {
        XiaoQuModele *model = [_arrayDiyi2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.number;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView)
    {
        XiaoQuModele *model = [_arrayDiyi objectAtIndex:indexPath.row];
        [_btn setTitle:model.qu_name forState:UIControlStateNormal];
        [self postZhong:model.id];
        xiaoqu=[NSString stringWithFormat:@"%@",model.qu_name];
        self.leftTableView.frame=CGRectMake(0, 0, 0, 0);
        self.zhongTableView.frame=CGRectMake(0, 44, Screen_Width, Screen_height-104);
    }
    else if (tableView==self.zhongTableView)
    {
        ddxqid=@"";
        XiaoQuModele *model = [_arrayDiyi1 objectAtIndex:indexPath.row];
        [_btn1 setTitle:model.buildName forState:UIControlStateNormal];
        ddxqid=model.id;
        [self postRight:model.id];
      //  xiaoqu = [xiaoqu stringByAppendingFormat:@"%@",model.buildName];
        
        self.zhongTableView.frame=CGRectMake(0, 0, 0, Screen_height-104);
        self.rightTableView.frame=CGRectMake(0, 44, Screen_Width, Screen_height-104);
    }
    else if(tableView==self.rightTableView)
    {
        xiaoquId=@"";
        _btnLogin.userInteractionEnabled=YES;
        [SVProgressHUD showSuccessWithStatus:@"请点击确定按钮"];
        XiaoQuModele *model = [_arrayDiyi2 objectAtIndex:indexPath.row];
        [_btn2 setTitle:model.number forState:UIControlStateNormal];
        
        xiaoquId=model.id;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark - getter
- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,44, Screen_Width, Screen_height-108) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor grayColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        [_leftTableView setTableFooterView:[UIView new]];
    }
    return _leftTableView;
}
- (UITableView *)zhongTableView{
    if (!_zhongTableView) {
        _zhongTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,104, 0, Screen_height-104) style:UITableViewStylePlain];
        _zhongTableView.backgroundColor = [UIColor whiteColor];
        _zhongTableView.dataSource = self;
        _zhongTableView.delegate = self;
        [_zhongTableView setTableFooterView:[UIView new]];
    }
    return _zhongTableView;
}
- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, 0, Screen_height-104) style:UITableViewStylePlain];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        [_rightTableView setTableFooterView:[UIView new]];
    }
    return _rightTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
