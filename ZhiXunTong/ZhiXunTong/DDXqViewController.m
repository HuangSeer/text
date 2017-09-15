//
//  DDXqViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DDXqViewController.h"
#import "PchHeader.h"
#import "SQTuiHuoViewController.h"
#import "DSTuoShuViewController.h"
#import "CancelOrderViewController.h"
#import "JudgeViewController.h"
#import "PayInfoViewController.h"
#import "WuLiuXQViewController.h"
@interface DDXqViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    
    NSString *dda;
    NSString *ddb;
    NSString *ddc;
    UIButton *oneBtn;
    UIButton *twoBtn;
    UIButton *ThreeBtn;
}

@end

@implementation DDXqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"订单详情";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    NSLog(@"%lu",(unsigned long)_DDmodel.gcs.count);
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height-54)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView setTableFooterView:[UIView new]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, Screen_height-104, Screen_Width, 40)];
    view.backgroundColor=RGBColor(234, 234, 234);
    [self.view addSubview:view];
    
    NSString *abc=_DDmodel.order_status;
    int orderStatus=[abc intValue];
    oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    oneBtn.frame = CGRectMake(Screen_Width-90, 7, 80, 26);
    [oneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    oneBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [oneBtn.layer setMasksToBounds:YES];
    [oneBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [oneBtn.layer setBorderWidth:1.0]; //边框宽度
    [oneBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    [view addSubview:oneBtn];
    
    twoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    twoBtn.frame = CGRectMake(Screen_Width-180, 7, 80, 26);
    [twoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    twoBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [twoBtn.layer setMasksToBounds:YES];
    [twoBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [twoBtn.layer setBorderWidth:1.0]; //边框宽度
    [twoBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    [view addSubview:twoBtn];
    
    ThreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ThreeBtn.frame = CGRectMake(Screen_Width-270, 7, 80, 26);
    [ThreeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    ThreeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [ThreeBtn.layer setMasksToBounds:YES];
    [ThreeBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [ThreeBtn.layer setBorderWidth:1.0]; //边框宽度
    [ThreeBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    [view addSubview:ThreeBtn];
    
    if (orderStatus==0) {
        [oneBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        twoBtn.hidden=YES;
        ThreeBtn.hidden=YES;
    }else if (orderStatus==10){
        [oneBtn setTitle:@"去支付" forState:UIControlStateNormal];
        //oneBtn.tag=indexPath.row;
        [oneBtn addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
        [twoBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        ThreeBtn.hidden=YES;
      //  twoBtn.tag=indexPath.row;
        [twoBtn addTarget:self action:@selector(CencelOrder) forControlEvents:UIControlEventTouchUpInside];
        //取消订单
    }else if (orderStatus==20){
        [oneBtn setTitle:@"暂无物流消息" forState:UIControlStateNormal];
        [oneBtn.layer setBorderWidth:0.0]; //边框宽度
        twoBtn.hidden=YES;
        ThreeBtn.hidden=YES;
    }else if (orderStatus==30){
        [oneBtn setTitle:@"确认收货" forState:UIControlStateNormal];
      //  oneBtn.tag=indexPath.row;
        [oneBtn addTarget:self action:@selector(adjective) forControlEvents:UIControlEventTouchUpInside];
        [twoBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [twoBtn addTarget:self action:@selector(wuliu) forControlEvents:UIControlEventTouchUpInside];
        ThreeBtn.hidden=YES;
        //查看物流
    }else if (orderStatus>=50 && orderStatus < 60){
        [oneBtn setTitle:@"投诉" forState:UIControlStateNormal];
        twoBtn.hidden=YES;
        ThreeBtn.hidden=YES;
        //oneBtn.tag=indexPath.row;
        [oneBtn addTarget:self action:@selector(tousu) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (orderStatus >= 40 && orderStatus < 50){
        [oneBtn setTitle:@"我要评价" forState:UIControlStateNormal];
      //  oneBtn.tag=indexPath.row;
        [oneBtn addTarget:self action:@selector(PingJia) forControlEvents:UIControlEventTouchUpInside];
        if (orderStatus==40) {
            [twoBtn setTitle:@"申请退货" forState:UIControlStateNormal];
           // twoBtn.tag=indexPath.row;
            [twoBtn addTarget:self action:@selector(tuihuo) forControlEvents:UIControlEventTouchUpInside];
        }else if (orderStatus==45){
            [twoBtn setTitle:@"申请退货中" forState:UIControlStateNormal];
        }else if (orderStatus==46){
            [twoBtn setTitle:@"退货中" forState:UIControlStateNormal];
        }else if (orderStatus==47){
            [twoBtn setTitle:@"退货完成" forState:UIControlStateNormal];
        }else if (orderStatus==48){
            [twoBtn setTitle:@"卖家拒绝退货" forState:UIControlStateNormal];
        }else if (orderStatus==49){
            [twoBtn setTitle:@"退货失败" forState:UIControlStateNormal];
        }
        //    }
        [ThreeBtn setTitle:@"投诉" forState:UIControlStateNormal];
        //ThreeBtn.tag=indexPath.row;
        [ThreeBtn addTarget:self action:@selector(tousu) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return _DDmodel.gcs.count;
    }else if(section==2){
        return 4;
    }else if(section==3){
        return 4;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 30;
        }else{
            return 50;
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            return 120;
        }
        return 80;
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            return 50;
        }else if (indexPath.row==1){
            return 50;
        }
        return 30;
    }else if(indexPath.section==3){
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UILabel *dingdan=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-20, 30)];
            dingdan.text=[NSString stringWithFormat:@"订单状态：%@",_DDmodel.button_text];
            [cell.contentView addSubview:dingdan];
            UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(10, 29.5, Screen_Width-20, 0.5)];
            aaView.backgroundColor=[UIColor grayColor];
            [cell.contentView addSubview:aaView];
        }else{
            UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 20)];
            imgView.image=[UIImage imageNamed:@"定位"];
            [cell.contentView addSubview:imgView];
            
            UILabel *dingdan=[[UILabel alloc] initWithFrame:CGRectMake(40, 0, Screen_Width-50, 20)];
            dingdan.text=[NSString stringWithFormat:@"%@:%@",_DDmodel.addr_trueName,_DDmodel.addr_mobile];
            dingdan.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:dingdan];
            
            UILabel *dingdan1=[[UILabel alloc] initWithFrame:CGRectMake(40, 25, Screen_Width-50, 20)];
            dingdan1.text=[NSString stringWithFormat:@"%@",_DDmodel.addr_info];
            dingdan1.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:dingdan1];
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            UILabel *dingdan=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, Screen_Width-20, 30)];
            dingdan.text=@"订单详情信息";
            [cell.contentView addSubview:dingdan];
            
            UIImageView *SpImg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 45, 60, 60)];
            NSString *bb=[[_DDmodel.gcs objectAtIndex:indexPath.row] objectForKey:@"goods_img"];
            [SpImg sd_setImageWithURL:[NSURL URLWithString:bb] placeholderImage:[UIImage imageNamed:@"默认图片"]];
            [cell.contentView addSubview:SpImg];
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(80, 30, Screen_Width-105, 30)];
            lable.text=[[_DDmodel.gcs objectAtIndex:indexPath.row] objectForKey:@"goods_name"];;
            lable.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:lable];
            UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(80, 60, Screen_Width-115, 30)];
            lable1.text=[NSString stringWithFormat:@"数量：X%@",_DDmodel.goods_count];
            lable1.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:lable1];
            UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(80, 90, Screen_Width-115, 30)];
            lable2.font=[UIFont systemFontOfSize:13];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.totalPrice];
            float faa=[jgstr floatValue];
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            lable2.text=[NSString stringWithFormat:@"%@",hongses];
            [cell.contentView addSubview:lable2];
        }else{
            UIImageView *SpImg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 60, 60)];
            NSString *bb=[[_DDmodel.gcs objectAtIndex:indexPath.row] objectForKey:@"goods_img"];
            [SpImg sd_setImageWithURL:[NSURL URLWithString:bb] placeholderImage:[UIImage imageNamed:@"默认图片"]];
            [cell.contentView addSubview:SpImg];
            
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(80, 0, Screen_Width-115, 30)];
            lable.font=[UIFont systemFontOfSize:13];
            lable.text=[[_DDmodel.gcs objectAtIndex:indexPath.row] objectForKey:@"goods_name"];;
            [cell.contentView addSubview:lable];
            UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(80, 30, Screen_Width-115, 30)];
            lable1.text=[NSString stringWithFormat:@"数量：X%@",_DDmodel.goods_count];
            lable1.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:lable1];
            UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(80, 60, Screen_Width-115, 30)];
            lable2.font=[UIFont systemFontOfSize:13];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.totalPrice];
            float faa=[jgstr floatValue];
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            lable2.text=[NSString stringWithFormat:@"%@",hongses];
            [cell.contentView addSubview:lable2];
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=[NSString stringWithFormat:@"订单编号：%@",_DDmodel.order_id];
            [cell.contentView addSubview:aa];
            
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(10, 25, Screen_Width-20, 25)];
            bb.font=[UIFont systemFontOfSize:13];
            bb.text=[NSString stringWithFormat:@"下单时间：%@",_DDmodel.shipTime];
            [cell.contentView addSubview:bb];
            
            UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(10, 49.5, Screen_Width-20, 0.5)];
            aaView.backgroundColor=[UIColor grayColor];
            [cell.contentView addSubview:aaView];
        }else if (indexPath.row==1){
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=[NSString stringWithFormat:@"配送方式：%@",_DDmodel.transport];//
            [cell.contentView addSubview:aa];
            
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(10, 25, Screen_Width-20, 25)];
            bb.font=[UIFont systemFontOfSize:13];
            bb.text=[NSString stringWithFormat:@"配送时间：%@",_DDmodel.shipTime];
            [cell.contentView addSubview:bb];
            
            UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(10, 49.5, Screen_Width-20, 0.5)];
            aaView.backgroundColor=[UIColor grayColor];
            [cell.contentView addSubview:aaView];
        }else if (indexPath.row==2){
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=[NSString stringWithFormat:@"支付方式：%@",_DDmodel.payment_mark];
            [cell.contentView addSubview:aa];
            UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(10, 29.5, Screen_Width-20, 0.5)];
            aaView.backgroundColor=[UIColor grayColor];
            [cell.contentView addSubview:aaView];
        }else if (indexPath.row==3){
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=[NSString stringWithFormat:@"发票类型：%@",_DDmodel.invoiceType];
            [cell.contentView addSubview:aa];
        }
    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-140, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=[NSString stringWithFormat:@"商品总额"];
            [cell.contentView addSubview:aa];
            
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-140, 5, 120, 25)];
            bb.textAlignment=NSTextAlignmentRight;
            bb.textColor=[UIColor redColor];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.totalPrice];
            float faa=[jgstr floatValue];
            
            NSString *jgstr1=[NSString stringWithFormat:@"%@",_DDmodel.coupon_amount];
            float faa1=[jgstr1 floatValue];
            
            NSString *jgstr2=[NSString stringWithFormat:@"%@",_DDmodel.ship_price];
            float faa2=[jgstr2 floatValue];
            
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa+faa1-faa2];
            bb.font=[UIFont systemFontOfSize:13];
            bb.text=[NSString stringWithFormat:@"%@",hongses];
            [cell.contentView addSubview:bb];
        }else if (indexPath.row==1){
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-140, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=@"+运费";
            [cell.contentView addSubview:aa];
            
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-140, 5, 120, 25)];
            bb.font=[UIFont systemFontOfSize:13];
            bb.textAlignment=NSTextAlignmentRight;
            bb.textColor=[UIColor redColor];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.ship_price];
            float faa=[jgstr floatValue];
            
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            bb.text=[NSString stringWithFormat:@"%@",hongses];
            [cell.contentView addSubview:bb];
        }else if (indexPath.row==2){
            UILabel *aa=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-140, 25)];
            aa.font=[UIFont systemFontOfSize:13];
            aa.text=@"-优惠卷";
            [cell.contentView addSubview:aa];
            
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-140, 5, 120, 25)];
            bb.font=[UIFont systemFontOfSize:13];
            bb.textAlignment=NSTextAlignmentRight;
            bb.textColor=[UIColor redColor];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.coupon_amount];
            float faa=[jgstr floatValue];
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            bb.text=[NSString stringWithFormat:@"%@",hongses];
            [cell.contentView addSubview:bb];
        }else if (indexPath.row==3){
            UILabel *bb=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-160, 5, 140, 25)];
            bb.textAlignment=NSTextAlignmentRight;
            bb.textColor=[UIColor redColor];
            NSString *jgstr=[NSString stringWithFormat:@"%@",_DDmodel.totalPrice];
            float faa=[jgstr floatValue];
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            bb.font=[UIFont systemFontOfSize:13];
            bb.text=[NSString stringWithFormat:@"应付:%@",hongses];
            [cell.contentView addSubview:bb];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//我要评价
-(void)PingJia{
    JudgeViewController *Judge=[[JudgeViewController alloc] init];
    Judge.Oid=_DDmodel.id;
    Judge.saveArray=_DDmodel.gcs;
    [self.navigationController pushViewController:Judge animated:NO];
}
//确定收货
-(void)adjective{
    FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"确认收货" icon:[UIImage imageNamed:@""] message:@"商品已经收到" delegate:nil buttonTitles:@"确定", @"取消", nil];
    [alert show];
}
- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [SVProgressHUD showWithStatus:@"加载中"];
        NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order_cofirm_save.htm?id=%@",DsURL,_DDmodel.id];
        // NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            //   NSLog(@"%@",);
            NSString *str=[data objectForKey:@"msg"];
            NSString *msg=[data objectForKey:@"statusCode"];
            int lob=[msg intValue];
            if (lob==200) {
                [SVProgressHUD showSuccessWithStatus:str];
            }
            [SVProgressHUD showSuccessWithStatus:str];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }
}
//取消订单
-(void)CencelOrder{
    CancelOrderViewController *CancelOrder=[[CancelOrderViewController alloc] init];
    CancelOrder.ordId=_DDmodel.order_id;
    [self.navigationController pushViewController:CancelOrder animated:NO];
}
//支付
-(void)zhifu{
    PayInfoViewController *payInfo=[[PayInfoViewController alloc] init];
    payInfo.TOId=_DDmodel.id;
    payInfo.jiage=_DDmodel.totalPrice;
    [self.navigationController pushViewController:payInfo animated:NO];
}
//投诉
-(void)tousu{
    NSString *ordrId=_DDmodel.order_id;
    NSString *Time=_DDmodel.addTime;
    NSString *maijia=_DDmodel.addr_trueName;
    NSString *Dianmin=_DDmodel.store_name;
    NSString *uid=_DDmodel.to_user_id;
    NSString *name=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *img=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    NSString *jiage=[NSString stringWithFormat:@"%@",[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"price"]];
    NSString *shuliao=[NSString stringWithFormat:@"%@",[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"count"]];
    NSString *goodsId=[NSString stringWithFormat:@"%@",[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_id"]];
    
    DSTuoShuViewController *DSTuoShu=[[DSTuoShuViewController alloc]init];
    DSTuoShu.Tid=ordrId;
    DSTuoShu.Timg=img;
    DSTuoShu.Tjias=jiage;
    DSTuoShu.Tshu=shuliao;
    DSTuoShu.Ttitle=name;
    DSTuoShu.Ttime=Time;
    DSTuoShu.TOId=_DDmodel.id;
    DSTuoShu.addr_trueName=maijia;
    DSTuoShu.store_name=Dianmin;
    DSTuoShu.userid=uid;
    DSTuoShu.goodid=goodsId;
    NSLog(@"Tjias%@",DSTuoShu.Tjias);
    //goodsId
    [self.navigationController pushViewController:DSTuoShu animated:NO];
}
//退货
-(void)tuihuo{
    NSString *ordrId=_DDmodel.order_id;
    NSString *Time=_DDmodel.addTime;
    NSString *name=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *img=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    NSString *jiage=[NSString stringWithFormat:@"%@",[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"price"]];
    NSString *shuliao=[NSString stringWithFormat:@"%@",[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"count"]];
    SQTuiHuoViewController *tuihuo=[[SQTuiHuoViewController alloc]init];
    tuihuo.Tid=ordrId;
    tuihuo.Timg=img;
    tuihuo.Tjia=jiage;
    tuihuo.Tshu=shuliao;
    tuihuo.Ttitle=name;
    tuihuo.Ttime=Time;
    tuihuo.TOId=_DDmodel.id;
    [self.navigationController pushViewController:tuihuo animated:NO];
}
//wuliu
-(void)wuliu{
//    OrderModel *modle=ModelArray[sender.tag];
    NSString *ordrId=_DDmodel.id;
    WuLiuXQViewController *WuLiuXQ=[[WuLiuXQViewController alloc] init];
    WuLiuXQ.oid=ordrId;
    WuLiuXQ.ajiage=_DDmodel.totalPrice;
    NSString *name=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *aimg=[[_DDmodel.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    WuLiuXQ.atitle=name;
    WuLiuXQ.img=aimg;
    WuLiuXQ.acont=_DDmodel.goods_count;
    [self.navigationController pushViewController:WuLiuXQ animated:NO];
}
-(void)btnCkmore
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
