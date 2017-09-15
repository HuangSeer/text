
//
//  JfXDViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JfXDViewController.h"
#import "PchHeader.h"
#import "DdAddressTableViewCell.h"
#import "DiZhiModel.h"
#import "DiZhiViewController.h"
#import "JfDhsPxqTableViewCell.h"
#import "JfdhModel.h"
#import "LiuYanTableViewCell.h"

@interface JfXDViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableViews;
    NSMutableDictionary *userinfo;
    NSString *cookiestr;
    NSUserDefaults *userDefaults;
    NSMutableArray *_dataArray;
    NSMutableArray *CmodelMuarray;
    NSInteger intro;
    NSString *strpd;
    UILabel *lab;
    UIView *viewd;
    LiuYanTableViewCell *cellc;
    NSString *strdzid;
}

@end

@implementation JfXDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商品兑换";
    [CmodelMuarray removeAllObjects];
//    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
   
    userDefaults= [NSUserDefaults standardUserDefaults];
    cookiestr=[userDefaults objectForKey:Cookiestr];
     [self initTableView];
     [self lodadate2];
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
-(void)lodadate2{

    CmodelMuarray=[JfdhModel mj_objectArrayWithKeyValuesArray:_Cmodelarry];
    NSLog(@"%@",CmodelMuarray);
    
    NSString *strurlpl=[NSString stringWithFormat:@"%@getAddressList.htm?currentPage=1&Cookie=%@",URLds,cookiestr];
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSLog(@"sad===222222222222222222==2=2=2========%@",data);
 
        NSArray *arry=[DiZhiModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"list"]] ;
        if (intro !=0) {
            _dataArray=[NSMutableArray arrayWithCapacity:0];
            
            [_dataArray addObject:arry[intro]];
        }else{
            _dataArray=[NSMutableArray arrayWithCapacity:0];
            
            [_dataArray addObject:arry[0]];
        }
        
        NSLog(@"%@",_dataArray);
      viewd =[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height-110, Screen_Width,47)];
       
      lab =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, Screen_Width/1.5-5, 47)];

        [viewd addSubview:lab];
        UIButton *butdh=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.5, 0, Screen_Width/3, 47)];
        [butdh setTitle:@"立即兑换" forState:UIControlStateNormal];
        [butdh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [butdh addTarget:self action:@selector(butdhClick) forControlEvents:UIControlEventTouchUpInside];
        butdh.backgroundColor=[UIColor orangeColor];
        [viewd addSubview:butdh];
        
        [self.view addSubview:viewd];
          [self countPrice];
        [tableViews reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
    }];
    
    
}
- (void)initTableView {
    
    tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-110) style:UITableViewStyleGrouped];
    tableViews.delegate = self;
    tableViews.dataSource = self;
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([DdAddressTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Onecell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([JfDhsPxqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Twocell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([LiuYanTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Threecell"];

    [self.view addSubview:tableViews];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return   0.00001;
    }else if (section==1) {
      return   5;
    }else{
        
        return 0.00001;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JfdhModel *JfdhM=CmodelMuarray[indexPath.row];
          [CmodelMuarray removeObjectAtIndex:indexPath.row];
            NSString *strurl=[NSString stringWithFormat:@"%@integral_remove.htm?id=%@",URLds,JfdhM.igc__goods_id];
            [ZQLNetWork getWithUrlString:strurl success:^(id data) {
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
                if (CmodelMuarray.count==0) {
                    strpd=@"0";
                }
              
                [tableView reloadData];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
//            [self performSelector:@selector(lodadate2) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([strpd containsString:@"0"]) {
        [viewd removeFromSuperview];
        return 0;
    }else{
    return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if (section==1) {
        return CmodelMuarray.count;
    }else if (section==2) {
        return 1;
    }
    else{
        return 0;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }else if (indexPath.section==1) {
        return 95;
    }else if (indexPath.section==2) {
        return 44;
    }
     else{
        return 0;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        DiZhiModel *DiZhiMo=_dataArray[indexPath.row];
        DdAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Onecell"];
          cell.DiZhiM=_dataArray[indexPath.row];
        strdzid=[NSString stringWithFormat:@"%@",DiZhiMo.id];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      
        
        return cell;
    } else if (indexPath.section==1) {
        JfDhsPxqTableViewCell *cellb = [tableView dequeueReusableCellWithIdentifier:@"Twocell"];
        cellb.JfdhM=CmodelMuarray[indexPath.row];
        [cellb setSelectionStyle:UITableViewCellSelectionStyleNone];
        

        return cellb;
    }
    else if (indexPath.section==2) {
         cellc= [tableView dequeueReusableCellWithIdentifier:@"Threecell"];
        [cellc setSelectionStyle:UITableViewCellSelectionStyleNone];
  
        return cellc;
    }else{
    
        return nil;
    }
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        DiZhiViewController *DiZhiVi=[[DiZhiViewController alloc]init];
         //block回调
        DiZhiVi.ceellBackBlock = ^(NSInteger  introw){
            
            intro=introw;
            NSLog(@"this is %ld",intro);
            [self lodadate2];
        };
        [self.navigationController pushViewController:DiZhiVi animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
    
    
    
    }
  
    
}
- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    NSString *text = [NSString stringWithFormat:@"所需积分:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"所需积分:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:rang];
    return LZString;
}
-(void)countPrice {
    double totlePrice = 0.0;
    
    for (JfdhModel *model in CmodelMuarray) {
        
        double price = [model.igc_goods_integral doubleValue];
        
        totlePrice += price * model.igc_count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    lab.attributedText = [self LZSetString:string];
}
-(void)butdhClick{
//cellc.textfiledly.text
    NSLog(@"%@",_strcook);
    
    NSString *strurl=[NSString stringWithFormat:@"%@integralExchangeThree.htm?addr_id=%@&igo_msg=%@&integral_order_session=%@",URLds,strdzid,cellc.textfiledly.text,_strcook];
    
        NSString *strtextview=[[NSString stringWithFormat:@"%@",strurl]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [ZQLNetWork getWithUrlString:strtextview success:^(id data) {
        NSLog(@"%@",data);
        NSString *msg=[NSString stringWithFormat:@"兑换成功,你的订单号是:%@",[[data objectForKey:@"data"] objectForKey:@"igo_order_sn"] ];
        NSLog(@"==99%@",msg );
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        

    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

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
