//
//  ShuJIViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/6/30.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ShuJIViewController.h"
#import "LMJDropdownMenu.h"
#import "PchHeader.h"
#import "WebClient.h"
#import "FDAlertView.h"
#import "RBCustomDatePickerView.h"
@interface ShuJIViewController ()<UITextViewDelegate,LMJDropdownMenuDelegate>
{
    UILabel *_placeholderLabel;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    NSString *username;
    UIView *viewshuji;
    UIButton *butyzm;
    NSString *Visible;
    NSString *sms;
    NSString *leixid;
    
}
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;
@property (strong ,nonatomic)UITextView *textView;
@property (strong ,nonatomic) UIButton *butdata;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenu;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenutwo;

@property (strong ,nonatomic) UIButton *duiwai;
@property (strong ,nonatomic) UIButton *duiwaino;

@property (strong ,nonatomic)UIView *duiwaiview;
@property (strong ,nonatomic)UIView *duiwainoview;
@end

@implementation ShuJIViewController
//书记信箱
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
 
    username=[[arry objectAtIndex:0] objectForKey:@"userName"];
    self.navigationItem.title=@"书记信箱";
    [self daohangView];
    [self initshuji];
    // Do any additional setup after loading the view.
}
-(void)initshuji{
    //创建背景uiview
    leixid=@"1";
   viewshuji=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    NSArray *arrayone=@[@"姓 名:",@"电 话:",@"事 项:",@"接收人:",@"时 间:",@"标 题:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewshuji addSubview:labzhum];
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewshuji addSubview:_textFile];
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [viewshuji addSubview:_textFile1];
    [[WebClient sharedClient] Docket:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,110,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"Docket";
        _dropdownMenu.delegate = self;
        [viewshuji addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] Secretary:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error)  {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,155,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Secretary";
        _dropdownMenutwo.delegate = self;
        [viewshuji addSubview:_dropdownMenutwo];
    }];
    _butdata=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,200,Screen_Width/1.6, 35)];
    [_butdata.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
//    [_butdata setTitle:@"请选择时间" forState:UIControlStateNormal];
    [_butdata setFont:[UIFont systemFontOfSize:14.0f]];
    [_butdata.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    _butdata.layer.borderColor= RGBColor(230, 233, 233).CGColor;
  
    _butdata.layer.borderWidth= 1.0f;
    [_butdata addTarget:self action:@selector(butdatayuan) forControlEvents:UIControlEventTouchUpInside];
    [_butdata setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [viewshuji addSubview:_butdata];
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 245, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入标题";
    _textFile2.layer.borderWidth= 1.0f;
    
    [viewshuji addSubview:_textFile2];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 290, Screen_Width-20, 70)];
    [viewshuji addSubview:self.textView];
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
    
    [self.view addSubview:viewshuji];
    
    _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,375, Screen_Width/3.5, 25)];
    [_duiwai.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_duiwai setTitle:@"实名写信" forState:UIControlStateNormal];
    [_duiwai setFont:[UIFont systemFontOfSize:13]];
    [_duiwai.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_duiwai addTarget:self action:@selector(duiwaiyuan) forControlEvents:UIControlEventTouchUpInside];
    [_duiwai setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _duiwaiview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwaiview.backgroundColor=[UIColor redColor];
    [_duiwaiview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwaiview.layer setBorderWidth:1.0];
    _duiwaiview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwai addSubview:_duiwaiview];
    
    
    _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.8, 375, Screen_Width/3.2, 25)];
    [_duiwaino.layer setMasksToBounds:YES];
    [_duiwaino setTitle:@"匿名写信" forState:UIControlStateNormal];
    [_duiwaino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_duiwaino setFont:[UIFont systemFontOfSize:13]];
    _duiwainoview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwainoview.backgroundColor=[UIColor whiteColor];
    [_duiwainoview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwainoview.layer setBorderWidth:1.0];
    _duiwainoview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwaino.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    
    [_duiwaino addSubview:_duiwainoview];
    [_duiwaino addTarget:self action:@selector(duiwainonoyuan) forControlEvents:UIControlEventTouchUpInside];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(80,Screen_height-Screen_height/3.85, Screen_Width-160, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaowqyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewshuji addSubview:buttjiao];
    [viewshuji addSubview:_duiwaino];
    [viewshuji addSubview:_duiwai];


}
-(void)duiwaiyuan{
    leixid=@"1";
      [viewshuji removeFromSuperview];
    //创建背景uiview
   viewshuji=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    NSArray *arrayone=@[@"姓 名:",@"电 话:",@"事 项:",@"接收人:",@"时 间:",@"标 题:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewshuji addSubview:labzhum];
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewshuji addSubview:_textFile];
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [viewshuji addSubview:_textFile1];
    [[WebClient sharedClient] Docket:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,110,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"Docket";
        _dropdownMenu.delegate = self;
        [viewshuji addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] Secretary:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error)  {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,155,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Secretary";
        _dropdownMenutwo.delegate = self;
        [viewshuji addSubview:_dropdownMenutwo];
    }];
    _butdata=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,200,Screen_Width/1.6, 35)];
    [_butdata.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
//    [_butdata setTitle:@"请选择时间" forState:UIControlStateNormal];
    [_butdata setFont:[UIFont systemFontOfSize:14.0f]];
    [_butdata.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    _butdata.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    
    _butdata.layer.borderWidth= 1.0f;
    [_butdata addTarget:self action:@selector(butdatayuan) forControlEvents:UIControlEventTouchUpInside];
    [_butdata setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [viewshuji addSubview:_butdata];
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 245, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入标题";
    _textFile2.layer.borderWidth= 1.0f;
    
    [viewshuji addSubview:_textFile2];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 290, Screen_Width-20, 70)];
    [viewshuji addSubview:self.textView];
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
    _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,375, Screen_Width/3.5, 25)];
    [_duiwai.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_duiwai setTitle:@"实名写信" forState:UIControlStateNormal];
    [_duiwai setFont:[UIFont systemFontOfSize:13]];
    [_duiwai.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_duiwai addTarget:self action:@selector(duiwaiyuan) forControlEvents:UIControlEventTouchUpInside];
    [_duiwai setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _duiwaiview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwaiview.backgroundColor=[UIColor redColor];
    [_duiwaiview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwaiview.layer setBorderWidth:1.0];
    _duiwaiview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwai addSubview:_duiwaiview];
    
    
    _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.8, 375, Screen_Width/3.2, 25)];
    [_duiwaino.layer setMasksToBounds:YES];
    [_duiwaino setTitle:@"匿名写信" forState:UIControlStateNormal];
    [_duiwaino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_duiwaino setFont:[UIFont systemFontOfSize:13]];
    _duiwainoview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwainoview.backgroundColor=[UIColor whiteColor];
    [_duiwainoview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwainoview.layer setBorderWidth:1.0];
    _duiwainoview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwaino.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    
    [_duiwaino addSubview:_duiwainoview];
    [_duiwaino addTarget:self action:@selector(duiwainonoyuan) forControlEvents:UIControlEventTouchUpInside];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(80,Screen_height-Screen_height/3.85, Screen_Width-160, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaowqyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewshuji addSubview:buttjiao];
    [viewshuji addSubview:_duiwaino];
    [viewshuji addSubview:_duiwai];

    [self.view addSubview:viewshuji];
    
    
   }
-(void)duiwainonoyuan{
   leixid=@"0";
     [viewshuji removeFromSuperview];
       viewshuji=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    NSArray *arrayone=@[@"事 项:",@"接收人:",@"时 间:",@"标 题:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewshuji addSubview:labzhum];
    }
    [[WebClient sharedClient] Docket:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,20,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"Docket";
        _dropdownMenu.delegate = self;
        [viewshuji addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] Secretary:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error)  {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,65,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Secretary";
        _dropdownMenutwo.delegate = self;
        [viewshuji addSubview:_dropdownMenutwo];
    }];
    _butdata=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,110,Screen_Width/1.6, 35)];
    [_butdata.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
//    [_butdata setTitle:@"请选择时间" forState:UIControlStateNormal];
    [_butdata setFont:[UIFont systemFontOfSize:14.0f]];
    [_butdata.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    _butdata.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    
    _butdata.layer.borderWidth= 1.0f;
    [_butdata addTarget:self action:@selector(butdatayuan) forControlEvents:UIControlEventTouchUpInside];
    [_butdata setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [viewshuji addSubview:_butdata];
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 155, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入标题";
    _textFile2.layer.borderWidth= 1.0f;
    
    [viewshuji addSubview:_textFile2];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 200, Screen_Width-20, 70)];
    [viewshuji addSubview:self.textView];
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
    _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10,375, Screen_Width/3.5, 25)];
    [_duiwai.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_duiwai setTitle:@"实名写信" forState:UIControlStateNormal];
    [_duiwai setFont:[UIFont systemFontOfSize:13]];
    [_duiwai.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_duiwai addTarget:self action:@selector(duiwaiyuan) forControlEvents:UIControlEventTouchUpInside];
    [_duiwai setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _duiwaiview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwaiview.backgroundColor=[UIColor whiteColor];
    [_duiwaiview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwaiview.layer setBorderWidth:1.0];
    _duiwaiview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwai addSubview:_duiwaiview];
    
    
    _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.8, 375, Screen_Width/3.2, 25)];
    [_duiwaino.layer setMasksToBounds:YES];
    [_duiwaino setTitle:@"匿名写信" forState:UIControlStateNormal];
    [_duiwaino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_duiwaino setFont:[UIFont systemFontOfSize:13]];
    _duiwainoview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwainoview.backgroundColor=[UIColor redColor];
    [_duiwainoview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwainoview.layer setBorderWidth:1.0];
    _duiwainoview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwaino.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    
    [_duiwaino addSubview:_duiwainoview];
    [_duiwaino addTarget:self action:@selector(duiwainonoyuan) forControlEvents:UIControlEventTouchUpInside];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(80,Screen_height-Screen_height/3.85, Screen_Width-160, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaowqyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewshuji addSubview:buttjiao];
    [viewshuji addSubview:_duiwaino];
    [viewshuji addSubview:_duiwai];

    [self.view addSubview:viewshuji];

}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"书记信箱";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)buttjiaowqyuan{
    NSString *strbut=[NSString stringWithFormat:@"%@",[_butdata currentTitle]];
    NSLog(@"%@-%@--%@--%@--%@--%@--%@--%@-%@-%@-%@",ddtvinfo,ddkey,leixid,_dropdownMenu.ContentM.id,_textFile2.text,_textFile1.text,_textFile.text,_textView.text,strbut,Deptid,_dropdownMenutwo.SJtypeM.id);
    
      if ([leixid containsString:@"1"]) {
    if (_textFile1.text.length < 11)
    {
        [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:_textFile1.text];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:_textFile1.text];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:_textFile1.text];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            if (_dropdownMenu.ContentM.id.length!=0 && _dropdownMenutwo.SJtypeM.id.length!=0 && _textFile1.text.length!=0 &&_textFile2.text.length!=0 ) {
                [[WebClient sharedClient] Mailbox:ddtvinfo Keys:ddkey genre:leixid docketid:_dropdownMenu.ContentM.id title:_textFile2.text phone:_textFile1.text Name:_textFile.text content:_textView.text time:strbut Deptid:Deptid secretaryid:_dropdownMenutwo.SJtypeM.id ResponseBlock:^(id resultObject, NSError *error) {
                    NSLog(@"resultObject成功=%@",resultObject);
                }];
            }else{
            
             [SVProgressHUD showErrorWithStatus:@"你给的信息有误"];
            }
          
        }else{
            [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
        }
        
    }

      }else{
        
              if (_dropdownMenu.ContentM.id.length!=0 && _dropdownMenutwo.SJtypeM.id.length!=0) {
                  [[WebClient sharedClient] Mailbox:ddtvinfo Keys:ddkey genre:leixid docketid:_dropdownMenu.ContentM.id title:_textFile2.text phone:@"" Name:@"" content:_textView.text time:strbut Deptid:Deptid secretaryid:_dropdownMenutwo.SJtypeM.id ResponseBlock:^(id resultObject, NSError *error) {
                      NSLog(@"resultObject成功=%@",resultObject);
                  }];
              }else{
                  
                  [SVProgressHUD showErrorWithStatus:@"你给的信息有误"];
              }

      
      }
}

-(void)butdatayuan{
    FDAlertView *alert = [[FDAlertView alloc] init];
    RBCustomDatePickerView * contentView=[[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height/1.8)];
    contentView.delegate=self;
    alert.contentView = contentView;
    [alert show];
}

#pragma mark - JGPickerViewDelegate -
-(void)getTimeToValue:(NSString *)theTimeStr
{
    
    [_butdata setTitle:theTimeStr forState:UIControlStateNormal];
    //                NSLog(@"开始时间选择了:%@",date);
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
//**监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
