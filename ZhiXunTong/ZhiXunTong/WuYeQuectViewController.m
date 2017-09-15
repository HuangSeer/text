//
//  WuYeQuectViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WuYeQuectViewController.h"
#import "PchHeader.h"
#import "MyQuectHeadr.h"
#import "QuectModel.h"
#import "QuectTableViewCell.h"
@interface WuYeQuectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *QuetTableview;
    MyQuectHeadr *meview;
    
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    
    NSMutableArray *_saveDataArray;
    NSString *NumXiaoji;
    
    NSString *userName;
    NSString *address;
}

@end

@implementation WuYeQuectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    aatvinfo=[userDefaults objectForKey:TVInfoId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
   // aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    userName=[[arry objectAtIndex:0] objectForKey:@"userName"];
    //[self initTable];
    
    [self initShuJu];
}
-(void)daohangView
{
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"物业查询";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)initShuJu{
    [[WebClient sharedClient] ChaUserId:aaid Keys:aakey TVinfo:aatvinfo ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"--------:%@",resultObject);
        _saveDataArray=[[NSMutableArray alloc]initWithArray:[QuectModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSString *ss=[resultObject objectForKey:@"Status"];
        
        int aa=[ss intValue];
        if (aa==1) {
            
            address=[resultObject objectForKey:@"address"];
            NumXiaoji=[resultObject objectForKey:@"sum"];
            [self initTable];
            NSLog(@"%@--%@",address,NumXiaoji);
            //[QuetTableview reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];
}
-(void)initTable{
    meview=[MyQuectHeadr init];
    meview.frame=CGRectMake(0, 0, Screen_Width, 180);
    meview.lable_name.text=userName;
    meview.lable_address.text=[NSString stringWithFormat:@"%@",address];
    QuetTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,self.view.bounds.size.height) style:UITableViewStylePlain];
    QuetTableview.delegate = self;
    QuetTableview.dataSource = self;
    QuetTableview.tableHeaderView=meview;
    QuetTableview.backgroundColor=[UIColor clearColor];
    QuetTableview.showsVerticalScrollIndicator =NO;
    QuetTableview.separatorStyle=UITableViewCellEditingStyleNone;
    [self.view addSubview:QuetTableview];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _saveDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    lable.text=@"物业费小计";
    lable.font=[UIFont systemFontOfSize:13];
    [footerView addSubview:lable];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-110, 0, 100, 40)];
    
    lable1.text=[NSString stringWithFormat:@"%@元",NumXiaoji];

    lable1.textAlignment=NSTextAlignmentRight;
    lable1.font=[UIFont systemFontOfSize:13];
    [footerView addSubview:lable1];
    
    footerView.backgroundColor=RGBColor(236, 236, 236);
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"QuectTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    QuectModel *model=[_saveDataArray objectAtIndex:indexPath.row];
    cell.lable_year.text=[NSString stringWithFormat:@"%@年%@月",model.year,model.month];
    
    cell.lable_paid_id.text=[NSString stringWithFormat:@"%@元",model.paid_in];
    
    //cell.contentView.backgroundColor=[UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
