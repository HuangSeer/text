//
//  BSLieBiaoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BSLieBiaoViewController.h"
#import "PchHeader.h"
#import "LieBiaoTableViewCell.h"
#import "KSDatePicker.h"
#import "LieBiaoModel.h"
#import "TJbanshiViewController.h"
#import "LoginViewController.h"
@interface BSLieBiaoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    UIView *meView;
    
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    NSString *myid;
    NSString *DateTime;
     NSString *count;
}

@end

@implementation BSLieBiaoViewController
-(id)initWithXZQ:(NSString *)xuanze{
    if (self=[super init]){
        myid=xuanze;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    [self daohang];
    meView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    //meView.backgroundColor=[UIColor redColor];
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, Screen_Width-200, 44)];
    labTitle.text=@"获取当前时间";
    [meView addSubview:labTitle];
    UIImageView *BtnImg=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-35, 10, 25, 25)];
    BtnImg.image=[UIImage imageNamed:@"001.png"];
    BtnImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapRecognizerWeibo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgtime)];
    [BtnImg addGestureRecognizer:tapRecognizerWeibo];
    [meView addSubview:BtnImg];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView=meView;
    [self.view addSubview:_tableView];
    [_tableView setTableFooterView:[UIView new]];
}
#pragma 图片点击事件
-(void)headImgtime
{
    NSLog(@"搞起");
    //x,y 值无效，默认是居中的
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
    
    //配置中心，详情见KSDatePikcerApperance
    picker.appearance.radius = 5;
    //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
//            NSLog(@"%@",formatter);
            //NSDate *date = [NSDate date];
            DateTime = [formatter stringFromDate:currentDate];
            NSLog(@"%@",DateTime);
            
            [[WebClient sharedClient] XuanZeQi:tvinfoId Keys:key Deptid:deptid Time:DateTime NewId:myid ResponseBlock:^(id resultObject, NSError *error) {
                _saveArray=[[NSMutableArray alloc]initWithArray:[LieBiaoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
                NSLog(@"resultObject=%@",_saveArray);
//                count=[NSString stringWithFormat:@"%@",[[resultObject objectForKey:@"Data"] valueForKey:@"count"]] ;
                if (_saveArray.count>0) {
                    [_tableView reloadData];
                }
                else {
                    [_tableView reloadData];
                    [SVProgressHUD showErrorWithStatus:@"没有数据"];
                }
                NSLog(@"_saveDataArray==%@",_saveArray);
                
                NSLog(@"%@",resultObject);
            }];
        }
    };
    // 显示
    [picker show];
}
-(void)daohang
{
    self.navigationItem.title=@"办事列表";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LieBiaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"LieBiaoTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    LieBiaoModel *mode=[_saveArray objectAtIndex:indexPath.row];
    if (([mode.count isEqual:@"0"])) {
        cell.lable_yuyue.text=@"不可预约";
    }else{
        cell.lable_yuyue.text=@"可预约";
        cell.lable_yuyue.textColor=[UIColor redColor];
    }
    cell.lable_kaishi.text=mode.start_time;
    cell.lable_eid.text=mode.End_time;
    cell.lable_cont.text=[NSString stringWithFormat:@"可预约人数%@人",mode.count];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      LieBiaoModel *mode=[_saveArray objectAtIndex:indexPath.row];
    count=mode.count;
    NSLog(@"countcount==%@",count);
    if ([count containsString:@"0"]) {
        [SVProgressHUD showErrorWithStatus:@"这个时间段预约已经满了"];
    }else{
    
  
    NSLog(@"id=%@",mode.id);
    NSString *bb=[NSString stringWithFormat:@"%@",mode.id];
    NSString *aa=[NSString stringWithFormat:@"%@-%@",mode.start_time,mode.End_time];
    NSLog(@"%@",DateTime);
//    LoginViewController *lg=[[LoginViewController alloc] init];
//    [self.navigationController pushViewController:lg animated:NO];
    TJbanshiViewController *tj=[[TJbanshiViewController alloc] init];
    tj.edate=_strtitle;
    tj.hanid=bb;
    tj.perid=aa;
    tj.timess=DateTime;
    [self.navigationController pushViewController:tj animated:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
