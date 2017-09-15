//
//  TJheaderCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TJheaderCollectionReusableView.h"
#import "PchHeader.h"
#import "WSDatePickerView.h"
@interface TJheaderCollectionReusableView () <UITextViewDelegate>{
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    UILabel *_placeholderLabel;
    
    UIButton *butdata;
    NSString *date2;
}
@property (strong,nonatomic)UIButton * tmpBtn;
@property (strong ,nonatomic)UITextField *textFile;
@end
@implementation TJheaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nsarray=[[NSMutableArray alloc]init];
        
        NSArray *titles=@[@"标        题:",@"日志类型 :"];
        for (int i=0; i<titles.count; i++) {
            //        NSInteger index = i %5;
            NSInteger page = i/1;
            UILabel *labfeil=[[UILabel alloc]init];
            labfeil.text=titles[i];
            labfeil.frame= CGRectMake(15, page * (50)+20, Screen_Width/4.3, 30);
            labfeil.tag = i+1;
            labfeil.font=[UIFont systemFontOfSize:13.0f];
            labfeil.textAlignment = UITextAlignmentCenter;
            [self addSubview:labfeil];
            
        }
          NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
    
            _lablx=[[UILabel alloc]initWithFrame:CGRectMake( Screen_Width/4.3+15, 20, Screen_Width- Screen_Width/2.5, 30)];
        _lablx.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        _lablx.font=[UIFont systemFontOfSize:14.0f];
        _lablx.textAlignment = UITextAlignmentCenter;
        _lablx.textColor=[UIColor blackColor];
        [self addSubview:_lablx];
          NSArray *titleslab=@[@"巡查",@"宣传",@"走访",@"处理"];
        for (int i=0; i<titleslab.count; i++) {
            NSInteger page = i/1;
            UIButton *butanniu=[[UIButton alloc]init];
            [butanniu setTitle:[NSString stringWithFormat:@"%@",titleslab[i]] forState:UIControlStateNormal];
            butanniu.frame= CGRectMake(page*(Screen_Width/5.8+1)+Screen_Width/4.3+15,70, Screen_Width/5.8,30);
            butanniu.tag = i+1;
              [butanniu setImage:[UIImage imageNamed:@"za"] forState:UIControlStateNormal];
            [butanniu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            butanniu.font=[UIFont systemFontOfSize:13.0f];
            [butanniu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            //        labfeil.textAlignment = UITextAlignmentCenter;
            [self addSubview:butanniu];
            
        }
        
        
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 130, Screen_Width-20, 100)];
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
- (void)buttonClick:(UIButton *)buttonClick{
    
    NSLog(@"%d",buttonClick.selected);
    buttonClick.selected = !buttonClick.selected;
    
    if(buttonClick.selected) {
        [buttonClick setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
       
        NSString *str=[NSString stringWithFormat:@"%ld",buttonClick.tag];
         NSLog(@"cc=%@",str);
         [_nsarray addObject:str];
        NSLog(@"cc=%@",_nsarray);
    }else {
        NSLog(@"取消选中");
        [buttonClick setImage:[UIImage imageNamed:@"za"] forState:UIControlStateNormal];
         NSString *str=[NSString stringWithFormat:@"%ld",buttonClick.tag];
        [_nsarray removeObject:str];
         NSLog(@"%@",_nsarray);
    }

    
}
@end
