//
//  AddressViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddressViewController.h"
#import "PchHeader.h"
#import "diyi.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *saveArry;
    NSString *strlongin;
    NSString *strTitle;
    UIButton *_btnLogin ;
}
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *zhongTableView;
@property (nonatomic,strong) UITableView *zhongErTableView;
@property (nonatomic,strong) UITableView *rightTableView;


@property (nonatomic,strong) NSMutableArray *arrayDiyi;
@property (nonatomic,strong) NSMutableArray *arrayDiyi1;
@property (nonatomic,strong) NSMutableArray *arrayDiyi2;
@property (nonatomic,strong) NSMutableArray *arrayDiyi3;

@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong)diyi *selectModel;

@end

@implementation AddressViewController
-(void)afGetAFNDeptid:(NSString *) deptid level:(NSString *)lev andTableView:(UITableView *) tableview
{
    // 1 封装会话管理者
    [SVProgressHUD showWithStatus:@"加载中"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?&deptid=%@&level=%@&method=dept",URL,deptid,lev];
    NSLog(@"dict====%@",dict);
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                 //NSLog(@"下载的进度");
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        // NSLog(@"请求成功:%@", string);
         NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
         
         if (tableview == self.leftTableView) {
             _arrayDiyi = [[NSMutableArray alloc] initWithArray:[diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
             if (_arrayDiyi.count>0) {
                 [SVProgressHUD showSuccessWithStatus:@"请选择区域"];
             }else
             {
                 [SVProgressHUD showSuccessWithStatus:@"网络太差了"];
             }
             
         }else if (tableview == self.zhongTableView){
             _arrayDiyi1 = [[NSMutableArray alloc] initWithArray:[diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
             if (_arrayDiyi1.count>0) {
                 [SVProgressHUD showSuccessWithStatus:@"请选择下一级"];
             }else
             {
                 [SVProgressHUD showSuccessWithStatus:@"该地区暂无数据"];
             }
             
         }else if (tableview == self.zhongErTableView){
             _arrayDiyi2 = [[NSMutableArray alloc] initWithArray:[diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
             if (_arrayDiyi2.count>0) {
                 [SVProgressHUD showSuccessWithStatus:@"请选择下一级"];
             }else
             {
                 [SVProgressHUD showSuccessWithStatus:@"该地区暂无数据"];
             }
         }else if (tableview == self.rightTableView){
             _arrayDiyi3 = [[NSMutableArray alloc] initWithArray:[diyi mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
             if (_arrayDiyi3.count>0) {
                 [SVProgressHUD showSuccessWithStatus:@"请选择下一级"];
             }else
             {
                 [SVProgressHUD showSuccessWithStatus:@"该地区暂无数据"];
             }
         }
         [tableview reloadData];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"服务器异常"];
              NSLog(@"请求失败:%@", error);
    }];

}
-(void)getaf:(NSString *)deptid
{
    // 1 封装会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=UserAppLogin&DeptId=%@",URL,deptid];
    NSLog(@"dict====%@",dict);
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"请求成功:%@", responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"请求成功:%@", string);
        NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        NSString *aa=[responseJSON objectForKey:@"Status"];
        int inta=[aa intValue];
        if (inta==1) {
            NSString *aKey=[responseJSON objectForKey:@"Key"];
            NSString *aTVInfoId=[responseJSON objectForKey:@"TVInfoId"];
            NSString *aDeptId=[responseJSON objectForKey:@"DeptId"];
            
            //            //快速创建
            [[NSUserDefaults standardUserDefaults] setObject:aKey forKey:Key];
            [[NSUserDefaults standardUserDefaults] setObject:aTVInfoId forKey:TVInfoId];
            [[NSUserDefaults standardUserDefaults] setObject:aDeptId forKey:DeptId];
            [[NSUserDefaults standardUserDefaults] setObject:strTitle forKey:navtitle];
            [[NSUserDefaults standardUserDefaults] synchronize];
            if (self.addressBlock) {
                self.addressBlock(@"123");
            }
             [SVProgressHUD showSuccessWithStatus:@"成功登录"];
            [self dismissViewControllerAnimated:NO completion:NULL];
        }
        else if (inta==0)
        {
            NSString *msg=[responseJSON objectForKey:@"Message"];
            NSLog(@"msg%@",msg);
            [SVProgressHUD showErrorWithStatus:msg];
        }        NSLog(@"aa=%@",aa);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self btnLaike];
    [self afGetAFNDeptid:@"" level:@"1" andTableView:self.leftTableView];
    [self.view addSubview:self.zhongTableView];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.view addSubview:self.zhongErTableView];
}
-(void)btnLaike
{
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, 44)];
    img.backgroundColor=[UIColor blueColor];
    img.userInteractionEnabled=YES;
   _btnLogin= [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLogin.userInteractionEnabled=NO;
    _btnLogin.frame = CGRectMake(Screen_Width-70, 2, 50, 40);
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    
    UIButton *fanhui=[UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame=CGRectMake(16, 16, 10, 18);
    fanhui.tag=1005;
    [fanhui setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:fanhui];
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    lable.text=@"小区选择";
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [img addSubview:lable];
    
    _btnLogin.tag=200;
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnLogin.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btnLogin addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:_btnLogin];
    [self.view addSubview:img];
    
    UIView *beijing=[[UIView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, 40)];
    beijing.backgroundColor=RGBColor(236, 236, 236);
    [self.view addSubview:beijing];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 64, Screen_Width/4, 40);
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn.tag=100;
    [_btn setTitle:@"请选择" forState:UIControlStateNormal];
    _btn.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(Screen_Width/4, 64, Screen_Width/4, 40);
    [_btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn1.tag=100+1;
    _btn1.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2.frame = CGRectMake(Screen_Width/4*2, 64, Screen_Width/4, 40);
    [_btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn2.tag=100+2;
    _btn2.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3.frame = CGRectMake(Screen_Width/4*3, 64, Screen_Width/4, 40);
    [_btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn3.tag=100+3;
    _btn3.titleLabel.font=[UIFont systemFontOfSize:17];
    [_btn3 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn3];
 
}
-(void)BtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            [btn setTitle:@"请选择" forState:UIControlStateNormal];
            [_btn1 setTitle:@"" forState:UIControlStateNormal];
            [_btn2 setTitle:@"" forState:UIControlStateNormal];
            [_btn3 setTitle:@"" forState:UIControlStateNormal];
            self.leftTableView.frame=CGRectMake(0, 104, 100, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
            self.zhongErTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
            self.rightTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
        }
            break;
        case 101:
        {
            [_btn1 setTitle:@"请选择" forState:UIControlStateNormal];
            [_btn2 setTitle:@"" forState:UIControlStateNormal];
            [_btn3 setTitle:@"" forState:UIControlStateNormal];
            self.leftTableView.frame=CGRectMake(0, 104, 100, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(100, 104, 100, Screen_height-104);
            self.zhongErTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
            self.rightTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
        }
            break;
        case 102:
        {
            [_btn2 setTitle:@"请选择" forState:UIControlStateNormal];
            [_btn3 setTitle:@"" forState:UIControlStateNormal];
            self.leftTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
            self.zhongTableView.frame=CGRectMake(0, 104, 100, Screen_height-104);
            self.zhongErTableView.frame=CGRectMake(100, 104, 100, Screen_height-104);
            self.rightTableView.frame=CGRectMake(0, 104, 0, Screen_height-104);
        }
            break;
        case 103:
        {
            [btn setTitle:@"请选择" forState:UIControlStateNormal];
            
        }
            break;
        case 200:
        {
            [self getaf:strlongin];
            NSLog(@"去登录");
            
        }
            break;
            case 1005:
             [self dismissViewControllerAnimated:NO completion:NULL];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    else if (tableView== _zhongErTableView)
    {
        return _arrayDiyi2.count;
    }
    else
    {
        return _arrayDiyi3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.leftTableView) {
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        selectedBackgroundView.backgroundColor = [UIColor blueColor];
        cell.selectedBackgroundView = selectedBackgroundView;
        
        diyi *model = [_arrayDiyi objectAtIndex:indexPath.row];
        cell.textLabel.text = model.Deptname;
    }
    else if (tableView==self.zhongTableView)
    {
        diyi *model = [_arrayDiyi1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.Deptname;
    }
    else if (tableView==self.zhongErTableView)
    {
        diyi *model = [_arrayDiyi2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.Deptname;
    }
    else {
        diyi *model = [_arrayDiyi3 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.Deptname;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView)
    {
        diyi *model = [_arrayDiyi objectAtIndex:indexPath.row];
        if (_btn.tag==100) {
            [_btn setTitle:model.Deptname forState:UIControlStateNormal];
        }
        [self afGetAFNDeptid:model.Deptid level:@"1" andTableView:self.zhongTableView];
        self.zhongTableView.frame=CGRectMake(100, 104, 100, Screen_Width-104);
    }
    else if (tableView==self.zhongTableView)
    {
        diyi *model = [_arrayDiyi1 objectAtIndex:indexPath.row];
        [_btn1 setTitle:model.Deptname forState:UIControlStateNormal];
        [self afGetAFNDeptid:model.Deptid level:@"1" andTableView:self.zhongErTableView];
        self.leftTableView.frame=CGRectMake(0, 0, 0, 0);
        self.zhongTableView.frame=CGRectMake(0, 104, 100, Screen_height-104);
        self.zhongErTableView.frame=CGRectMake(100, 104, Screen_Width-100, Screen_height-104);
    }
    else if (tableView==self.zhongErTableView)
    {
        diyi *model = [_arrayDiyi2 objectAtIndex:indexPath.row];
        [_btn2 setTitle:model.Deptname forState:UIControlStateNormal];
        [self afGetAFNDeptid:model.Deptid level:@"3" andTableView:self.rightTableView];
        self.zhongTableView.frame=CGRectMake(0, 0, 0, 0);
        self.zhongErTableView.frame=CGRectMake(0, 104, 100, Screen_height-104);
        self.rightTableView.frame=CGRectMake(100, 104, Screen_Width, Screen_height-104);
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"请登录"];
        _btnLogin.userInteractionEnabled=YES;
        strlongin=@"";
        diyi *model = [_arrayDiyi3 objectAtIndex:indexPath.row];
        [_btn3 setTitle:model.Deptname forState:UIControlStateNormal];
        NSLog(@"model=%@",model.Deptid);
        
        strTitle=model.Deptname;
        strlongin=model.Deptid;
        _selectModel = model;
        //[self dismissModalViewControllerAnimated:YES];
    }
}
#pragma mark - getter
- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,104, 100, Screen_height-104) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        [_leftTableView setTableFooterView:[UIView new]];
    }
    return _leftTableView;
}
- (UITableView *)zhongTableView{
    if (!_zhongTableView) {
        _zhongTableView = [[UITableView alloc]initWithFrame:CGRectMake(100,104, Screen_Width-100, Screen_height-104) style:UITableViewStylePlain];
        _zhongTableView.backgroundColor = [UIColor whiteColor];
        _zhongTableView.dataSource = self;
        _zhongTableView.delegate = self;
        [_zhongTableView setTableFooterView:[UIView new]];
    }
    return _zhongTableView;
}
- (UITableView *)zhongErTableView{
    if (!_zhongErTableView) {
        _zhongErTableView = [[UITableView alloc]initWithFrame:CGRectMake(200,104, Screen_Width-100, Screen_height-104) style:UITableViewStylePlain];
        _zhongErTableView.backgroundColor = [UIColor whiteColor];
        _zhongErTableView.dataSource = self;
        _zhongErTableView.delegate = self;
        [_zhongErTableView setTableFooterView:[UIView new]];
    }
    return _zhongErTableView;
}
- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(300, 104, Screen_Width-100, Screen_height-104) style:UITableViewStylePlain];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        [_rightTableView setTableFooterView:[UIView new]];
    }
    return _rightTableView;
}

@end
