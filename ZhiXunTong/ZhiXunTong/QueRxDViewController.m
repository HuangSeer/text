
//
//  QueRxDViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "QueRxDViewController.h"
#import "PchHeader.h"
#import "DdAddressTableViewCell.h"
#import "DiZhiViewController.h"
#import "QuerSpTableViewCell.h"
#import "CouponViewController.h"
#import "yfmodel.h"
#import "YunfeiTableViewCell.h"
#import "KaiJfpTableViewCell.h"
#import "YhqTableViewCell.h"
#import "XdLiuTableViewCell.h"
#import "ZjTableViewCell.h"
#import "CustomTextField.h"
#import "PayInfoViewController.h"

@interface QueRxDViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableViews;
    NSMutableArray *_dataArray;     
    NSMutableDictionary *userinfo;
    NSString *cookiestr;
    NSUserDefaults *userDefaults;
     NSInteger intro;
    NSString *strdzid;
    UILabel *lab;
    UIView *viewd;
    NSMutableArray *touArray;
    NSMutableArray *addmoArray;
    NSMutableArray *jiansArray;
    NSMutableArray *yfidArray;
    NSArray  *ModelArray;
    NSInteger  sectionio;
    NSString  *rowio;
    NSString  *stryhid;
    NSString  *stryhje;
    UIView   *allview;
    UIView   *views;
    NSArray  *yflArray;
    UIButton *button;
    UIButton *selectedBtn;
    NSString *cellbutgs;
    NSMutableArray *zjArray;
    NSString *stringzj;
    UIButton *button2;
    NSString *strlol;NSString *strlggid;
    NSMutableArray *quzArray;
    NSMutableArray *straArray;
    NSMutableArray *yhqArray;NSMutableArray *fapgsArray;NSMutableArray *fapgrArray;NSMutableArray *store_idArray;NSMutableArray *fap_idArray;NSMutableArray *textfArray;NSMutableArray *fapdbArray;NSMutableArray *liuyanArray;NSMutableArray *gonsliuyanArray;NSMutableArray *gonsArray;
    NSString *stryfqz;
    NSString *stryhq; NSString  *stryhqid;NSString  *stryhqdb;NSString  *strliuyan;NSString  *strgsliuyan;NSString  *strjiant;
    NSMutableArray *zjjiaArray;
    float zj;
}
@property(nonatomic,strong)NSString  *order_id;
 @property (nonatomic, strong)UITextField *uitextbab;
@property (nonatomic, strong) NSString *fee_names;
@property (nonatomic, strong) NSString *fee_prices;
@end

@implementation QueRxDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"确认订单";

    userDefaults= [NSUserDefaults standardUserDefaults];
    cookiestr=[userDefaults objectForKey:Cookiestr];
    zjArray=[NSMutableArray arrayWithCapacity:0];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentTextFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
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
    touArray=[NSMutableArray arrayWithCapacity:0];
    jiansArray=[NSMutableArray arrayWithCapacity:0];
    yfidArray=[NSMutableArray arrayWithCapacity:0];
    quzArray=[NSMutableArray arrayWithCapacity:0];
    yhqArray=[NSMutableArray arrayWithCapacity:0];
    fapgsArray=[NSMutableArray arrayWithCapacity:0];
    fapgrArray=[NSMutableArray arrayWithCapacity:0];
    zjjiaArray=[NSMutableArray arrayWithCapacity:0];
    liuyanArray=[NSMutableArray arrayWithCapacity:0];
    fap_idArray=[NSMutableArray arrayWithCapacity:0];
    gonsliuyanArray=[NSMutableArray arrayWithCapacity:0];
    gonsArray=[NSMutableArray arrayWithCapacity:0];
    fapdbArray=[NSMutableArray arrayWithCapacity:0];straArray=[NSMutableArray arrayWithCapacity:0];
    addmoArray=[NSMutableArray array];
    store_idArray=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<_Cmodarry.count; i++) {
        NSString *strsp=[NSString stringWithFormat:@"%@",[[_Cmodarry objectAtIndex:i] objectForKey:@"store_name"] ];
         NSString *store_id=[NSString stringWithFormat:@"%@",[[_Cmodarry objectAtIndex:i] objectForKey:@"store_id"] ];
        [store_idArray addObject:store_id];
        [touArray addObject:strsp];
        NSString *strzj=[NSString stringWithFormat:@"%@",[[_Cmodarry objectAtIndex:i] objectForKey:@"total_price"] ];
        NSString *strjs=[NSString stringWithFormat:@"%@",[[_Cmodarry objectAtIndex:i] objectForKey:@"count"] ];
        NSString *stryf=[NSString stringWithFormat:@"%@",[[_Cmodarry objectAtIndex:i] objectForKey:@"storeCart_id"] ];
        stryfqz=@"请选择";
        stryhq=@"0";
        stryhid=@"";
        stryhqdb=@"0";
        strliuyan=@"";
        strgsliuyan=@"";
        rowio=@"0";
        strlggid=@"";
        [straArray addObject:strlggid];
        [gonsArray addObject:rowio];
        [gonsliuyanArray addObject:strgsliuyan];
        [liuyanArray addObject:strliuyan];
        [fapdbArray addObject:stryhqdb];
        [fap_idArray addObject:stryhid];
        NSString *gs=@"yy_select_disabled";
        NSString *gr=@"yy_select_selected";
        [fapgrArray addObject:gr];
        [fapgsArray addObject:gs];
        [yhqArray addObject:stryhq];
        [zjjiaArray addObject:strzj];
        [quzArray addObject:stryfqz];
        [yfidArray addObject:stryf];
        [jiansArray addObject:strjs];
        [addmoArray addObject:strzj];
     
    }

    for(int i=0;i<addmoArray.count;i++)
    {
        zj=[addmoArray[i] floatValue];
        for(int j=0;j<i;j++)
        {
            zj=zj+ [addmoArray[j] floatValue];
            
        }
    }
    NSString *strurlpl=[NSString stringWithFormat:@"%@getAddressList.htm?currentPage=1&Cookie=%@",URLds,cookiestr];
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSString *statusCode=[data objectForKey:@"statusCode"];
        if ([statusCode containsString:@"200"]) {
            NSArray *arry=[DiZhiModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"list"]] ;
            if (intro !=0) {
                _dataArray=[NSMutableArray arrayWithCapacity:0];
                
                [_dataArray addObject:arry[intro]];
            }else{
                 intro=0;
                _dataArray=[NSMutableArray arrayWithCapacity:0];
               
                [_dataArray addObject:arry[intro]];
            }
//
//            [self countPrice];
            viewd =[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height-110, Screen_Width,47)];
            
            lab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/1.5-10, 47)];
            lab.textAlignment = NSTextAlignmentRight;
            //实现某段字符串显示不一样的颜色
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:  ¥%.2f",zj]];
            NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].length);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:redRangeTwo2];
            [lab setAttributedText:noteStr2];
         
            [viewd addSubview:lab];
            UIButton *butdh=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.5, 0, Screen_Width/3, 47)];
            [butdh setTitle:@"提交订单" forState:UIControlStateNormal];
            [butdh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [butdh addTarget:self action:@selector(butdhClick) forControlEvents:UIControlEventTouchUpInside];
            butdh.backgroundColor=[UIColor orangeColor];
            [viewd addSubview:butdh];
            
            [self.view addSubview:viewd];
            
            [tableViews reloadData];
        }else{
    
        
        }
       
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
    
    
}

- (void)initTableView {
    
    tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-110) style:UITableViewStyleGrouped];
    tableViews.delegate = self;
    tableViews.dataSource = self;
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([DdAddressTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Onecell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([QuerSpTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Twocell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([YunfeiTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"yunfcell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([YhqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"yhqcell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([KaiJfpTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"fpcell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([XdLiuTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"xdliucell"];
    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([ZjTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"zjcell"];
//    [tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([DhJlTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Onecell"];
    tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableViews];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }else{
      UIView *viewgg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 45)];
        viewgg.backgroundColor=[UIColor whiteColor];
        UIImageView *imgsptx=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 35, 35)];
        imgsptx.image=[UIImage imageNamed:@"默认图片"];
        
        UILabel *labsp=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, Screen_Width-45, 45)];
        labsp.textColor=[UIColor blackColor];
        labsp.font=[UIFont systemFontOfSize:15.0f];
        labsp.text=[NSString stringWithFormat:@"%@",touArray[section-1]];
        labsp.textAlignment = NSTextAlignmentLeft;
         [viewgg addSubview:imgsptx];
        [viewgg addSubview:labsp];
        return  viewgg;
    
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
    
        UIImageView *viewimg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 10)];
        viewimg.image=[UIImage imageNamed:@"分线"];
        return viewimg;
        
    }else{
      
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else
    {
    
        return 0;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return   0.00001;
    }else{
        
       return   45;
    }
    
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return touArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else{
         ModelArray=[QuerRSpModel mj_objectArrayWithKeyValuesArray:[[_Cmodarry objectAtIndex:section-1] objectForKey:@"gcs"]];
        return ModelArray.count+5;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }else{
          ModelArray=[QuerRSpModel mj_objectArrayWithKeyValuesArray:[[_Cmodarry objectAtIndex:indexPath.section-1] objectForKey:@"gcs"]];
        if (indexPath.row<ModelArray.count) {
        return  110;
        }else{
            return 44;
        }
    }
  
  
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
            DiZhiModel *DiZhiMo=_dataArray[indexPath.row];
            DdAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Onecell"];
            cell.DiZhiM=_dataArray[indexPath.row];
            strdzid=[NSString stringWithFormat:@"%@",DiZhiMo.id];
       
             return cell;
    } else{

         ModelArray=[QuerRSpModel mj_objectArrayWithKeyValuesArray:[[_Cmodarry objectAtIndex:indexPath.section-1] objectForKey:@"gcs"]];
        if (indexPath.row==ModelArray.count) {
           YunfeiTableViewCell *cellc= [tableView dequeueReusableCellWithIdentifier:@"yunfcell"];
        
            cellc.labyf.text=[NSString stringWithFormat:@"%@",quzArray[indexPath.section-1]];
        
            return cellc;
        }else if (indexPath.row==ModelArray.count+1) {
            YhqTableViewCell *celld = [tableView dequeueReusableCellWithIdentifier:@"yhqcell"];
             celld.labyhq.text=[NSString stringWithFormat:@"%@",yhqArray[indexPath.section-1]];
            return celld;
        
        }
        else if (indexPath.row==ModelArray.count+2) {
           
            KaiJfpTableViewCell *celle = [tableView dequeueReusableCellWithIdentifier:@"fpcell"];
            [celle.butgr setImage:[UIImage imageNamed:fapgrArray[indexPath.section-1]] forState:UIControlStateNormal];
            [celle.butgs setImage:[UIImage imageNamed:fapgsArray[indexPath.section-1]] forState:UIControlStateNormal];
            celle.labgs.text=gonsliuyanArray[indexPath.section-1];
            celle.addTogsBlock= ^(KaiJfpTableViewCell *cellgs) {
                stryhqdb=@"1";
                strjiant=@"1";
                rowio=[NSString stringWithFormat:@"%ld", indexPath.section];
              [gonsArray replaceObjectAtIndex:indexPath.section-1 withObject:rowio];

                views= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height)];
                views.backgroundColor = [UIColor blackColor];
                views.alpha=0.5;
                UIWindow *window = [[UIApplication sharedApplication].windows lastObject];

                [window addSubview:views];
              
                allview= [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/3.5, Screen_Width,150)];
                allview.backgroundColor=[UIColor whiteColor];
                UILabel *labtb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 45)];
                
                labtb.backgroundColor = [UIColor orangeColor];
                labtb.text=@"请输入公司名称";
                labtb.textColor=[UIColor whiteColor];
                labtb.textAlignment = NSTextAlignmentCenter;
                [allview addSubview:labtb];
                _uitextbab= [[UITextField alloc]initWithFrame:CGRectMake(10, 55, Screen_Width-20,40)];
                _uitextbab.backgroundColor = [UIColor whiteColor];
                _uitextbab.font = [UIFont systemFontOfSize:14.f];
                _uitextbab.textColor = [UIColor blackColor];
                _uitextbab.textAlignment = NSTextAlignmentLeft;
                _uitextbab.layer.borderColor= RGBColor(238, 238, 238).CGColor;
                _uitextbab.placeholder = @" 必填,公司发票必须填公司名称";
                _uitextbab.layer.borderWidth= 1.0f;
                 button=[[UIButton alloc]initWithFrame:CGRectMake(0, 110, Screen_Width, 40)];
                [button setBackgroundColor:[UIColor orangeColor]];
                [button setTitle:@"确  认" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 [button addTarget:self action:@selector(buttonleClick) forControlEvents:UIControlEventTouchUpInside];
                [allview addSubview:button];
                [allview addSubview:_uitextbab];
                [window addSubview:allview];
                [fapdbArray replaceObjectAtIndex:indexPath.section-1 withObject:stryhqdb];
                [fapgsArray replaceObjectAtIndex:indexPath.section-1 withObject:@"yy_select_selected"];
                [fapgrArray replaceObjectAtIndex:indexPath.section-1 withObject:@"yy_select_disabled"];
                [tableView reloadData];
            };
            celle.addToGerenBlock= ^(KaiJfpTableViewCell *cellgs) {

                stryhqdb=@"0";
                rowio=@"0";
                [gonsliuyanArray replaceObjectAtIndex:indexPath.section-1 withObject:@""];
                [gonsArray replaceObjectAtIndex:indexPath.section-1 withObject:rowio];
                [fapdbArray replaceObjectAtIndex:indexPath.section-1 withObject:stryhqdb];
                 NSLog(@"2ba==%@",fapdbArray);
                [fapgsArray replaceObjectAtIndex:indexPath.section-1 withObject:@"yy_select_disabled"];
                [fapgrArray replaceObjectAtIndex:indexPath.section-1 withObject:@"yy_select_selected"];
                [tableView reloadData];
            };
            return celle;
            
        }  else if (indexPath.row==ModelArray.count+3) {
            
              textfArray=[NSMutableArray arrayWithCapacity:0];
            XdLiuTableViewCell *cellf = [tableView dequeueReusableCellWithIdentifier:@"xdliucell"];
            cellf.contentTextField.text=liuyanArray[indexPath.section-1];
            
            sectionio=indexPath.section-1;
            return cellf;
        } else if (indexPath.row==ModelArray.count+4) {
            ZjTableViewCell *cellh = [tableView dequeueReusableCellWithIdentifier:@"zjcell"];
            NSString *strjg=[NSString stringWithFormat:@" ¥%@",addmoArray[indexPath.section-1]];
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"小计: %@",strjg]];
            NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@" %@",strjg]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@" %@",strjg]].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo];
           [cellh.labprice setAttributedText:noteStr];
            NSString *strjian=[NSString stringWithFormat:@" %@ ",jiansArray[indexPath.section-1]];
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共计 %@ 件",strjian]];
            NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" %@ ",strjian]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" %@ ",strjian]].length);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo2];
            
           
              [cellh.labcount setAttributedText:noteStr2];
            return cellh;
            
        }else{
            QuerSpTableViewCell *cellb = [tableView dequeueReusableCellWithIdentifier:@"Twocell"];
            cellb.QuerRSpM=ModelArray[indexPath.row];
            cellb.backgroundColor=RGBColor(238, 238, 238);
            [cellb setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cellb;
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sectionio=indexPath.section-1;
    
    if (indexPath.section==0) {
        DiZhiViewController *DiZhiVi=[[DiZhiViewController alloc]init];
        //block回调
        DiZhiVi.ceellBackBlock = ^(NSInteger  introw){
            
            intro=introw;
            [self lodadate2];
        };
        [self.navigationController pushViewController:DiZhiVi animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
        ModelArray=[QuerRSpModel mj_objectArrayWithKeyValuesArray:[[_Cmodarry objectAtIndex:indexPath.section-1] objectForKey:@"gcs"]];
        if (indexPath.row==ModelArray.count) {
         
            DiZhiModel *DiZhiMo=_dataArray[0];
            
            
            NSLog(@"%@================%@",_dataArray,DiZhiMo.areaId);
            NSString *strurlpl=[NSString stringWithFormat:@"%@ship_fee.htm?storeCart_id=%@&area_id=%@",URLds,yfidArray[indexPath.section-1],DiZhiMo.areaId];
            [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {

                yflArray=[yfmodel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
                views= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height)];
                views.backgroundColor = [UIColor blackColor];
                views.alpha=0.5;
                UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
                [views addGestureRecognizer:singleTap];
                [window addSubview:views];
                
                allview= [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/2, Screen_Width,Screen_height/2)];
                allview.backgroundColor=[UIColor whiteColor];
                UILabel *labtb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 45)];
                
                labtb.backgroundColor = [UIColor orangeColor];
                labtb.text=@"配送方式";
                labtb.textColor=[UIColor whiteColor];
                labtb.textAlignment = NSTextAlignmentCenter;
                [allview addSubview:labtb];
                [window addSubview:allview];
             
                for (int i =0; i<yflArray.count;i++) {
                    int page=i/2;
                    int crp=i%2;
                    yfmodel *yfmo=yflArray[i];
                    button=[[UIButton alloc]init];
                    
                    button.frame = CGRectMake(page*(120+30)+30, crp*(50)+60,120, 35);
                    [button setFont:[UIFont systemFontOfSize:13.0f]];
                    [button.layer setMasksToBounds:YES];
                    button.tag =i+1;
                    
                    [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
                    [button.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
                    [button.layer setBorderWidth:1.0]; //边框宽度
                    [button.layer setBorderColor:[UIColor orangeColor].CGColor];//边框颜色
                    button.backgroundColor=[UIColor  whiteColor];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [button setTitle:[NSString stringWithFormat:@"%@   运费:%@",yfmo.fee_name,yfmo.fee_price] forState:UIControlStateNormal];
                    //默认选中第一个
                    if (button.tag==1) {
                        yfmodel *yfmo=yflArray[0];
                        _fee_names=yfmo.fee_name;
                        _fee_prices=yfmo.fee_price;
                        button.backgroundColor = [UIColor orangeColor];
                        stryfqz=[NSString stringWithFormat:@"%@  %@",_fee_names,_fee_prices];
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [quzArray replaceObjectAtIndex:sectionio withObject:stryfqz];
                        selectedBtn=button;
                    }else{
                        button.backgroundColor = [UIColor whiteColor];
                    }
                    [allview addSubview:button];
                    
                    
                    
                }
                NSArray *arrti=@[@"取消",@"确认"];
                for (int i =0; i<arrti.count;i++) {
                    button2=[[UIButton alloc]init];
                    button2.frame = CGRectMake(i*(Screen_Width/1.99+1), allview.frame.size.height-40,Screen_Width/1.99, 40);
                    [button2 setFont:[UIFont systemFontOfSize:14.0f]];
                    [button2.layer setMasksToBounds:YES];
                    button2.tag =  i+1;
                    button2.backgroundColor=[UIColor orangeColor];
                    [button2 addTarget:self action:@selector(button2handleClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [button2 setTitle:[NSString stringWithFormat:@"%@",arrti[i]] forState:UIControlStateNormal];
                    [allview addSubview:button2];
                    
                }
                [tableViews reloadData];
        
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"失败!!"];
            }];
        }
        else if (indexPath.row==ModelArray.count+1) {
            
            if (_Cyhqarry.count!=0) {
                CouponViewController *CouponVi=[[CouponViewController alloc]init];
                CouponVi.Cyhqtwoarry=_Cyhqarry;
                CouponVi.strprice =zjjiaArray[indexPath.section-1];
                CouponVi.straarray=straArray;
                //block回调
                CouponVi.ceBackBlock = ^(NSString  *intrid,NSString *strbb,NSString *stra){
//                    [straArray addObject:stra];
                     [straArray replaceObjectAtIndex:sectionio withObject:stra];
                    NSLog(@"%@",straArray);
                    stryhid=intrid;
                    stryhje=strbb;
                    NSLog(@"this is %@====%@",intrid,strbb);
                    stryhq=[NSString stringWithFormat:@"抵扣 %@",stryhje];
                    [yhqArray replaceObjectAtIndex:sectionio withObject:stryhq];
                    float zjjian=[zjjiaArray[sectionio] floatValue]+ [_fee_prices floatValue]-[stryhje floatValue];
                    NSLog(@"%@===%d",zjjiaArray[sectionio],[stryhje intValue]);
                    NSString *strzjia=[NSString stringWithFormat:@"%.2f",zjjian];
                    [fap_idArray replaceObjectAtIndex:sectionio withObject:stryhid];
                    [addmoArray replaceObjectAtIndex:sectionio withObject:strzjia];
                    lab.text=nil;
                    //重新计算总价
                    for(int i=0;i<addmoArray.count;i++)
                    {
                        zj=[addmoArray[i] floatValue];
                        for(int j=0;j<i;j++)
                        {
                            zj=zj+ [addmoArray[j] floatValue];
                            
                        }
                        
                    }
                    //实现某段字符串显示不一样的颜色
                    NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:  ¥%.2f",zj]];
                    NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].length);
                    [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:redRangeTwo2];
                    [lab setAttributedText:noteStr2];
                    [tableViews reloadData];
                };
                
                //block回调
                [self.navigationController pushViewController:CouponVi animated:NO];
                self.navigationController.navigationBarHidden=NO;
                self.tabBarController.tabBar.hidden=YES;
                
            }else{
            
            [SVProgressHUD showErrorWithStatus:@"暂无优惠券!"];
            }

            }
            
        
    }
 
}
-(void)butdhClick{
   
    
    BOOL isbool = [quzArray containsObject:@"请选择"];
    if (isbool==0) {
        NSString *strysfs;
        NSString *stryf;
   
        NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
        NSString *strzjs=[NSString stringWithFormat:@"%2f",zj];
        NSMutableDictionary *dictionary = [[NSMutableDictionary
                                            alloc] init];
        [dictionary setValue:strdzid forKey:@"addr_id"];
        [dictionary setValue:strzjs forKey:@"total_price"];
        [dictionary setValue:_cart_session forKey:@"cart_session"];
         [dictionary setValue:_goods_id forKey:@"goods_id"];
        for (int i=0; i<touArray.count; i++) {
            NSArray *array = [quzArray[i] componentsSeparatedByString:@"  "]; //从字符A中分隔成2个元素的数组
            strysfs=[NSString stringWithFormat:@"%@",array[0]];
            stryf=[NSString stringWithFormat:@"%@",array[1]];
            
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary
                                                alloc] init];
            [dictionary setValue:store_idArray[i] forKey:@"store_id"];
            [dictionary setValue:fapdbArray[i] forKey:@"invoice_type"];
            [dictionary setValue:fap_idArray[i] forKey:@"coupon_id"];
            [dictionary setValue:gonsliuyanArray[i] forKey:@"invoice"];
            [dictionary setValue:strysfs forKey:@"transport"];
            [dictionary setValue:stryf forKey:@"ship_price"];
            [dictionary setValue:zjjiaArray[i] forKey:@"price"];
            [dictionary setValue:liuyanArray[i] forKey:@"msg"];
            
            [arry addObject:dictionary];
        }
        
        [dictionary setValue:arry
                      forKey:@"data"];
        NSData *data=[NSJSONSerialization
                      dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted
                      error:nil];
        NSString *jsonStr=[[[NSString
                             alloc]initWithData:data
                            encoding:NSUTF8StringEncoding]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *strurlpl=[NSString stringWithFormat:@"http://192.168.1.223:8081/shopping/api/confirm_order.htm?data=%@",jsonStr];
        NSLog(@"%@",strurlpl);
        [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
          _order_id=[NSString stringWithFormat:@"%@",[data objectForKey:@"order_id"]];
           
            PayInfoViewController *PayInfoVi=[[PayInfoViewController alloc]init];
            
            PayInfoVi.TOId=_order_id;
            PayInfoVi.pandz=@"q";
            PayInfoVi.jiage=[NSString stringWithFormat:@"%.2f",zj];
            
            //block回调
            [self.navigationController pushViewController:PayInfoVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            [tableViews reloadData];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择运费！！"];
        
    }
}

-(void)handleSingleTap{
    
    [views removeFromSuperview];
    [allview removeFromSuperview];
    
}
- (void)button2handleClick:(UIButton *)buttonClick{
    
    if (buttonClick.tag == 1) {
        
      
        yfmodel *yfmo=yflArray[0];
        _fee_names=[NSString stringWithFormat:@"%@",yfmo.fee_name];
        _fee_prices=[NSString stringWithFormat:@"%@",yfmo.fee_price];
        [views removeFromSuperview];
        [allview removeFromSuperview];
        [tableViews reloadData];
   
    }
    else if (buttonClick.tag == 2) {
        [views removeFromSuperview];
        [allview removeFromSuperview];
         [quzArray replaceObjectAtIndex:sectionio withObject:stryfqz];
        float zjjian=[zjjiaArray[sectionio] floatValue]+[_fee_prices floatValue]-[stryhje floatValue];
        NSLog(@"%@===%d",zjjiaArray[sectionio],[stryhje intValue]);
        NSString *strzjia=[NSString stringWithFormat:@"%.2f",zjjian];
        
        [addmoArray replaceObjectAtIndex:sectionio withObject:strzjia];
        NSLog(@"%@",addmoArray);
//        lab.text=nil;
        //重新计算总价
        for(int i=0;i<addmoArray.count;i++)
        {
            zj=[addmoArray[i] floatValue];
            for(int j=0;j<i;j++)
            {
                zj=zj+ [addmoArray[j] floatValue];
                
            }
            
        }
        //实现某段字符串显示不一样的颜色
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:  ¥%.2f",zj]];
        NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@" ¥%.2f",zj]].length);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:redRangeTwo2];
        [lab setAttributedText:noteStr2];

        [tableViews reloadData];
    }
    
}
#pragma mark - private method
- (void)contentTextFieldDidEndEditing:(NSNotification *)noti
{
   
    if (_uitextbab==noti.object) {
         NSLog(@"%@",_uitextbab);
    }else{
    CustomTextField *textField = noti.object;
    strliuyan=textField.text;
    [liuyanArray replaceObjectAtIndex:sectionio withObject:strliuyan];
    [tableViews reloadData];
    }
}
-(void)buttonleClick{
    if (_uitextbab.text.length!=0) {
        [gonsliuyanArray replaceObjectAtIndex:[rowio integerValue]-1 withObject:_uitextbab.text];
        NSLog(@"%@",gonsliuyanArray);
        [tableViews reloadData];
        [views removeFromSuperview];
        [allview removeFromSuperview];
    }else{
     [SVProgressHUD showErrorWithStatus:@"开公司发票这是必填项！！"];
    
    }
    
   
}
- (void)handleClick:(UIButton *)btn{
    
    NSLog(@"点击了%ld",btn.tag);
    //选中变红色 其他按钮变为白色
    if (selectedBtn) {
        selectedBtn.backgroundColor = [UIColor whiteColor];
         [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    selectedBtn = btn;
    [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectedBtn.backgroundColor = [UIColor orangeColor];
    yfmodel *yfmo=yflArray[selectedBtn.tag-1];
 
    _fee_names=[NSString stringWithFormat:@"%@",yfmo.fee_name];
    _fee_prices=[NSString stringWithFormat:@"%@",yfmo.fee_price];
    stryfqz=[NSString stringWithFormat:@"%@  %@",_fee_names,_fee_prices];
}
@end
