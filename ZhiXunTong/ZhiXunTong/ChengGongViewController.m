//
//  ChengGongViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ChengGongViewController.h"
#import "PchHeader.h"
@interface ChengGongViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSString *bank_type;//支付方式
    NSString *total_fee;//支付金额
    NSString *time_end;//交易时间
    NSString *transaction_id;//交易单号
    NSString *returnMsg;
}

@end

@implementation ChengGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"交易详情";
    [self shitu];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}
-(void)shitu{
    if ([_CGid containsString:@"支付宝"]) {
        bank_type=@"支付宝支付";
        total_fee=[_aliArray valueForKey:@"total_amount"];
        time_end=[_aliArray valueForKey:@"send_pay_date"];
        transaction_id=[_aliArray valueForKey:@"trade_no"];
        returnMsg=@"已支付";
    }else{
        NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/wxPayOrderQuery.htm?id=%@",DsURL,_CGid];
        NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:hString success:^(id data) {
            NSLog(@"成功数据%@",data);
            bank_type=@"微信支付";
            total_fee=[data objectForKey:@"total_fee"];
            time_end=[data objectForKey:@"time_end"];
            transaction_id=[data objectForKey:@"transaction_id"];
            returnMsg=[data objectForKey:@"returnMsg"];
            [_tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"回掉%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!"];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }else if(indexPath.row==1){
        return 100;
    }else if (indexPath.row==7){
        return 60;
    }
    return 30;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (indexPath.row==0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, Screen_Width, 60);
        button.backgroundColor = [UIColor clearColor];
        //设置button正常状态下的图片
        [button setImage:[UIImage imageNamed:@"unchecked_checkbox@2x"] forState:UIControlStateNormal];
        button.tag=800;
        //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
        button.imageEdgeInsets = UIEdgeInsetsMake(10, 50, 10, 60);
        [button setTitle:@"支付成功" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置button正常状态下的标题颜色
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor=RGBColor(240, 240, 240);
        [cell.contentView addSubview:button];
    }else if (indexPath.row==1){
        UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, Screen_Width, 30)];
        labTitle.text=@"指讯通";
        labTitle.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:labTitle];
        
        UILabel *labPirce=[[UILabel alloc] initWithFrame:CGRectMake(0, 50, Screen_Width, 30)];
        labPirce.text=[NSString stringWithFormat:@"￥%@",total_fee];
        labPirce.font=[UIFont systemFontOfSize:21];
        labPirce.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:labPirce];
        UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(0, 99.5, Screen_Width, 0.5)];
        aaView.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:aaView];
    }
    else if (indexPath.row==2){
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
        lable.text=@"商城交易";
        lable.font=[UIFont systemFontOfSize:17];
        lable.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:lable];
    }
    else if (indexPath.row==3){
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 60, 30)];
        lable.text=@"交易单号";
        lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable];
        
        UILabel *_lable=[[UILabel alloc] initWithFrame:CGRectMake(70, 0,Screen_Width-75, 30)];
        _lable.text=[NSString stringWithFormat:@"%@",transaction_id];
        _lable.textAlignment=NSTextAlignmentRight;
        _lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_lable];
    }
    else if (indexPath.row==4){
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 60, 30)];
        lable.text=@"交易时间";
        lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable];
        
        UILabel *_lable=[[UILabel alloc] initWithFrame:CGRectMake(70, 0,Screen_Width-75, 30)];
        _lable.text=[NSString stringWithFormat:@"%@",time_end];
        _lable.textAlignment=NSTextAlignmentRight;
        _lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_lable];
    }else if (indexPath.row==5){
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 60, 30)];
        lable.text=@"当前状态";
        lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable];
        
        UILabel *_lable=[[UILabel alloc] initWithFrame:CGRectMake(70, 0,Screen_Width-75, 30)];
        _lable.text=[NSString stringWithFormat:@"%@",returnMsg];
        _lable.textAlignment=NSTextAlignmentRight;
        _lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_lable];
    }
    else if (indexPath.row==6){
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 60, 30)];
        lable.text=@"支付方式";
        lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable];
        
        UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(0, 29.5, Screen_Width, 0.5)];
        aaView.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:aaView];
        
        UILabel *_lable=[[UILabel alloc] initWithFrame:CGRectMake(70, 0,Screen_Width-75, 30)];
        _lable.text=[NSString stringWithFormat:@"%@",bank_type];
        _lable.textAlignment=NSTextAlignmentRight;
        _lable.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:_lable];
    }
    else{
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake(Screen_Width/2-90, 20, 180, 35);
        denglu.backgroundColor = RGBColor(58, 145, 246);
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"完成" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        denglu.tag=202;
        [denglu addTarget:self action:@selector(cgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)cgBtnClick{
    NSLog(@"完成");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
