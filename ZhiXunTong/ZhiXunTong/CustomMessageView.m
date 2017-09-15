//
//  CustomMessageView.m
//  AlterMessageDemo
//
//  Created by dev on 2017/4/20.
//  Copyright © 2017年 nys. All rights reserved.
//

#import "CustomMessageView.h"
#import "FDAlertView.h"
#import "UIColor+ChangeColor.h"


#define SELFHEIGHT    7




@implementation CustomMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}


-(void)initView
{
    
    self.clipsToBounds=YES;
    self.layer.cornerRadius=6;
    self.backgroundColor=[UIColor HexString:@"ffffff"];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 35)];
    
    self.titleLab.layer.borderColor = [[UIColor grayColor]CGColor];
    self.titleLab.layer.borderWidth = 0.5f;
    self.titleLab.layer.masksToBounds = YES;
    
    self.titleLab.text=@"确认收货";
    self.titleLab.textColor=[UIColor orangeColor];
    self.titleLab.font=[UIFont systemFontOfSize:17];
    self.titleLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.titleLab];
    
    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 35+SELFHEIGHT, self.frame.size.width-25, 35)];
    self.contentLab.textColor=[UIColor HexString:@"666666"];
    self.contentLab.font=[UIFont systemFontOfSize:12];
    self.contentLab.textAlignment=NSTextAlignmentCenter;
    self.contentLab.numberOfLines=0;
    [self addSubview:self.contentLab];
    
    
    self.twoLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 65+SELFHEIGHT, self.frame.size.width-20, 35)];
    self.twoLab.textColor=[UIColor HexString:@"666666"];
    self.twoLab.font=[UIFont systemFontOfSize:12];
    self.twoLab.textAlignment=NSTextAlignmentLeft;
    self.twoLab.numberOfLines=0;
 
    [self addSubview:self.twoLab];
    
    

    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame=CGRectMake(0, 130, (self.frame.size.width-1)/2.0, 40);
    [self.cancelBtn setTitle:@"取消" forState:normal];
    self.cancelBtn.backgroundColor=[UIColor clearColor];
    [self.cancelBtn setTitleColor:[UIColor HexString:@"666666"] forState:normal];
    self.cancelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    
    UILabel * line2Lab=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-1)/2.0, 120+SELFHEIGHT+3.5, 1, 40)];
    line2Lab.backgroundColor=[UIColor HexString:@"eeeeee"];
    [self addSubview:line2Lab];
    
    
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.frame=CGRectMake((self.frame.size.width-1)/2.0+1, 130, (self.frame.size.width-1)/2.0, 40);
    [self.submitBtn setTitle:@"确认" forState:normal];
    self.submitBtn.backgroundColor=[UIColor clearColor];
    [self.submitBtn setTitleColor:[UIColor HexString:@"666666"] forState:normal];
    self.submitBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.submitBtn addTarget:self action:@selector(submitBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.submitBtn];
    
    
    
}



#pragma mark- 取消事件
-(void)cancelBtnEvent
{
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}
#pragma mark-确认事件
-(void)submitBtnEvent
{
    
    if ( [self.delegate respondsToSelector:@selector(getTimeToValue:)])
    {
        [self.delegate getTimeToValue:@"babab"];
        
    }
    
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
    
}
#pragma mark-获取验证码
-(void)getTheCodeFromSER
{
    
    [self openCountdown];
}

-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //[self.authCodeBtn setTitleColor:[UIColor HexString:@"FB8557"] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.authCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                //[self.authCodeBtn setTitleColor:[UIColor HexString:@"979797"] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
