//
//  SQTuiHuoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SQTuiHuoViewController.h"
#import "PchHeader.h"
@interface SQTuiHuoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    UITextView *textView;
    UILabel *lable1;
}

@end

@implementation SQTuiHuoViewController
//申请退货
- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohang];
  //  NSLog(@"_Tid%@/n_Ttime%@ /n_Ttitle%@ _Tjia%@ _Timg%@ ,",_Tid,_Ttime,_Ttitle,_Tjia,_Timg);
}
-(void)btnCkmore
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)daohang{
    self.navigationItem.title=@"申请退货";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 120;
    }else if(indexPath.section==1){
        return 260;
    }else{
        return 80;
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (indexPath.section==0) {
        UILabel *lab_dingdan=[[UILabel alloc] initWithFrame:CGRectMake(10, 0,Screen_Width, 22)];
        lab_dingdan.text=[NSString stringWithFormat:@"订单编号:%@",_Tid];
        lab_dingdan.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_dingdan];
        UILabel *lab_xiadan=[[UILabel alloc] initWithFrame:CGRectMake(10, 22,Screen_Width, 22)];
        lab_xiadan.text=[NSString stringWithFormat:@"下单时间:%@",_Ttime];
        lab_xiadan.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_xiadan];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(10, 44, Screen_Width-20, 1)];
        view.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:view];
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 52, 50, 50)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_Timg] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        [cell.contentView addSubview:imgView];
        
        UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(80, 43,Screen_Width-90, 22)];
        name.text=[NSString stringWithFormat:@"%@",_Ttitle];
        name.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:name];
        
        UILabel *lcont=[[UILabel alloc] initWithFrame:CGRectMake(80, 62,Screen_Width, 22)];
        lcont.text=[NSString stringWithFormat:@"数量：%@",_Tshu];
        lcont.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lcont];
        
        UILabel *jiage=[[UILabel alloc] initWithFrame:CGRectMake(80, 84,Screen_Width, 22)];
        jiage.text=[NSString stringWithFormat:@"￥%@",_Tjia];
        jiage.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:jiage];
        
        UIView *diView=[[UIView alloc] initWithFrame:CGRectMake(0, 110, Screen_Width, 10)];
        diView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:diView];
    }
    else if(indexPath.section==1)
    {
        UILabel *lab_xiadan=[[UILabel alloc] initWithFrame:CGRectMake(10, 5,Screen_Width, 30)];
        lab_xiadan.text=[NSString stringWithFormat:@"申请原因"];
        lab_xiadan.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab_xiadan];
        
        textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 35, Screen_Width-20, 140)];
        textView.delegate=self;
        [textView.layer setCornerRadius:5];
        
        lable1=[[UILabel alloc] initWithFrame:CGRectMake(3, 4, 136, 20)];
        lable1.text=@"请填写...";
        lable1.font=[UIFont systemFontOfSize:13];
        lable1.enabled=NO;
        [textView addSubview:lable1];
        
        textView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:textView];
        
        UILabel *lab_tuihui=[[UILabel alloc] initWithFrame:CGRectMake(10, 180,Screen_Width/2-20, 30)];
        lab_tuihui.text=[NSString stringWithFormat:@"商品退回方式"];
        lab_tuihui.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab_tuihui];
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 215, Screen_Width, 1)];
        view.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:view];
        
        UILabel *lab_xq=[[UILabel alloc] initWithFrame:CGRectMake(10, 213,Screen_Width-20, 40)];
        lab_xq.text=[NSString stringWithFormat:@"商品寄回地址在审核通过后以短信的形式告知,或在申请记录中查询."];
        lab_xq.numberOfLines = 2;
        lab_xq.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lab_xq];
        
        UIView *diView=[[UIView alloc] initWithFrame:CGRectMake(0, 250, Screen_Width, 10)];
        diView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:diView];
    }else{
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake(Screen_Width/2-90, 30, 180, 30);
        denglu.backgroundColor = RGBColor(66, 142, 12);
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"提交" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        denglu.tag=202;
        [denglu addTarget:self action:@selector(BtnTijiao) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
    }
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 120, Screen_Width, 10)];
//    view.backgroundColor=[UIColor grayColor];
//    [cell.contentView addSubview:view];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)BtnTijiao
{
    NSLog(@"提交");
    if (textView.text.length>0)
    {
        [SVProgressHUD showWithStatus:@"加载中"];
        NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order_return_apply_save.htm?id=%@&return_content=%@",DsURL,_TOId,textView.text];
        NSString *encodedValue = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:encodedValue success:^(id data) {
            NSLog(@"post====%@",data);
            NSString *ss=[data objectForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:ss];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请填写退回原因"];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    //self
    if ([textView.text length]==0) {
        [lable1 setHidden:NO];
    } else {
        [lable1 setHidden:YES];
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
