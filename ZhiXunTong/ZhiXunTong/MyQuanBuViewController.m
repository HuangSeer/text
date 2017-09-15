//
//  MyQuanBuViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "MyQuanBuViewController.h"
#import "PchHeader.h"
#import "OrderModel.h"
#import "OrderTableViewCell.h"
#import "YJSegmentedControl.h"
#import "SQTuiHuoViewController.h"//电商退货
#import "DSTuoShuViewController.h"//电商投诉
#import "EvaluateViewController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiManager.h"
#import "CancelOrderViewController.h"//取消订单
#import "JudgeViewController.h"//评价
#import "PayInfoViewController.h"//支付页面
#import "DDXqViewController.h"//订单详情
#import "WuLiuXQViewController.h"//物流详情
#import "MJExtension.h"
#import "MJRefresh.h"
@interface MyQuanBuViewController ()<UITableViewDataSource,UITableViewDelegate,YJSegmentedControlDelegate>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    NSMutableArray *ModelArray;
    NSArray *titleArray;
    NSMutableDictionary *userinfo;
    NSString *phone;
    NSString *gg;
    NSMutableDictionary *objArry;
    NSString *ZFordid;
    UIImageView *img;
}
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger currentPage;  //当前页
@end

@implementation MyQuanBuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"我的订单";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, Screen_Width, Screen_height-60)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    titleArray = @[@"全部",@"待支付",@"待收货",@"已取消",@"已完成"];
    ModelArray=[NSMutableArray arrayWithCapacity:0];
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor grayColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor greenColor] buttonDownColor:[UIColor greenColor] Delegate:self];
    [self.view addSubview:segment];
//    [self MoNiLogin];
     [self setupRefresh];
}
-(void)btnCkmore
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -- 遵守代理 实现代理方法
- (void)segumentSelectionChange:(NSInteger)selection{
//    self.currentPage=1;
    NSLog(@"%@",[titleArray objectAtIndex:selection]);
    NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        NSLog(@"MoNiLogin===%@",data);
        NSString *str=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
        int aa=[str intValue];
        if (aa==200) {
            self.currentPage=1;
            if (selection==0) {
                
                [self post:@""];
            }else if (selection==1){
                [self post:@"order_submit"];
            }else if (selection==2){
                [self post:@"order_shipping"];
            }else if (selection==3){
                [self post:@"order_cancel"];
            }else if (selection==4){
                [self post:@"order_finish"];
            }
        }
    } failure:^(NSError *error) {
//        NSLog(@"---------------%@",error);
      [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
   
}
-(void)MoNiLogin{
    
    NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        NSLog(@"MoNiLogin===%@",data);
        NSString *str=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
        int aa=[str intValue];
        if (aa==200) {
            [self post:@""];
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
-(void)post:(NSString *)sender{
//    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order.htm?currentPage=%ld&order_status=%@",DsURL,self.currentPage,sender];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"post====%@",data);
        NSArray *ARRAY=[OrderModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"list"]];
       
        if (_currentPage==1) {
            [ModelArray removeAllObjects];
            
        }
        [ModelArray addObjectsFromArray:ARRAY];
        NSLog(@"mod%ld",ModelArray.count);
        if (ModelArray.count==0) {
            [_tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            img=[[UIImageView alloc] initWithFrame:CGRectMake((Screen_Width-100)/2, 100, 100, 100)];
            img.image=[UIImage imageNamed:@"默认图片"];
            [self.view addSubview:img];
            UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 220, Screen_Width, 30)];
            lab.text=@"没有数据";
            lab.textAlignment=NSTextAlignmentCenter;
            [self.view addSubview:lab];
        }else{
            img.hidden=YES;
            [_tableView reloadData];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ModelArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    OrderModel *moder=[ModelArray objectAtIndex:indexPath.row];
    NSString *aa;
    NSString *title;
    cell.Stor_name.text=[NSString stringWithFormat:@"%@",moder.store_name];
        if (moder.gcs.count==1) {
            aa=[[moder.gcs objectAtIndex:0] objectForKey:@"goods_img"];
            title=[[moder.gcs objectAtIndex:0] objectForKey:@"goods_name"];
            cell.Lalbe_title.text=[NSString stringWithFormat:@"%@",title];
            
            NSString *jgstr=[NSString stringWithFormat:@"%@",[[moder.gcs objectAtIndex:0] objectForKey:@"price"]];
            float faa=[jgstr floatValue];
            NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
            //实现某段字符串显示不一样的颜色
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"需要支付：%@",hongses]];
            NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",hongses]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",hongses]].length);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo2];
            [cell.lab_prict setAttributedText:noteStr2];
            
            cell.lab_cont.text=[NSString stringWithFormat:@"数量：X%@",[[moder.gcs objectAtIndex:0] objectForKey:@"count"]];
            [cell.img sd_setImageWithURL:[NSURL URLWithString:aa] placeholderImage:[UIImage imageNamed:@"默认图片"]];
            cell.lab_zt.text=[NSString stringWithFormat:@"%@",moder.button_text];
        }
    if (moder.gcs.count>1) {
        NSString *jgstr=[NSString stringWithFormat:@"%@",moder.totalPrice];
        float faa=[jgstr floatValue];
        NSString *hongses=[NSString stringWithFormat:@"￥%.2f",faa];
        //实现某段字符串显示不一样的颜色
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"需要支付：%@",hongses]];
        NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",hongses]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",hongses]].length);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo2];
        [cell.lab_prict setAttributedText:noteStr2];

        cell.lab_zt.text=[NSString stringWithFormat:@"%@",moder.button_text];
        cell.lab_cont.text=[NSString stringWithFormat:@"数量：X%@",moder.goods_count];
        //创建
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, 75)];
        scrollView.userInteractionEnabled=NO;
         scrollView.scrollEnabled = YES;   // 默认为YES
        for (int i=0; i<moder.gcs.count; i++) {
            NSString *bb=[[moder.gcs objectAtIndex:i] objectForKey:@"goods_img"];
            
            UIImageView *MyImgView= [[UIImageView alloc] initWithFrame:CGRectMake(10+(i*70), 5, 65, 65)];
            [MyImgView sd_setImageWithURL:[NSURL URLWithString:bb] placeholderImage:[UIImage imageNamed:@"默认图片"]];
            MyImgView.userInteractionEnabled=NO;
            [scrollView addSubview:MyImgView];
        }
        cell.hui_View.backgroundColor=RGBColor(245, 245, 245);
        [cell.hui_View addSubview:scrollView];
    }
        NSString *abc=moder.order_status;
        int orderStatus=[abc intValue];
        [cell.oneBtn.layer setMasksToBounds:YES];
        [cell.oneBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [cell.oneBtn.layer setBorderWidth:1.0]; //边框宽度
        [cell.oneBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    
        [cell.twoBtn.layer setMasksToBounds:YES];
        [cell.twoBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [cell.twoBtn.layer setBorderWidth:1.0]; //边框宽度
        [cell.twoBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
    
        [cell.ThreeBtn.layer setMasksToBounds:YES];
        [cell.ThreeBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [cell.ThreeBtn.layer setBorderWidth:1.0]; //边框宽度
        [cell.ThreeBtn.layer setBorderColor:[UIColor redColor].CGColor];//边框颜色
        NSLog(@"%d",orderStatus);
        if (orderStatus==0) {
            [cell.oneBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            cell.twoBtn.hidden=YES;
            cell.ThreeBtn.hidden=YES;
        }else if (orderStatus==10){
            [cell.oneBtn setTitle:@"去支付" forState:UIControlStateNormal];
            cell.oneBtn.tag=indexPath.row;
            [cell.oneBtn addTarget:self action:@selector(zhifu:) forControlEvents:UIControlEventTouchUpInside];
            [cell.twoBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            cell.ThreeBtn.hidden=YES;
            cell.twoBtn.tag=indexPath.row;
            [cell.twoBtn addTarget:self action:@selector(CencelOrder:) forControlEvents:UIControlEventTouchUpInside];
            //取消订单
        }else if (orderStatus==20){
            [cell.oneBtn setTitle:@"暂无物流消息" forState:UIControlStateNormal];
            [cell.oneBtn.layer setBorderWidth:0.0]; //边框宽度
            cell.twoBtn.hidden=YES;
            cell.ThreeBtn.hidden=YES;
        }else if (orderStatus==30){
            [cell.oneBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            cell.oneBtn.tag=indexPath.row;
            [cell.oneBtn addTarget:self action:@selector(adjective:) forControlEvents:UIControlEventTouchUpInside];
            [cell.twoBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [cell.twoBtn addTarget:self action:@selector(wuliu:) forControlEvents:UIControlEventTouchUpInside];
            cell.twoBtn.tag=indexPath.row;
            cell.ThreeBtn.hidden=YES;
            //查看物流
        }else if (orderStatus>=50 && orderStatus < 60){
            [cell.oneBtn setTitle:@"投诉" forState:UIControlStateNormal];
            cell.twoBtn.hidden=YES;
            cell.ThreeBtn.hidden=YES;
            cell.oneBtn.tag=indexPath.row;
            [cell.oneBtn addTarget:self action:@selector(tousu:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (orderStatus >= 40 && orderStatus < 50){
            [cell.oneBtn setTitle:@"我要评价" forState:UIControlStateNormal];
            cell.oneBtn.tag=indexPath.row;
            [cell.oneBtn addTarget:self action:@selector(PingJia:) forControlEvents:UIControlEventTouchUpInside];
            if (orderStatus==40) {
                [cell.twoBtn setTitle:@"申请退货" forState:UIControlStateNormal];
                cell.twoBtn.tag=indexPath.row;
                [cell.twoBtn addTarget:self action:@selector(tuihuo:) forControlEvents:UIControlEventTouchUpInside];
            }else if (orderStatus==45){
                [cell.twoBtn setTitle:@"申请退货中" forState:UIControlStateNormal];
            }else if (orderStatus==46){
                [cell.twoBtn setTitle:@"退货中" forState:UIControlStateNormal];
            }else if (orderStatus==47){
                [cell.twoBtn setTitle:@"退货完成" forState:UIControlStateNormal];
            }else if (orderStatus==48){
                [cell.twoBtn setTitle:@"卖家拒绝退货" forState:UIControlStateNormal];
            }else if (orderStatus==49){
                [cell.twoBtn setTitle:@"退货失败" forState:UIControlStateNormal];
            }
            //    }
            [cell.ThreeBtn setTitle:@"投诉" forState:UIControlStateNormal];
            cell.ThreeBtn.tag=indexPath.row;
            [cell.ThreeBtn addTarget:self action:@selector(tousu:) forControlEvents:UIControlEventTouchUpInside];
        }
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 160, Screen_Width, 10)];
    view.backgroundColor=RGBColor(234, 234, 234);
    [cell.contentView addSubview:view];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//我要评价
-(void)PingJia:(UIButton *)sender{
    OrderModel *modle=ModelArray[sender.tag];
    NSLog(@"tag=%ld",sender.tag);
    ZFordid=modle.id;
    NSMutableArray *array=modle.gcs;
    NSLog(@"array=%@",array);
    JudgeViewController *Judge=[[JudgeViewController alloc] init];
    Judge.Oid=ZFordid;
    Judge.saveArray=array;
    [self.navigationController pushViewController:Judge animated:NO];
}
//确定收货
-(void)adjective:(UIButton *)sender
{
    OrderModel *modle=ModelArray[sender.tag];
    ZFordid=modle.id;
    FDAlertView *alert = [[FDAlertView alloc] initWithTitle:@"确认收货" icon:[UIImage imageNamed:@""] message:@"商品已经收到" delegate:nil buttonTitles:@"确定", @"取消", nil];
    [alert show];

}
- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
            NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order_cofirm_save.htm?id=%@",DsURL,ZFordid];
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
-(void)CencelOrder:(UIButton *)sender
{
    OrderModel *modle=ModelArray[sender.tag];
    ZFordid=modle.order_id;
    CancelOrderViewController *CancelOrder=[[CancelOrderViewController alloc] init];
    CancelOrder.ordId=ZFordid;
    [self.navigationController pushViewController:CancelOrder animated:NO];
}
//支付
-(void)zhifu:(UIButton *)sender{
    OrderModel *modle=ModelArray[sender.tag];
    ZFordid=modle.id;
    
    PayInfoViewController *payInfo=[[PayInfoViewController alloc] init];
    payInfo.TOId=ZFordid;
    payInfo.jiage=modle.totalPrice;
    [self.navigationController pushViewController:payInfo animated:NO];
}
//投诉
-(void)tousu:(UIButton *)sender{
    OrderModel *modle=ModelArray[sender.tag];
    NSString *ordrId=modle.order_id;
    NSString *Time=modle.addTime;
    NSString *maijia=modle.addr_trueName;
    NSString *Dianmin=modle.store_name;
    NSString *uid=modle.to_user_id;
    NSString *name=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *img=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    NSString *jiage=[NSString stringWithFormat:@"%@",[[modle.gcs objectAtIndex:0] objectForKey:@"price"]];
    NSString *shuliao=[NSString stringWithFormat:@"%@",[[modle.gcs objectAtIndex:0] objectForKey:@"count"]];
    NSString *goodsId=[NSString stringWithFormat:@"%@",[[modle.gcs objectAtIndex:0] objectForKey:@"goods_id"]];
    
    DSTuoShuViewController *DSTuoShu=[[DSTuoShuViewController alloc]init];
    DSTuoShu.Tid=ordrId;
    DSTuoShu.Timg=img;
    DSTuoShu.Tjias=jiage;
    DSTuoShu.Tshu=shuliao;
    DSTuoShu.Ttitle=name;
    DSTuoShu.Ttime=Time;
    DSTuoShu.TOId=modle.id;
    DSTuoShu.addr_trueName=maijia;
    DSTuoShu.store_name=Dianmin;
    DSTuoShu.userid=uid;
    DSTuoShu.goodid=goodsId;
    NSLog(@"Tjias%@",DSTuoShu.Tjias);
    //goodsId
    [self.navigationController pushViewController:DSTuoShu animated:NO];
}
//退货
-(void)tuihuo:(UIButton *)sender{
    OrderModel *modle=ModelArray[sender.tag];
    NSString *ordrId=modle.order_id;
    NSString *Time=modle.addTime;
    NSString *name=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *img=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    NSString *jiage=[NSString stringWithFormat:@"%@",[[modle.gcs objectAtIndex:0] objectForKey:@"price"]];
    NSString *shuliao=[NSString stringWithFormat:@"%@",[[modle.gcs objectAtIndex:0] objectForKey:@"count"]];
    SQTuiHuoViewController *tuihuo=[[SQTuiHuoViewController alloc]init];
    tuihuo.Tid=ordrId;
    tuihuo.Timg=img;
    tuihuo.Tjia=jiage;
    tuihuo.Tshu=shuliao;
    tuihuo.Ttitle=name;
    tuihuo.Ttime=Time;
    tuihuo.TOId=modle.id;
    [self.navigationController pushViewController:tuihuo animated:NO];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *moder=[ModelArray objectAtIndex:indexPath.row];
    DDXqViewController *ddxq=[[DDXqViewController alloc] init];
    ddxq.DDmodel=moder;
    [self.navigationController pushViewController:ddxq animated:NO];
}
//物流详情
-(void)wuliu:(UIButton *)sender{
    OrderModel *modle=ModelArray[sender.tag];
    NSString *ordrId=modle.id;
    WuLiuXQViewController *WuLiuXQ=[[WuLiuXQViewController alloc] init];
    WuLiuXQ.oid=ordrId;
    WuLiuXQ.ajiage=modle.totalPrice;
    NSString *name=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_name"];
    NSString *aimg=[[modle.gcs objectAtIndex:0] objectForKey:@"goods_img"];
    WuLiuXQ.atitle=name;
    WuLiuXQ.img=aimg;
    WuLiuXQ.acont=modle.goods_count;
    [self.navigationController pushViewController:WuLiuXQ animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tongzhi3:(NSString *)sender{
   // ooid=sender;
    NSLog(@"－－－－－接收到通知-----重新支付-");
    //NSLog(@"sender%@==%@",sender,ooid);
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self MoNiLogin];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
//    [self MoNiLogin];
    [self MoNiLogin];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_tableView reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
       [_tableView.mj_footer endRefreshing];
    });
}
/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
    }];
#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView.mj_header beginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

@end
