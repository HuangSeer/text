//
//  DhJlXqViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DhJlXqViewController.h"
#import "PchHeader.h"
#import "DhJlTableViewCell.h"
#import "JlXqModel.h"
#import "DhXxModel.h"
#import "DhXxTableViewCell.h"
#import "HyXxTableViewCell.h"
#import "PayTableViewCell.h"
#import "ShouHxxTableViewCell.h"
#import "JfXqViewController.h"

@interface DhJlXqViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableViews;
    NSMutableArray *_dataArray; NSMutableArray *_dhxxArray;
}
@property (nonatomic, strong)NSString *igo_pay_time;
@property (nonatomic, strong)NSString *igo_payment;
@property (nonatomic, strong)NSString *igo_trans_fee;
@property (nonatomic, strong)NSString *igo_order_sn;
@property (nonatomic, strong)NSString *igo_total_integral;
@property (nonatomic, strong)NSString *igo_status;
@property (nonatomic, strong)NSString *igo_ship_time;
@property (nonatomic, strong)NSString *igo_pay_msg;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *path;
@property (nonatomic, strong)NSString *trueName;
@property (nonatomic, strong)NSString *area_info;
@property (nonatomic, strong)NSString *addr_area;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *igo_ship_code;
@property (nonatomic, strong)NSString *addTime;
@property (nonatomic, strong)NSString *zip;
@end

@implementation DhJlXqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"兑换记录详情";
     [self initTableView];
    [self lodatejl];
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
}-(void)lodatejl{
    NSString *strurl=[NSString stringWithFormat:@"%@integral_order_detail.htm?id=%@",URLds,_strid];
    
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        _dataArray=[JlXqModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] objectForKey:@"apiIntegralGoods"]];
        _igo_payment=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_payment"]];
         _igo_trans_fee=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_trans_fee"]];
         _igo_pay_time=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_pay_time"]];
         _igo_order_sn=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_order_sn"]];
         _igo_total_integral=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_total_integral"]];
        _igo_status=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_status"]];
        _igo_ship_time=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_ship_time"]];
        _igo_pay_msg=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_pay_msg"]];
        _path=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"path"]];
        NSLog(@"%@==%@===%@",_dhxxArray,_dataArray);
        _userName=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"userName"]];
        _email=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"email"]];
        _trueName=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"address"] objectForKey:@"trueName"]];
        _area_info=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"address"] objectForKey:@"area_info"]];
        _addr_area=[NSString stringWithFormat:@"%@",[[data objectForKey:@"data"] objectForKey:@"addr_area"]];
        _mobile=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"address"] objectForKey:@"mobile"]];
        _igo_ship_code=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"igo_ship_code"]];
    _addTime=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"igo1"] objectForKey:@"addTime"]];
        _zip=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"address"] objectForKey:@"zip"]];
        [tableViews reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
    
}
- (void)initTableView {
    
    tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-20)];
    tableViews.delegate = self;
    tableViews.dataSource = self;
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([DhJlTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([DhXxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"twocell"];
     [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([HyXxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"hycell"];
     [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([PayTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"paycell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([ShouHxxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"shouhcell"];
//    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
//    tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableViews];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-50, 30)];
        lab.text=@"兑换信息";
        lab.font=[UIFont systemFontOfSize:14.0f];
        
        return lab;
    }else if (section==2) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-50, 30)];
        lab.text=@"会员信息";
        lab.font=[UIFont systemFontOfSize:14.0f];
        
        return lab;
    }else if (section==3) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-50, 30)];
        lab.text=@"支付信息";
        lab.font=[UIFont systemFontOfSize:14.0f];
        
        return lab;
    }else if (section==4) {
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, Screen_Width-50, 30)];
        lab.text=@"收货人及发货信息";
        lab.font=[UIFont systemFontOfSize:14.0f];
        
        return lab;
    }else{
    
    
        return nil;
    
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0000000001;
        
    }else{
    return  30;
    }}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

return 0.000000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
         NSLog(@"===%ld",_dataArray.count);
         return _dataArray.count;
       
    }else{
    return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 90;
    }else if (indexPath.section==1)
    {
        return 94;
    }else if (indexPath.section==2)
    {
        return 70;
    }else if (indexPath.section==3)
    {
        return 74;
    }else if (indexPath.section==4)
    {
        return 105;
    }else{
        return 0;
    
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        DhJlTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"cell"];
        cell.JlXqMo=_dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1) {
        DhXxTableViewCell *cell2 = [tableView  dequeueReusableCellWithIdentifier:@"twocell"];
        cell2.labdh.text=[NSString stringWithFormat:@"兑换单号:%@",_igo_order_sn];
        cell2.labjf.text=[NSString stringWithFormat:@"兑换积分:%@",_igo_total_integral];
        cell2.labsj.text=[NSString stringWithFormat:@"兑换时间:%@",_addTime];
        if ([_igo_status containsString:@"-1"]) {
             cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 已取消"];
            
        }else if ([_igo_status containsString:@"0"]){
             cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 待付款"];
            
        }else if ([_igo_status containsString:@"10"]){
            cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 待审核"];
            
        }else if ([_igo_status containsString:@"20"]){
             cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 待发货"];
            
        }else if ([_igo_status containsString:@"30"]){
             cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 已发货"];
            
        }else if ([_igo_status containsString:@"40"]){
            cell2.labzt.text=[NSString stringWithFormat:@"订单状态: 已收货完成"];
            
        }
        

         cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.labyf.text=[NSString stringWithFormat:@"运费:%@",_igo_trans_fee];
        return cell2;
    }else if (indexPath.section==2) {
        HyXxTableViewCell *cell3 = [tableView  dequeueReusableCellWithIdentifier:@"hycell"];
        cell3.labname.text=[NSString stringWithFormat:@"会员名称:%@",_userName];
        cell3.labem.text=[NSString stringWithFormat:@"会员Email:%@",_email];
        cell3.labliuy.text=[NSString stringWithFormat:@"留言:%@",_path];
           cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }else if (indexPath.section==3) {
        PayTableViewCell *cell4 = [tableView  dequeueReusableCellWithIdentifier:@"paycell"];
        if ([_igo_payment containsString:@"alipay"]) {
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 支付宝"];
            
        }else if ([_igo_payment containsString:@"tenpay"]){
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 财付通"];
        }else if ([_igo_payment containsString:@"bill"]){
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 快钱"];
            
        }else if ([_igo_payment containsString:@"chinabank"]){
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 网银在线"];
            
        }
        else if ([_igo_payment containsString:@"outline"]){
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 线下支付"];
            
        }
        else if ([_igo_payment containsString:@"balance"]){
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 预存款支付"];
            
        }
        else if ([_igo_payment containsString:@"no_fee"]){
           cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 无运费订单"];
        } else if (_igo_payment.length==0) {
            cell4.labpay.text=[NSString stringWithFormat:@"支付方式: 未支付"];
            
        }
        cell4.labtime.text=[NSString stringWithFormat:@"支付时间:%@",_igo_ship_time];
        cell4.labzfliuy.text=[NSString stringWithFormat:@"支付留言:%@",_igo_pay_msg];
            cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell4;
    }else if (indexPath.section==4) {
        ShouHxxTableViewCell *cell5 = [tableView  dequeueReusableCellWithIdentifier:@"shouhcell"];
        cell5.labtime.text=[NSString stringWithFormat:@"支付时间:%@",_igo_ship_time];
         cell5.labshr.text=[NSString stringWithFormat:@"收货人:%@",_trueName];
         cell5.labxxdz.text=[NSString stringWithFormat:@"详细地址:%@",_area_info];
        cell5.labaddress.text=[NSString stringWithFormat:@"所在地区:%@",_addr_area];
        cell5.labphone.text=[NSString stringWithFormat:@"联系电话:%@",_mobile];
        cell5.labwldh.text=[NSString stringWithFormat:@"物流单号:%@",_igo_ship_code];
           cell5.labyzbm.text=[NSString stringWithFormat:@"邮政编码:%@",_zip];
        
            cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell5;
    
    } else{
    
        return nil;
    }
  
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JlXqModel *JlXqM=_dataArray[indexPath.row];
    if (indexPath.section==0) {
        JfXqViewController *JfXqVi=[[JfXqViewController alloc] init];
        JfXqVi.intid=JlXqM.goods_id;
        [self.navigationController pushViewController:JfXqVi animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }

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
