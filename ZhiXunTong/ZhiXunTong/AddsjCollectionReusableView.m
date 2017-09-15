//
//  TJheaderCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddsjCollectionReusableView.h"
#import "PchHeader.h"
#import "WSDatePickerView.h"
#import "Selestview.h"
@interface AddsjCollectionReusableView () <UITextViewDelegate>{
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    UILabel *_placeholderLabel;
    UILabel *lablx;
    UIButton *butdata;
    NSString *date2;
    NSString *strcookie;
  
}
@property (strong ,nonatomic) UIButton *duiwai;
@property (strong ,nonatomic) UIButton *duiwaino;
@property (strong ,nonatomic)UIView *duiwaiview;
@property (strong ,nonatomic)UIView *duiwainoview;
@property (strong,nonatomic)UIButton * tmpBtn;

@end
@implementation AddsjCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        strcookie=[userDefaults objectForKey:Cookie];
NSArray *titles=@[@"标        题:",@"事件类型 :",@"事件等级 :",@"事件来源 :",@"重点督办 :",@"内        容:"];
        for (int i=0; i<titles.count; i++) {
            //        NSInteger index = i %5;
            NSInteger page = i/1;
            UILabel *labfeil=[[UILabel alloc]init];
            labfeil.text=titles[i];
            labfeil.frame= CGRectMake(15, page * (50)+10, Screen_Width/4.3, 30);
            labfeil.tag = i+1;
            labfeil.font=[UIFont systemFontOfSize:13.0f];
            labfeil.textAlignment = UITextAlignmentCenter;
            [self addSubview:labfeil];
            
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width/4.3+15,  10, Screen_Width/1.5,30)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(238, 238, 238).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [self addSubview:_textFile];
        
        NSArray *butArray=@[@"请选择类型",@"请选择等级",@"请选择来源"];
        for (int i=0; i<butArray.count; i++) {
            NSInteger page = i/1;
            UIButton *butanniu=[[UIButton alloc]init];
            [butanniu setTitle:[NSString stringWithFormat:@"%@",butArray[i]] forState:UIControlStateNormal];
            butanniu.frame= CGRectMake(Screen_Width/4.3+15,page * (50)+60, Screen_Width/1.5,30);
            butanniu.tag = i+1;
           [butanniu.layer setBorderWidth:1.0];   //边框宽度
              [butanniu.layer setBorderColor:RGBColor(220, 220, 220).CGColor];//边框颜色
            [butanniu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            butanniu.font=[UIFont systemFontOfSize:13.0f];
            [butanniu addTarget:self action:@selector(butxialaClick:) forControlEvents:UIControlEventTouchUpInside];
         
            [self addSubview:butanniu];
            
        }
        _zdid=@"0";
        _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4+15,205, Screen_Width/4, 40)];
        [_duiwai.layer setMasksToBounds:YES];
        //      _but.font=[UIFont systemFontOfSize:13];
        [_duiwai setTitle:@"是" forState:UIControlStateNormal];
        [_duiwai setFont:[UIFont systemFontOfSize:13]];
        [_duiwai.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_duiwai addTarget:self action:@selector(duiyesyuan) forControlEvents:UIControlEventTouchUpInside];
        
        [_duiwai setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _duiwaiview=[[UIView alloc]initWithFrame:CGRectMake(5, 14, 14, 14)];
        _duiwaiview.backgroundColor=[UIColor whiteColor];
        [_duiwaiview.layer setCornerRadius:7.0]; //设置矩形四个圆角半径
        //边框宽度
        [_duiwaiview.layer setBorderWidth:1.0];
        _duiwaiview.layer.borderColor=[UIColor redColor].CGColor;
        [_duiwai addSubview:_duiwaiview];
        
        
        _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.7+15, 205, Screen_Width/4, 40)];
        [_duiwaino.layer setMasksToBounds:YES];
        [_duiwaino setTitle:@"否" forState:UIControlStateNormal];
        [_duiwaino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_duiwaino setFont:[UIFont systemFontOfSize:13]];
        
        _duiwainoview=[[UIView alloc]initWithFrame:CGRectMake(5, 14, 14, 14)];
        _duiwainoview.backgroundColor=[UIColor redColor];
        [_duiwainoview.layer setCornerRadius:7.0]; //设置矩形四个圆角半径
        //边框宽度
        [_duiwainoview.layer setBorderWidth:1.0];
        _duiwainoview.layer.borderColor=[UIColor redColor].CGColor;
        [_duiwaino.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        
        [_duiwaino addSubview:_duiwainoview];
     
        [_duiwaino addTarget:self action:@selector(duinoyuan) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_duiwaino];
        [self addSubview:_duiwai];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(Screen_Width/4.3+15,260, Screen_Width/1.5, 100)];
        [self addSubview:self.textView];
        self.textView.delegate = self;
        //设置文本
        //    self.textView.text = @"我是UITextView，大家欢迎使用。";
        //设置文字对齐方式属性
        self.textView.textAlignment = NSTextAlignmentLeft;
        //设置文字对齐方
        //设置文字颜色属性
        self.textView.textColor = [UIColor blackColor];
        //设置文字字体属性
        self.textView.font = [UIFont systemFontOfSize:12.0f];
        //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
        self.textView.editable = YES;
        //设置圆角、边框属性
        self.textView.layer.cornerRadius = 2.0f;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor =[UIColor grayColor].CGColor;
        //模仿UTextField的placeholder属性
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.textView.frame), 20)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.text = @"请输入内容";
        _placeholderLabel.font = self.textView.font;
        [self.textView addSubview:_placeholderLabel];
    }
    return self;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑。");
    _placeholderLabel.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"结束编辑。");
    
    //模仿UTextField的placeholder属性
    if (self.textView.text.length == 0) {
        _placeholderLabel.text = @"请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
}
-(void)butdate{
    
    
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        date2= [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        //            strbegin=[[NSString stringWithFormat:@"%@",date]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //            NSLog(@"时间： %@",date);
        [butdata setTitle:date2 forState:UIControlStateNormal];
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
}

-(void)duinoyuan{
    _zdid=@"0";
    _duiwaiview.backgroundColor=[UIColor whiteColor];
    _duiwainoview.backgroundColor=[UIColor redColor];
//    Visible=@"0";
    
}
-(void)duiyesyuan{
    _zdid=@"1";
    _duiwaiview.backgroundColor=[UIColor redColor];
    _duiwainoview.backgroundColor=[UIColor whiteColor];
//    Visible=@"1";
}
//点击按钮方法,这里容易犯错
-(void)butxialaClick:(UIButton *)sender{
    if (sender.tag==1) {
        //           strtypeid=[NSString stringWithFormat:@"%ld",selectIndex];
        NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/getAllEventType.do?Cookie=%@",strcookie];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"data========%@",data);
            NSArray *titles=[data objectForKey:@"data"];
            [SelectAlert showWithTitle:@"事件类型" titles:titles selectIndex:^(NSInteger selectIndex) {
//                lxid=selectIndex;
                
               _lxid = [NSString stringWithFormat:@"%ld",selectIndex];
        
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                [sender setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
                
            } showCloseButton:NO];
            
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
        
    }else if(sender.tag==2){
        NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/getAllEventLevel.do?Cookie=%@",strcookie];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"data========%@",data);
            NSArray *titles=[data objectForKey:@"data"];
            [SelectAlert showWithTitle:@"事件等级" titles:titles selectIndex:^(NSInteger selectIndex) {
        
               _djid = [NSString stringWithFormat:@"%ld",selectIndex];
                
          
                //                NSString *s = [NSString stringWithFormat:@"%ld",selectIndex];
                //
                //                strtypeid= [s intValue];
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                [sender setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
                
            } showCloseButton:NO];
            
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
    }else if(sender.tag==3){
        NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/event/getAllEventSourceType.do?Cookie=%@",strcookie];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"data========%@",data);
            NSArray *titles=[data objectForKey:@"data"];
            [SelectAlert showWithTitle:@"事件来源" titles:titles selectIndex:^(NSInteger selectIndex) {
                _lyid= [NSString stringWithFormat:@"%ld",selectIndex];
                
               
                
                
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                [sender setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
                
            } showCloseButton:NO];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];    }
    
}


@end
