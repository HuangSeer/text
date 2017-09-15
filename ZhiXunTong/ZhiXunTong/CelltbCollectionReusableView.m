
//
//  CelltbCollectionReusableView.m
//  LeBao
//
//  Created by 小黄人 on 2017/4/19.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import "CelltbCollectionReusableView.h"
#import "LMJDropdownMenu.h"
#import "WebClient.h"
#import "PchHeader.h"
//帮助类
//#define Screen_Width  [UIScreen mainScreen].bounds.size.width
//#define Screen_height  [UIScreen mainScreen].bounds.size.height
#define  RGBColor(x,y,z)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
@interface CelltbCollectionReusableView () <LMJDropdownMenuDelegate>


@end
@implementation CelltbCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
   
        //选择的lable
        UILabel *labxz=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, Screen_Width/4, 25)];
        labxz.text=@"选择托管类型";
        labxz.font=[UIFont systemFontOfSize:13];
       _idstr=@"1";
      _but=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4+30, 10, Screen_Width/3.5, 25)];
        [_but.layer setMasksToBounds:YES];
//      _but.font=[UIFont systemFontOfSize:13];
        [_but setFont:[UIFont systemFontOfSize:13]];
        [_but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        //边框宽度
        [_but.layer setBorderWidth:1.0];
             [_but addTarget:self action:@selector(butyuan) forControlEvents:UIControlEventTouchUpInside];
        [_but.layer setBorderColor:[UIColor whiteColor].CGColor];
           [_but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _butview=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 14, 14)];
        _butview.backgroundColor=[UIColor redColor];
        [_butview.layer setCornerRadius:7.0]; //设置矩形四个圆角半径
        //边框宽度
        [_butview.layer setBorderWidth:1.0];
        _butview.layer.borderColor=[UIColor redColor].CGColor;
        [_but addSubview:_butview];
        

        _butche=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.5, 10, Screen_Width/3.5, 25)];
        [_butche.layer setMasksToBounds:YES];
        [_butche setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           [_butche setFont:[UIFont systemFontOfSize:13]];
        _butcheview=[[UIView alloc]initWithFrame:CGRectMake(5, 5, 14, 14)];
        _butcheview.backgroundColor=[UIColor whiteColor];
        [_butcheview.layer setCornerRadius:7.0]; //设置矩形四个圆角半径
        //边框宽度
        [_butcheview.layer setBorderWidth:1.0];
         _butcheview.layer.borderColor=[UIColor redColor].CGColor;
        [_butche.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_butche addSubview:_butcheview];
        //边框宽度
        [_butche.layer setBorderWidth:1.0];
        [_butche addTarget:self action:@selector(butcheyuan) forControlEvents:UIControlEventTouchUpInside];
        [_butche.layer setBorderColor:[UIColor whiteColor].CGColor];
        _viewqh=[[UIView alloc]initWithFrame:CGRectMake(0, 35, Screen_Width, Screen_height-35)];
        [[WebClient sharedClient] ResponleixseBlock:^(id resultObject, NSError *error) {
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            _typeArray=[[resultObject objectForKey:@"Data" ] valueForKey:@"type"];
            [_but setTitle:[NSString stringWithFormat:@"%@",_typeArray[0]] forState:UIControlStateNormal];
             [_butche setTitle:[NSString stringWithFormat:@"%@",_typeArray[1]] forState:UIControlStateNormal];
            
            NSLog(@"_typeArray%@",_typeArray[0]);
            
        }];
        [self addSubview:_viewqh];
        NSArray *titles=@[@"面           积 :",@"月    租   金 :",@"服   务    费 :",@"户           型 :"];
        //    NSArray *textArray = @[@"red",@"orange",@"purple",@"pink",@"dark gray",@"light gray"];
        for (int i=0; i<titles.count; i++) {
            //        NSInteger index = i %5;
            NSInteger page = i/1;
            UILabel *labfeil=[[UILabel alloc]init];
            labfeil.text=titles[i];
            labfeil.frame= CGRectMake(15, page * (30)+20, Screen_Width/4.3, 25);
            labfeil.tag = i+1;
            labfeil.font=[UIFont systemFontOfSize:13.0f];
           labfeil.textAlignment = UITextAlignmentCenter;
            [_viewqh addSubview:labfeil];
            
                  }

        //循环创建可输入的UITextField
        _xhtextf=[[UITextField alloc]init];
        _xhtextf.frame= CGRectMake(20+Screen_Width/4.3, 20, Screen_Width/2, 25);
        _xhtextf.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        
        _xhtextf.layer.borderWidth= 1.0f;
        _xhtextf.font=[UIFont systemFontOfSize:14.0f];
        _xhtextf.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _xhtextf.returnKeyType = UIReturnKeyDone;
//        _xhtextf.tag = i+1;
        _xhtextf.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        [_viewqh addSubview:_xhtextf];
        
        _xhtextf1=[[UITextField alloc]init];
        _xhtextf1.frame= CGRectMake(20+Screen_Width/4.3,50, Screen_Width/2, 25);
        _xhtextf1.keyboardType = UIKeyboardTypeDecimalPad;
        _xhtextf1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        
        _xhtextf1.layer.borderWidth= 1.0f;
        _xhtextf1.font=[UIFont systemFontOfSize:14.0f];
        _xhtextf1.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _xhtextf1.returnKeyType = UIReturnKeyDone;
  
        _xhtextf1.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        [_viewqh addSubview:_xhtextf1];
        
        _xhtextf2=[[UITextField alloc]init];
        
        _xhtextf2.frame= CGRectMake(20+Screen_Width/4.3,80, Screen_Width/2, 25);
        _xhtextf2.keyboardType = UIKeyboardTypeDecimalPad;
        _xhtextf2.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        
        _xhtextf2.layer.borderWidth= 1.0f;
        _xhtextf2.font=[UIFont systemFontOfSize:14.0f];
        _xhtextf2.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _xhtextf2.returnKeyType = UIReturnKeyDone;
        
        _xhtextf2.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        [_viewqh addSubview:_xhtextf2];
        [[WebClient sharedClient] ResponhouseseBlock:^(id resultObject, NSError *error) {
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            NSInteger page =(titles.count-1)/1;
             _dropdownMenu= [[LMJDropdownMenu alloc] init];
          
            NSLog(@"_idtwo_idtwo_idtwo_idtwo%@",_idtwo);
            [_dropdownMenu setFrame:CGRectMake(20+Screen_Width/4.3, page * (30)+20, Screen_Width/2, 25)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
                 NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            _dropdownMenu.delegate = self;
            [_viewqh addSubview:_dropdownMenu];
        }];

        UILabel *labdz=[[UILabel alloc]initWithFrame:CGRectMake(15,  Screen_height/3.78, Screen_Width-20, 25)];
        labdz.text=@"大致描述 :";
        labdz.font=[UIFont systemFontOfSize:13.0f];
        //输入框
        _textView= [[UITextView alloc]initWithFrame:CGRectMake(12,  Screen_height/3.2, Screen_Width-24 ,Screen_height/5.4)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        
        _textView.layer.borderWidth= 1.0f;
        
        
        UIView *viewxian2=[[UIView alloc]initWithFrame:CGRectMake(10,Screen_height/2.5, Screen_Width-20, 0.5)];
        viewxian2.backgroundColor=RGBColor(197, 199, 199);
        
        [_viewqh addSubview:viewxian2];
        [_viewqh addSubview:_textView];
        [_viewqh addSubview:labdz];


        
        [self addSubview:_but];
        [self addSubview:_butche];
        [self addSubview:labxz];
        

    
    }
    return self;
    }
-(void)butyuan{
    _butcheview.backgroundColor=[UIColor whiteColor];
    _butview.backgroundColor=[UIColor redColor];
    _idstr=@"1";
    [_viewqh removeFromSuperview];
    _viewqh=[[UIView alloc]initWithFrame:CGRectMake(0, 35, Screen_Width, Screen_height-35)];
    [self addSubview:_viewqh];
    NSArray *titles=@[@"面           积 :",@"月    租   金 :",@"服   务    费 :",@"户           型 :"];
    //    NSArray *textArray = @[@"red",@"orange",@"purple",@"pink",@"dark gray",@"light gray"];
    for (int i=0; i<titles.count; i++) {
        //        NSInteger index = i %5;
        NSInteger page = i/1;
        UILabel *labfeil=[[UILabel alloc]init];
        labfeil.text=titles[i];
        labfeil.frame= CGRectMake(15, page * (30)+20, Screen_Width/4.3, 25);
        labfeil.tag = i+1;
        labfeil.font=[UIFont systemFontOfSize:13.0f];
        labfeil.textAlignment = UITextAlignmentCenter;
        [_viewqh addSubview:labfeil];
        
    }
    
    //循环创建可输入的UITextField
    _xhtextf=[[UITextField alloc]init];
    _xhtextf.frame= CGRectMake(20+Screen_Width/4.3, 20, Screen_Width/2, 25);
    _xhtextf.layer.borderColor=RGBColor(230, 233, 233).CGColor;
    
    _xhtextf.layer.borderWidth= 1.0f;
    _xhtextf.font=[UIFont systemFontOfSize:14.0f];
    _xhtextf.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _xhtextf.returnKeyType = UIReturnKeyDone;
    //        _xhtextf.tag = i+1;
    _xhtextf.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [_viewqh addSubview:_xhtextf];
    
    _xhtextf1=[[UITextField alloc]init];
    _xhtextf1.frame= CGRectMake(20+Screen_Width/4.3,50, Screen_Width/2, 25);
    _xhtextf1.keyboardType = UIKeyboardTypeDecimalPad;
    _xhtextf1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
    
    _xhtextf1.layer.borderWidth= 1.0f;
    _xhtextf1.font=[UIFont systemFontOfSize:14.0f];
    _xhtextf1.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _xhtextf1.returnKeyType = UIReturnKeyDone;
    
    _xhtextf1.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [_viewqh addSubview:_xhtextf1];
    
    _xhtextf2=[[UITextField alloc]init];
    
    _xhtextf2.frame= CGRectMake(20+Screen_Width/4.3,80, Screen_Width/2, 25);
    _xhtextf2.keyboardType = UIKeyboardTypeDecimalPad;
    _xhtextf2.layer.borderColor=RGBColor(230, 233, 233).CGColor;
    
    _xhtextf2.layer.borderWidth= 1.0f;
    _xhtextf2.font=[UIFont systemFontOfSize:14.0f];
    _xhtextf2.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _xhtextf2.returnKeyType = UIReturnKeyDone;
    
    _xhtextf2.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [_viewqh addSubview:_xhtextf2];
    [[WebClient sharedClient] ResponhouseseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        NSInteger page =(titles.count-1)/1;
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        
        NSLog(@"_idtwo_idtwo_idtwo_idtwo%@",_idtwo);
        [_dropdownMenu setFrame:CGRectMake(20+Screen_Width/4.3, page * (30)+20, Screen_Width/2, 25)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        _dropdownMenu.delegate = self;
        [_viewqh addSubview:_dropdownMenu];
    }];
    
    UILabel *labdz=[[UILabel alloc]initWithFrame:CGRectMake(15,  Screen_height/3.78, Screen_Width-20, 25)];
    labdz.text=@"大致描述 :";
    labdz.font=[UIFont systemFontOfSize:13.0f];
    //输入框
    _textView= [[UITextView alloc]initWithFrame:CGRectMake(12,  Screen_height/3.2, Screen_Width-24 ,Screen_height/5.4)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    
    _textView.layer.borderWidth= 1.0f;
    
    
    UIView *viewxian2=[[UIView alloc]initWithFrame:CGRectMake(10,Screen_height/2.5, Screen_Width-20, 0.5)];
    viewxian2.backgroundColor=RGBColor(197, 199, 199);
    
    [_viewqh addSubview:viewxian2];
    [_viewqh addSubview:_textView];
    [_viewqh addSubview:labdz];

}
-(void)butcheyuan{
      _butview.backgroundColor=[UIColor whiteColor];
    _butcheview.backgroundColor=[UIColor redColor];
  _idstr=@"3";
    [_viewqh removeFromSuperview];
    _viewqh=[[UIView alloc]initWithFrame:CGRectMake(0, 35, Screen_Width, Screen_height-35)];
    [self addSubview:_viewqh];
    NSArray *titles=@[@"月    租   金 :",@"服   务    费 :"];
    //    NSArray *textArray = @[@"red",@"orange",@"purple",@"pink",@"dark gray",@"light gray"];
    for (int i=0; i<titles.count; i++) {
        //        NSInteger index = i %5;
        NSInteger page = i/1;
        UILabel *labfeil=[[UILabel alloc]init];
        labfeil.text=titles[i];
        labfeil.frame= CGRectMake(15, page * (30)+20, Screen_Width/4.3, 25);
        labfeil.tag = i+1;
        labfeil.font=[UIFont systemFontOfSize:13.0f];
        [_viewqh addSubview:labfeil];
        
    }
    _xhtextf3=[[UITextField alloc]init];
    _xhtextf3.frame= CGRectMake(20+Screen_Width/4.3,20, Screen_Width/2, 25);
    _xhtextf3.keyboardType = UIKeyboardTypeDecimalPad;
    _xhtextf3.layer.borderColor=RGBColor(230, 233, 233).CGColor;
    
    _xhtextf3.layer.borderWidth= 1.0f;
    _xhtextf3.font=[UIFont systemFontOfSize:14.0f];
    _xhtextf3.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _xhtextf3.returnKeyType = UIReturnKeyDone;
    
    _xhtextf3.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [_viewqh addSubview:_xhtextf3];
    
    _xhtextf4=[[UITextField alloc]init];
    _xhtextf4.frame= CGRectMake(20+Screen_Width/4.3,50, Screen_Width/2, 25);
    _xhtextf4.keyboardType = UIKeyboardTypeDecimalPad;
    _xhtextf4.layer.borderColor=RGBColor(230, 233, 233).CGColor;
    
    _xhtextf4.layer.borderWidth= 1.0f;
    _xhtextf4.font=[UIFont systemFontOfSize:14.0f];
    _xhtextf4.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _xhtextf4.returnKeyType = UIReturnKeyDone;
    
    _xhtextf4.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [_viewqh addSubview:_xhtextf4];
    UILabel *labdz=[[UILabel alloc]initWithFrame:CGRectMake(15,  Screen_height/6.1, Screen_Width-20, 25)];
    labdz.text=@"大致描述 :";
    labdz.font=[UIFont systemFontOfSize:13.0f];
    //输入框
     _textView= [[UITextView alloc]initWithFrame:CGRectMake(12,  Screen_height/4.9, Screen_Width-24 ,Screen_height/5.4)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    
    _textView.layer.borderWidth= 1.0f;
    
    
    UIView *viewxian2=[[UIView alloc]initWithFrame:CGRectMake(10,Screen_height/3.2, Screen_Width-20, 0.5)];
    viewxian2.backgroundColor=RGBColor(197, 199, 199);
    
    [_viewqh addSubview:viewxian2];
    [_viewqh addSubview:_textView];
    [_viewqh addSubview:labdz];
   


}

@end
