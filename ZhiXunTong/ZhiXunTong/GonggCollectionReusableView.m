//
//  GonggCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/6/29.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GonggCollectionReusableView.h"
#import "LMJDropdownMenu.h"
#import "WebClient.h"
#import "PchHeader.h"
@interface GonggCollectionReusableView () <LMJDropdownMenuDelegate,UITextViewDelegate>{
NSMutableDictionary *userInfo;
NSString *ddtvinfo;
NSString *ddkey;
     UILabel *_placeholderLabel;
}

@end
@implementation GonggCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        userInfo=[userDefaults objectForKey:UserInfo];
        NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
        ddtvinfo=[userInfo objectForKey:@"TVInfoId"];
        ddkey=[userInfo objectForKey:@"Key"];

        NSArray *titles=@[@"紧急程度 :",@"类        别:",@"详        情:"];
        //    NSArray *textArray = @[@"red",@"orange",@"purple",@"pink",@"dark gray",@"light gray"];
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
        [[WebClient sharedClient] ChenDu:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
           
            _dropdownMenu= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu setFrame:CGRectMake(20+Screen_Width/4.3,20, Screen_Width/1.6, 30)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu.strpand=@"level";
            _dropdownMenu.delegate = self;
            [self addSubview:_dropdownMenu];
        }];
        [[WebClient sharedClient] GuZleiX:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
//            NSLog(@"LMJDropdownMenuLMJDropdownMenu===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu1= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu1 setFrame:CGRectMake(20+Screen_Width/4.3,70, Screen_Width/1.6, 30)];
            [_dropdownMenu1 setMenuTitles:muarray rowHeight:30];
            _dropdownMenu1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
//            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu1.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
//            _dropdownMenu.strpand=@"typetwo";
            _dropdownMenu1.delegate = self;
            [self addSubview:_dropdownMenu1];
        }];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20+Screen_Width/4.3, 120, Screen_Width/1.6, 120)];
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
        self.textView.layer.cornerRadius = 6.0f;
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
/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}
@end
