//
//  DhJlViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DhJlViewController.h"
#import "PchHeader.h"
#import "DhJlModel.h"
#import "touwTableViewCell.h"
#import "UserItemCell.h"
#import "YfZDBTableViewCell.h"
#import "DhJlXqViewController.h"
#import "JlXqModel.h"
#import "FDAlertView.h"
#import "CustomMessageView.h"
#define IdentifierID @"userCellId"
#import "MJExtension.h"
#import "MJRefresh.h"
@interface DhJlViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,sendTheValueDelegate>
{
    CustomMessageView * contentView;
    FDAlertView *alert;

     UITableView *tableViews;
    NSMutableArray *_dataArray;
    NSMutableArray *_idArray;
    NSMutableArray *ImgArray;
    UITableViewCell *cell;
    NSArray *imgarray;NSString *idsave;
}
@property(assign,nonatomic) NSInteger currentPage;
@property (strong, nonatomic)UICollectionView *userCollection;
@property (strong, nonatomic)NSMutableArray *userArray;
@end

@implementation DhJlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"兑换记录";
    
    [self initTableView];
    _idArray=[NSMutableArray arrayWithCapacity:0];
    imgarray=[NSMutableArray arrayWithCapacity:0];
    _dataArray=[NSMutableArray arrayWithCapacity:0];
    [self setupRefresh];
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
-(void)lodatejl{
    NSString *strurl=[NSString stringWithFormat:@"%@integralExchangeRecord.htm?currentPage=%ld&pageSize=6",URLds,_currentPage];
    
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *arraysd=[data objectForKey:@"data"];
        if (arraysd.count!=0) {
            NSArray *daarray=[DhJlModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            NSArray *imgrray=[[[data objectForKey:@"data"] valueForKey:@"integral_goods"] valueForKey:@"image"];
            NSLog(@"=====%@",ImgArray);
            
            NSArray *idrray=[JlXqModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"data"] valueForKey:@"integral_goods"]];
            if (_currentPage==1) {
                [_dataArray removeAllObjects];
                [ImgArray removeAllObjects];
                [_idArray removeAllObjects];
            }
            [_dataArray addObjectsFromArray:daarray];
             [ImgArray addObjectsFromArray:imgrray];
             [_idArray addObjectsFromArray:idrray];
            [tableViews reloadData];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"没有记录"];
        }
      
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
- (void)initTableView {
    
    tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStyleGrouped];
    tableViews.delegate = self;
    tableViews.dataSource = self;
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([touwTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"twocell"];
      [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([touwTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"two2cell"];
     [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([YfZDBTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"yfcell"];
     [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([UITableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
 tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableViews];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.000000001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 90;
    }else if(indexPath.row==3){
    return 35;
    }else{
    
        return  44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        if (indexPath.row==0) {
               DhJlModel *model=_dataArray[indexPath.section];
             touwTableViewCell *touw2cell = [tableView  dequeueReusableCellWithIdentifier:@"two2cell"];
            touw2cell.lab1.text=[NSString stringWithFormat:@"兑换单号:%@",model.order_sn];
            if ([model.order_status containsString:@"-1"]) {
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 已取消"];
        
            }else if ([model.order_status containsString:@"0"]){
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 待付款"];
              
            }else if ([model.order_status containsString:@"10"]){
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 待审核"];
     
            }else if ([model.order_status containsString:@"20"]){
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 待发货"];
           
            }else if ([model.order_status containsString:@"30"]){
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 已发货"];
                
            }else if ([model.order_status containsString:@"40"]){
                touw2cell.lab2.text=[NSString stringWithFormat:@"订单状态: 已收货完成"];
                
            }
         touw2cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return touw2cell;
        }else if(indexPath.row==1){
            //定义个静态字符串为了防止与其他类的tableivew重复
        static NSString *CellIdentifier =@"Cell";
       //定义cell的复用性当处理大量数据时减少内存开销
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        cell.backgroundColor=[UIColor whiteColor];
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    //        flowlayout.headerReferenceSize = CGSizeMake(0, 0);
        flowlayout.itemSize = CGSizeMake(70, 70);  //每个的大小
        _userCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(5,0,Screen_Width-10, 80) collectionViewLayout:flowlayout];
        _userCollection.delegate = self;
        _userCollection.dataSource = self;
        _userCollection.showsVerticalScrollIndicator = NO;
        _userCollection.showsHorizontalScrollIndicator = NO;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [_userCollection setBackgroundColor:RGBColor(238, 238, 238)];
        [_userCollection registerClass:[UserItemCell class] forCellWithReuseIdentifier:IdentifierID];
        imgarray=ImgArray[indexPath.section];
        [cell addSubview:self.userCollection];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }else if(indexPath.row==3){
            DhJlModel *model=_dataArray[indexPath.section];
            YfZDBTableViewCell *yfwcell = [tableView  dequeueReusableCellWithIdentifier:@"yfcell"];
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"运费: ¥%@",model.trans_fee]];
            NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@" ¥%@",model.trans_fee]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@" ¥%@",model.trans_fee]].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo];
         if ([model.order_status containsString:@"30"]){
              yfwcell.labyf.frame=CGRectMake(10, 0, Screen_Width-215, 35) ;
                yfwcell.butsure.hidden=NO;
             
                yfwcell.butSureBlocks = ^(YfZDBTableViewCell *yfwcell) {
                    
                 JlXqModel *JlXqMo=_idArray[indexPath.section][0];
                    NSString *strurl=[NSString stringWithFormat:@"%@integral_order_confirm.htm?id=%@",URLds,JlXqMo.goods_order_id];
                    idsave=JlXqMo.goods_order_id;
                    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
                        NSLog(@"==%@",data);
                        NSArray *integral_order_sn=[[data objectForKey:@"data"] valueForKey:@"integral_order_sn"];
                        
                        alert = [[FDAlertView alloc] init];
                        
                        contentView=[[CustomMessageView alloc]initWithFrame:CGRectMake(0, 0, 290, 170)];
                        contentView.delegate=self;
                        alert.contentView = contentView;
                        [alert show];
                        
                        
                        contentView.contentLab.text=[NSString stringWithFormat:@"订单号:%@",integral_order_sn[0]];
                        contentView.twoLab.text=@"注意:如果你尚未收到货品请不要点击”确认“";
                    } failure:^(NSError *error) {
                        NSLog(@"---------------%@",error);
                        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
                    }];
                    
                };
             
         }else{
             
                yfwcell.butsure.hidden=YES;
                yfwcell.labyf.frame=CGRectMake(10, 0, Screen_Width-130, 35) ;
         }
            
            yfwcell.addToCartsBlock = ^(YfZDBTableViewCell *yfwcell) {
                    NSLog(@"%@",model.order_id);
                DhJlXqViewController *DhJlXqV=[[DhJlXqViewController alloc]init];
                DhJlXqV.strid=model.order_id;
                [self.navigationController pushViewController:DhJlXqV animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
            };
            [yfwcell.labyf setAttributedText:noteStr];
             yfwcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  yfwcell;
        }else{
            DhJlModel *model=_dataArray[indexPath.section];
            touwTableViewCell *touwcell = [tableView  dequeueReusableCellWithIdentifier:@"twocell"];
            touwcell.lab1.text=[NSString stringWithFormat:@"下单时间:%@",model.addTime];
            touwcell.lab1.textColor=[UIColor grayColor];
            
            if ([model.payment containsString:@"alipay"]) {
                  touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 支付宝"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }else if ([model.payment containsString:@"tenpay"]){
            touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 财付通"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }else if ([model.payment containsString:@"bill"]){
                touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 快钱"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }else if ([model.payment containsString:@"chinabank"]){
                touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 网银在线"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }
            else if ([model.payment containsString:@"outline"]){
                touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 线下支付"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }
            else if ([model.payment containsString:@"balance"]){
                touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 预存款支付"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }
            else if ([model.payment containsString:@"no_fee"]){
                touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 无运费订单"];
                touwcell.lab2.textColor=[UIColor grayColor];
            } else if (model.payment.length==0) {
                  touwcell.lab2.text=[NSString stringWithFormat:@"支付方式: 未支付"];
                touwcell.lab2.textColor=[UIColor grayColor];
            }
               touwcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return touwcell;
        
        
        }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imgarray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserItemCell *imgcell = [collectionView dequeueReusableCellWithReuseIdentifier:IdentifierID forIndexPath:indexPath];
    NSLog(@"%@====%ld",imgarray,indexPath.row);
       [imgcell.user_image sd_setImageWithURL:[NSURL URLWithString:imgarray[indexPath.row]]placeholderImage:[UIImage imageNamed:@"默认图片"]];

    return imgcell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTimeToValue:(NSString *)theTimeStr
{
    NSString *strurl=[NSString stringWithFormat:@"%@integral_order_confirm_save.htm?id=%@",URLds,idsave];
    
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"==%@",data);
        NSArray *op_title=[[data valueForKey:@"data"] valueForKey:@"op_title"];
        [SVProgressHUD showSuccessWithStatus:op_title[0]];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self lodatejl];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableViews reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [tableViews.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self lodatejl];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableViews reloadData];
        [tableViews.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    tableViews.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
        
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [tableViews.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    tableViews.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
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
