//
//  WuLiuXQViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/22.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WuLiuXQViewController.h"
#import "PchHeader.h"
#import "WuLiuXQModel.h"
@interface WuLiuXQViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    UIView *meView;
    
    NSMutableDictionary *userinfo;
    NSString *phone;
}

@end

@implementation WuLiuXQViewController
//物流详情
- (void)viewDidLoad {
    [super viewDidLoad];
    [self shuju];
    self.navigationItem.title=@"我的订单";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    
    meView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 160)];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 9, 100, 21)];
    lable.text=@"订单详情";
    [meView addSubview:lable];
    UIView *beijin=[[UIView alloc] initWithFrame:CGRectMake(0, 30, Screen_Width, 100)];
    beijin.backgroundColor=RGBColor(245, 245, 245);
    [meView addSubview:beijin];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 90, 90)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:_img]];
    [meView addSubview:imgView];
    
    UILabel *labTit=[[UILabel alloc] initWithFrame:CGRectMake(105, 35,Screen_Width-115, 50)];
    labTit.text=[NSString stringWithFormat:@"%@",_atitle];
    labTit.numberOfLines=2;
    [meView addSubview:labTit];
    
    UILabel *labCon=[[UILabel alloc] initWithFrame:CGRectMake(105, 80,Screen_Width-115, 25)];
    labCon.text=[NSString stringWithFormat:@"数量:%@",_acont];
    [meView addSubview:labCon];
    
    UILabel *labPir=[[UILabel alloc] initWithFrame:CGRectMake(105, 100,Screen_Width-115, 25)];
    labPir.text=[NSString stringWithFormat:@"￥%@",_ajiage];
    [meView addSubview:labPir];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(10, 130, 100, 21)];
    lable1.text=@"订单跟踪";
    [meView addSubview:lable1];
    
//    meView.hd_title.text=[NSString stringWithFormat:@"%@",_atitle];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-20)];
    [_tableView setTableHeaderView:meView];
    _tableView.rowHeight=75;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator =NO;
    [_tableView setTableFooterView:[UIView new]];
    [self.view addSubview:_tableView];
    
}
-(void)shuju{
    [SVProgressHUD showProgress:0.3 status:@"数据请求中。。。" maskType:SVProgressHUDMaskTypeBlack];
    NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/query_ship.htm?id=%@",DsURL,_oid];
    
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
//        NSLog(@"MoNiLogin===%@",data);
        _saveArray=[[NSMutableArray alloc]initWithArray:[WuLiuXQModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Traces"]]];
        
        [_tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _saveArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    _saveArray=(NSMutableArray *)[[_saveArray reverseObjectEnumerator] allObjects];
    WuLiuXQModel *model=[_saveArray objectAtIndex:indexPath.row];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(40, 3, Screen_Width-60, 21)];
   // UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, scrw, 50)];
    label.text = [NSString stringWithFormat:@"%@",model.AcceptStation];;
    //清空背景颜色
    label.backgroundColor = [UIColor clearColor];
    //文字居中显示
    label.textAlignment = NSTextAlignmentLeft;
    label.font=[UIFont systemFontOfSize:13];
    //自动折行设置
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 3;
    //自适应高度
    CGRect txtFrame = label.frame;
    label.frame = CGRectMake(40, 3, Screen_Width-60,
                             txtFrame.size.height =[label.text boundingRectWithSize:
                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
    label.frame = CGRectMake(40, 3, Screen_Width-60, txtFrame.size.height);
     [cell.contentView addSubview:label];
    
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(40, 50, Screen_Width-60, 25)];
    lable1.text=[NSString stringWithFormat:@"%@",model.AcceptTime];
    lable1.numberOfLines=2;
    lable1.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:lable1];
    
    UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(40, 74.5, Screen_Width, 0.5)];
    xian.backgroundColor=RGBColor(234, 234, 234);
    [cell.contentView addSubview:xian];
    if (indexPath.row==0) {
        UIView *sxView=[[UIView alloc] initWithFrame:CGRectMake(19.5, 15, 1,65)];
        sxView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:sxView];
        //
        CGRect rect = CGRectMake(14, 5, 12, 12);
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
        //先画一个圆
        CAShapeLayer *layer=[CAShapeLayer layer];
        layer.path=beizPath.CGPath;
        layer.fillColor=[UIColor redColor].CGColor;//填充色
        layer.strokeColor=RGBColor(234, 234, 234).CGColor;;//边框颜色
        layer.lineWidth=3.0f;
        layer.lineCap=kCALineCapRound;//线框类型
        [cell.contentView.layer addSublayer:layer];
    }else if (indexPath.row==_saveArray.count-1){
        CGRect rect1 = CGRectMake(14, 5, 12, 12);
        UIBezierPath *beizPath1=[UIBezierPath bezierPathWithRoundedRect:rect1 cornerRadius:50];
        //先画一个圆
        CAShapeLayer *layer1=[CAShapeLayer layer];
        layer1.path=beizPath1.CGPath;
        layer1.fillColor=RGBColor(234, 234, 234).CGColor;//填充色
        layer1.strokeColor=RGBColor(234, 234, 234).CGColor;;//边框颜色
        layer1.lineWidth=0.0f;
        layer1.lineCap=kCALineCapRound;//线框类型
        [cell.contentView.layer addSublayer:layer1];
        
        
        UIView *sxView=[[UIView alloc] initWithFrame:CGRectMake(19.5, 0, 1,65)];
        sxView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:sxView];
        //
        CGRect rect = CGRectMake(14, 56, 12, 12);
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
        //先画一个圆
        CAShapeLayer *layer=[CAShapeLayer layer];
        layer.path=beizPath.CGPath;
        layer.fillColor=RGBColor(234, 234, 234).CGColor;//填充色
        layer.strokeColor=[UIColor clearColor].CGColor;//边框颜色
        layer.lineWidth=0.0f;
        layer.lineCap=kCALineCapRound;//线框类型
        [cell.contentView.layer addSublayer:layer];
    }else{
        UIView *sxView=[[UIView alloc] initWithFrame:CGRectMake(19.5, 0, 1,80)];
        sxView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:sxView];
        //
        CGRect rect = CGRectMake(14, 5, 12, 12);
        UIBezierPath *beizPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:50];
        //先画一个圆
        CAShapeLayer *layer=[CAShapeLayer layer];
        layer.path=beizPath.CGPath;
        layer.fillColor=RGBColor(234, 234, 234).CGColor;//填充色
        layer.strokeColor=[UIColor clearColor].CGColor;;//边框颜色
        layer.lineWidth=0.0f;
        layer.lineCap=kCALineCapRound;//线框类型
        [cell.contentView.layer addSublayer:layer];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
