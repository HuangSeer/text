//
//  CancelOrderViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/10.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "CancelOrderViewController.h"
#import "PchHeader.h"
@interface CancelOrderViewController (){
    BOOL Lg;
    NSString *state_info;
    NSString *other_state_info;
}

@end

@implementation CancelOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"取消订单";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    _lab_Dan.text=[NSString stringWithFormat:@"订单号:%@",_ordId];
    _btn_view.userInteractionEnabled=YES;
    _btn_view1.userInteractionEnabled=YES;
    _btn_view2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    [_btn_view addGestureRecognizer:tapGesture];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo1)];
    [_btn_view1 addGestureRecognizer:tapGesture1];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo2)];
    [_btn_view2 addGestureRecognizer:tapGesture2];
    _TextView.hidden=YES;
    Lg=NO;

}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)Actiondo
{
    Lg=YES;
    _img_01.image=[UIImage imageNamed:@"checked_checkbox@2x"];
    _img_02.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    _img_03.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    NSLog(@"1111");
    state_info=@"改买其他商品";
    other_state_info=@"";
    _TextView.hidden=YES;
}
-(void)Actiondo1
{
    Lg=YES;
    NSLog(@"2222");
    _img_01.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    _img_02.image=[UIImage imageNamed:@"checked_checkbox@2x"];
    _img_03.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    _TextView.hidden=YES;
    state_info=@"从其他商铺购买";
    other_state_info=@"";
}
-(void)Actiondo2
{
    Lg=YES;
    NSLog(@"33333");
    _img_01.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    _img_02.image=[UIImage imageNamed:@"unchecked_checkbox@2x"];
    _img_03.image=[UIImage imageNamed:@"checked_checkbox@2x"];
    _TextView.hidden=NO;
    state_info=@"other";
    other_state_info=[NSString stringWithFormat:@"%@",_TextView.text];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tijiao_btn:(id)sender {
   
    if (Lg==YES) {
        NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order_cancel_save.htm?id=%@&state_info=%@&other_state_info=%@",DsURL,_ordId,state_info,other_state_info];
        NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:hString success:^(id data) {
            NSLog(@"post====%@",data);
            NSString *msg=[data objectForKey:@"msg"];
            NSString *code=[data objectForKey:@"statusCode"];
            int aa=[code intValue];
            if (aa==200) {
                [SVProgressHUD showSuccessWithStatus:msg];
            }
            [SVProgressHUD showErrorWithStatus:msg];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }
}
@end
