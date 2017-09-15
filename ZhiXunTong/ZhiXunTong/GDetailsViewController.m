//
//  GDetailsViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GDetailsViewController.h"
#import "PchHeader.h"
#import "SYCell.h"
#import "GDTableViewCell.h"
@interface GDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *nextTableView;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    UIView *MeView;
    
    NSString *title1;
    NSString *title2;
    NSString *title3;
    NSString *title4;
    NSString *title5;
}


@end

@implementation GDetailsViewController
-(id)initGDetaile:(NSString *)cat Serve:(NSString *)serve Procedures:(NSString *)procedures Materials:(NSString *)materials Responsible:(NSString *)Responsible{
    if ((self=[super self])) {
        title1=cat;
        title2=serve;
        title3=procedures;
        title4=materials;
        title5=Responsible;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];//办事指南-----第二级
    [self daohang];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    
    
    CGRect frame = self.view.frame;
    nextTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-64)];
    
    MeView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 44)];
    lable.text=[NSString stringWithFormat:@"%@",title2];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor redColor];
    [MeView addSubview:lable];
    nextTableView.tableHeaderView=MeView;
    nextTableView.delegate=self;
    nextTableView.dataSource=self;
    nextTableView.backgroundColor=[UIColor clearColor];
    [nextTableView setTableFooterView:[UIView new]];
    [self.view addSubview:nextTableView];
}
-(void)nextGet{
    [[WebClient sharedClient] BanShiNext:tvinfoId Keys:key Deptid:deptid ChuanID:@"" ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"next=%@",resultObject);
    }];
}
-(void)daohang
{
    self.navigationItem.title=@"办理证件";
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GDTableViewCell *cell = [self tableView:nextTableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==0) {
        return cell.frame.size.height;;
    }
    else if (indexPath.row==1)
    {
        return cell.frame.size.height;
    }
    else if (indexPath.row==2)
    {
        return cell.frame.size.height;
    }
    else {
        return 44;
    }
    return cell.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    GDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GDTableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    if (indexPath.row==0) {
        
        [cell setIntroductionText:title3];
        cell.name.text = @"办理程序：";
        cell.name.frame=CGRectMake(15, 0, 90, cell.frame.size.height);
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row==1)
    {
        cell.name.text = @"申请材料：";
        [cell setIntroductionText:title4];
        cell.name.frame=CGRectMake(15, 0, 90, cell.frame.size.height);
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row==2)
    {
        cell.name.text = @"责任科室：";
       // [cell setIntroductionText:title5];
        cell.introduction.text=title5;
        cell.introduction.frame=CGRectMake(110, 0, Screen_Width-120, 44);
        cell.name.frame=CGRectMake(15, 0, 90, 44);
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row==3)
    {
        cell.name.text = @"费用：";
        cell.introduction.text=title1;
        cell.introduction.frame=CGRectMake(110, 0, Screen_Width-120, 44);
        cell.name.frame=CGRectMake(15, 0, 90, 44);
        cell.userInteractionEnabled = NO;
        return cell;
    }
    else if (indexPath.row==4)
    {
        cell.name.text = @"电话号码：";
        //[cell setIntroductionText:@"45t49234567845678"];
        cell.name.frame=CGRectMake(15, 0, 90, cell.frame.size.height);
        cell.userInteractionEnabled = NO;
        return cell;
        
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [nextTableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
