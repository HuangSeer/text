//
//  PJXiangQingViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/14.
//  Copyright © 2017年 airZX. All rights reserved.
//PJXiangQingViewController

#import "PJXiangQingViewController.h"
#import "TggStarEvaluationView.h"
#import "PchHeader.h"
@interface PJXiangQingViewController ()<UITextViewDelegate>{
    NSUInteger ms;
    NSUInteger fw;
    NSUInteger fh;
    UILabel *lable;
    UILabel *lable1;
    UILabel *lable2;
    UILabel *lable3;
}
@property (weak ,nonatomic) TggStarEvaluationView *tggStarEvaView;
@end

@implementation PJXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我要评价";
    
    _pj_title.text=_PG_name;
    _pj_con.text=[NSString stringWithFormat:@"数量:%@",_PG_count];
    [_pj_img sd_setImageWithURL:[NSURL URLWithString:_PG_img] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    float price=[_pg_price floatValue];
    _pj_price.text=[NSString stringWithFormat:@"￥%0.2f",price];
    TggStarEvaluationView *tggStarEvaView1 = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count){
        NSLog(@"count%ld",count);
        ms=count;
        if (ms==1) {
            lable.text=@"描述相符:非常不满意";
        }else if (ms==2){
            lable.text=@"描述相符:不满意";
        }else if (ms==3){
            lable.text=@"描述相符:一般";
        }
        else if (ms==4){
            lable.text=@"描述相符:满意";
        }
        else if (ms==5){
            lable.text=@"描述相符:非常满意";
        }
    }];
    tggStarEvaView1.spacing =0.08;
    tggStarEvaView1.frame =(CGRect){10,30,(Screen_Width-30)/3*2-30,45};
    [_pj_View addSubview:tggStarEvaView1];
    
    TggStarEvaluationView *tggStarEvaView2 = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count){
        NSLog(@"count%ld",count);
        fw=count;
        if (fw==1) {
            lable1.text=@"服务态度:非常不满意";
        }else if (fw==2){
            lable1.text=@"服务态度:不满意";
        }else if (fw==3){
            lable1.text=@"服务态度:一般";
        }
        else if (fw==4){
            lable1.text=@"服务态度:满意";
        }
        else if (fw==5){
            lable1.text=@"服务态度:非常满意";
        }
    }];
    tggStarEvaView2.spacing =0.08;
    tggStarEvaView2.frame = (CGRect){10,70,(Screen_Width-30)/3*2-30,45};
    [_pj_View addSubview:tggStarEvaView2];
    
    TggStarEvaluationView *tggStarEvaView3 = [TggStarEvaluationView evaluationViewWithChooseStarBlock:^(NSUInteger count){
        NSLog(@"count%ld",count);
        fh=count;
        if (fh==1) {
            lable2.text=@"发货速度:非常不满意";
        }else if (fh==2){
            lable2.text=@"发货速度:不满意";
        }else if (fh==3){
            lable2.text=@"发货速度:一般";
        }
        else if (fh==4){
            lable2.text=@"发货速度:满意";
        }
        else if (fh==5){
            lable2.text=@"发货速度:非常满意";
        }
    }];
    tggStarEvaView3.spacing =0.08;
    tggStarEvaView3.frame = (CGRect){10,110,(Screen_Width-30)/3*2-30,45};
    [_pj_View addSubview:tggStarEvaView3];
    lable=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-30)/3*2-10,30+(45*0),(Screen_Width-30)/3+30, 45)];
    lable.font=[UIFont systemFontOfSize:13];
    lable.text=@"描述相符:";
    [_pj_View addSubview:lable];
    
    lable1=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-30)/3*2-10,30+(45*1),(Screen_Width-30)/3+30, 45)];
    lable1.font=[UIFont systemFontOfSize:13];
    lable1.text=@"服务态度:";
    [_pj_View addSubview:lable1];
    
    lable2=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-30)/3*2-10,30+(45*2),(Screen_Width-30)/3+30, 45)];
    lable2.font=[UIFont systemFontOfSize:13];
    lable2.text=@"发货速度:";
    [_pj_View addSubview:lable2];
    
    _text_View.delegate=self;
//    [list.layer setCornerRadius:5];
    lable3=[[UILabel alloc] initWithFrame:CGRectMake(3, 4, 160, 20)];
    lable3.text=@"评价...";
    lable3.font=[UIFont systemFontOfSize:13];
    lable3.enabled=NO;
    [_text_View addSubview:lable3];
    
    
}
- (IBAction)tijiao_bn:(id)sender {
    NSLog(@"1234567");
    if (_text_View.text.length>0) {
        NSLog(@"提交评价");
        NSString *miaoshu=[NSString stringWithFormat:@"%ld",ms];
        NSString *fuwu=[NSString stringWithFormat:@"%ld",fw];
        NSString *fahuo=[NSString stringWithFormat:@"%ld",fh];
        
        NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/order_evaluate_save.htm?id=%@&goods_id=%@&spec_info=%@&evaluate_info=%@&evaluate_buyer_val=%@&description_evaluate=%@&service_evaluate=%@&ship_evaluate=%@",DsURL,_PG_id,_pg_good_id,@"",@"0",miaoshu,fuwu,fahuo,@""];
        NSString *hString = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [ZQLNetWork getWithUrlString:hString success:^(id data) {
            NSLog(@"post====%@",data);
            NSString *msg=[data objectForKey:@"msg"];
            NSString *code=[data objectForKey:@"statusCode"];
            int aa=[code intValue];
            if (aa==200) {
                [SVProgressHUD showSuccessWithStatus:msg];
            }else{
                [SVProgressHUD showErrorWithStatus:msg];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    //self
    if ([_text_View.text length]==0) {
        [lable3 setHidden:NO];
    } else {
        [lable3 setHidden:YES];
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
