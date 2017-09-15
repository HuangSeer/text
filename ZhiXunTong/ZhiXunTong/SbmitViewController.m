//
//  SbmitViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SbmitViewController.h"
#import "LMJDropdownMenu.h"

#import "PchHeader.h"
@interface SbmitViewController ()<UITextViewDelegate,LMJDropdownMenuDelegate>
{
    UILabel *_placeholderLabel;
    NSMutableDictionary *userInfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
     NSString *Deptid;
     NSString *username;
    UIView *viewbj;
    UIButton *butyzm;
     NSString *Visible;
     NSString *sms;
    NSString *YZM;
   
}
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;
@property (strong ,nonatomic)UITextField *textFile3;
@property (strong ,nonatomic) UIButton *but;
@property (strong ,nonatomic) UIButton *butche;
@property (strong ,nonatomic) UIButton *duiwai;
@property (strong ,nonatomic) UIButton *duiwaino;
@property (strong ,nonatomic)UIView *butview;
@property (strong ,nonatomic)UIView *duiwaiview;
@property (strong ,nonatomic)UIView *duiwainoview;
@property (strong ,nonatomic)UIView *butcheview;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenu;
@property (strong ,nonatomic)UITextView *textView;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenutwo;
@end

@implementation SbmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
   // aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    Deptid=[userDefaults objectForKey:DeptId];
   // username=[[arry objectAtIndex:0] objectForKey:@"userName"];
    self.navigationItem.title=@"诉讼提交";
    [self initShuQiu];
    [self daohangView];
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"诉求提交";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)initShuQiu{
    
     Visible=@"0";
    sms=@"0";
    NSArray *arrayone=@[@"姓名:",@"电话:"];
    viewbj=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    [self.view addSubview:viewbj];
    
    for (int i=0; i<arrayone.count; i++) {
         NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
//        UITextAlignmentCenter
         labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile];
    
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile1];
    
    UIView *viewtis=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10, 105, Screen_Width/3.8, 50)];
       viewtis.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image.jpg"]];
    UILabel *labtsb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewtis.frame.size.width-10, viewtis.frame.size.height-2)];
    labtsb.text=@"若选择手机验证将收到结果回复短信";
    labtsb.textColor=[UIColor grayColor];
    labtsb.font=[UIFont systemFontOfSize:12.0f];
    [labtsb setNumberOfLines:0];
    [viewtis addSubview:labtsb];
    
    
    _but=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2,115, Screen_Width/4, 25)];
    [_but.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_but setTitle:@"手机验证" forState:UIControlStateNormal];
    [_but setFont:[UIFont systemFontOfSize:12.0f]];
    [_but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_but addTarget:self action:@selector(butyuan) forControlEvents:UIControlEventTouchUpInside];
    [_but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _butview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butview.backgroundColor=[UIColor whiteColor];
    [_butview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butview.layer setBorderWidth:1.0];
    _butview.layer.borderColor=[UIColor redColor].CGColor;
    [_but addSubview:_butview];
    
    
    _butche=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.4, 115, Screen_Width/4, 25)];
    [_butche.layer setMasksToBounds:YES];
    [_butche setTitle:@"不验证" forState:UIControlStateNormal];
    [_butche setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_butche setFont:[UIFont systemFontOfSize:12.0f]];
    _butcheview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butcheview.backgroundColor=[UIColor redColor];
    [_butcheview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butcheview.layer setBorderWidth:1.0];
    _butcheview.layer.borderColor=[UIColor redColor].CGColor;
    [_butche.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_butche addSubview:_butcheview];
    
    [viewbj addSubview:_butche];
    [viewbj addSubview:_but];
//    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    [viewbj addSubview:viewtis];
    
    NSArray *arraytwo=@[@"类型:",@"部门:",@"标题:"];
    for (int i=0; i<arraytwo.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+150, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arraytwo
        [i];
        //        UITextAlignmentCenter
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
       [[WebClient sharedClient] suqiuWT:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,150,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"OpinionClassId";
        _dropdownMenu.delegate = self;
        [viewbj addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] suqiubmen:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,195,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Deptid";
        _dropdownMenutwo.delegate = self;
        [viewbj addSubview:_dropdownMenutwo];
    }];
    
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 240, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入意见标题";
    _textFile2.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile2];

    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 280, Screen_Width-20, 70)];
    [viewbj addSubview:self.textView];
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
  
    _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4,360, Screen_Width/3.5, 25)];
    [_duiwai.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_duiwai setTitle:@"对外公示" forState:UIControlStateNormal];
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
    
    
    _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.7, 360, Screen_Width/3.2, 25)];
    [_duiwaino.layer setMasksToBounds:YES];
    [_duiwaino setTitle:@"对外不公示" forState:UIControlStateNormal];
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
    [_duiwaino addTarget:self action:@selector(duiwainoyuan) forControlEvents:UIControlEventTouchUpInside];
    
    [viewbj addSubview:_duiwaino];
    [viewbj addSubview:_duiwai];
    //    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(100,Screen_height-Screen_height/3.85, Screen_Width-200, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaoyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [viewbj addSubview:buttjiao];

    

}
-(void)butyuan{
    sms=@"1";
    [viewbj removeFromSuperview];
    viewbj=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    [self.view addSubview:viewbj];
     NSArray *arrayone=@[@"姓名:",@"电话:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        //        UITextAlignmentCenter
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile];
    
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile1];
    
    UIView *viewtis=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10, 105, Screen_Width/3.8, 50)];
    viewtis.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image.jpg"]];
    UILabel *labtsb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewtis.frame.size.width-10, viewtis.frame.size.height-2)];
    labtsb.text=@"若选择手机验证将收到结果回复短信";
    labtsb.textColor=[UIColor grayColor];
    labtsb.font=[UIFont systemFontOfSize:12.0f];
    [labtsb setNumberOfLines:0];
    [viewtis addSubview:labtsb];
    
    
    _but=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2,115, Screen_Width/4, 25)];
    [_but.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_but setTitle:@"手机验证" forState:UIControlStateNormal];
    [_but setFont:[UIFont systemFontOfSize:12]];
    [_but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_but addTarget:self action:@selector(butyuan) forControlEvents:UIControlEventTouchUpInside];
    [_but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _butview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butview.backgroundColor=[UIColor redColor];
    [_butview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butview.layer setBorderWidth:1.0];
    _butview.layer.borderColor=[UIColor redColor].CGColor;
    [_but addSubview:_butview];
    
    
    _butche=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.4, 115, Screen_Width/4, 25)];
    [_butche.layer setMasksToBounds:YES];
    [_butche setTitle:@"不验证" forState:UIControlStateNormal];
    [_butche setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_butche setFont:[UIFont systemFontOfSize:12]];
    _butcheview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butcheview.backgroundColor=[UIColor whiteColor];
    [_butcheview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butcheview.layer setBorderWidth:1.0];
    _butcheview.layer.borderColor=[UIColor redColor].CGColor;
    [_butche.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_butche addSubview:_butcheview];
    [_butche addTarget:self action:@selector(butcheyuan) forControlEvents:UIControlEventTouchUpInside];
    
    [viewbj addSubview:_butche];
    [viewbj addSubview:_but];
    //    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    [viewbj addSubview:viewtis];
    
    NSArray *arraytwo=@[@"验证码:",@"类型:",@"部门:",@"标题:"];
    for (int i=0; i<arraytwo.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+150, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arraytwo
        [i];
        //        UITextAlignmentCenter
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
    
    _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 150, Screen_Width/2.8 ,35)];
    _textFile3.backgroundColor = [UIColor whiteColor];
    _textFile3.font = [UIFont systemFontOfSize:14.f];
    _textFile3.textColor = [UIColor blackColor];
    _textFile3.textAlignment = NSTextAlignmentLeft;
    _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile3.placeholder = @"请输入验证码";
    _textFile3.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile3];
    butyzm=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.5,152, Screen_Width/4, 30)];
    [butyzm.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [butyzm setTitle:@"获取验证码" forState:UIControlStateNormal];
    [butyzm setFont:[UIFont systemFontOfSize:13]];
    butyzm.backgroundColor=[UIColor redColor];
    [butyzm.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
    [butyzm addTarget:self action:@selector(butyzmyuan) forControlEvents:UIControlEventTouchUpInside];
    [butyzm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewbj addSubview:butyzm];
    
    [[WebClient sharedClient] suqiuWT:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,195,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"OpinionClassId";
        _dropdownMenu.delegate = self;
        [viewbj addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] suqiubmen:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,240,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Deptid";
        _dropdownMenutwo.delegate = self;
        [viewbj addSubview:_dropdownMenutwo];
    }];
    
    
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 285, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入意见标题";
    _textFile2.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile2];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 330, Screen_Width-20, 70)];
    [viewbj addSubview:self.textView];
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
    _placeholderLabel.text = @"请输入要提交的内容";
    _placeholderLabel.font = self.textView.font;
    [self.textView addSubview:_placeholderLabel];
    //    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(100,Screen_height-Screen_height/3.85, Screen_Width-200, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaoyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewbj addSubview:buttjiao];
    

}
-(void)butcheyuan{
    sms=@"0";
  [viewbj removeFromSuperview];
    viewbj=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    [self.view addSubview:viewbj];
      NSArray *arrayone=@[@"姓名:",@"电话:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        //        UITextAlignmentCenter
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile];
    
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile1];
    
    UIView *viewtis=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/4.3+10, 105, Screen_Width/3.8, 50)];
    viewtis.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image.jpg"]];
    UILabel *labtsb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewtis.frame.size.width-10, viewtis.frame.size.height-2)];
    labtsb.text=@"若选择手机验证将收到结果回复短信";
    labtsb.textColor=[UIColor grayColor];
    labtsb.font=[UIFont systemFontOfSize:12.0f];
    [labtsb setNumberOfLines:0];
    [viewtis addSubview:labtsb];
    
    
    _but=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/2,115, Screen_Width/4, 25)];
    [_but.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_but setTitle:@"手机验证" forState:UIControlStateNormal];
    [_but setFont:[UIFont systemFontOfSize:12]];
    [_but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_but addTarget:self action:@selector(butyuan) forControlEvents:UIControlEventTouchUpInside];
    [_but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _butview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butview.backgroundColor=[UIColor whiteColor];
    [_butview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butview.layer setBorderWidth:1.0];
    _butview.layer.borderColor=[UIColor redColor].CGColor;
    [_but addSubview:_butview];
    
    
    _butche=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.4, 115, Screen_Width/4, 25)];
    [_butche.layer setMasksToBounds:YES];
    [_butche setTitle:@"不验证" forState:UIControlStateNormal];
    [_butche setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_butche setFont:[UIFont systemFontOfSize:12]];
    _butcheview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _butcheview.backgroundColor=[UIColor redColor];
    [_butcheview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_butcheview.layer setBorderWidth:1.0];
    _butcheview.layer.borderColor=[UIColor redColor].CGColor;
    [_butche.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_butche addSubview:_butcheview];
    
    [viewbj addSubview:_butche];
    [viewbj addSubview:_but];
    //    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    [viewbj addSubview:viewtis];
    
    NSArray *arraytwo=@[@"类型:",@"部门:",@"标题:"];
    for (int i=0; i<arraytwo.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+150, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arraytwo
        [i];
        //        UITextAlignmentCenter
        labzhum.textAlignment = UITextAlignmentCenter;
        [viewbj addSubview:labzhum];
    }
    [[WebClient sharedClient] suqiuWT:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray);
        
        _dropdownMenu= [[LMJDropdownMenu alloc] init];
        [_dropdownMenu setFrame:CGRectMake(Screen_Width/4.3+10,150,Screen_Width/1.6, 35)];
        [_dropdownMenu setMenuTitles:muarray rowHeight:30];
        _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
        _dropdownMenu.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenu.strpand=@"OpinionClassId";
        _dropdownMenu.delegate = self;
        [viewbj addSubview:_dropdownMenu];
    }];
    [[WebClient sharedClient] suqiubmen:ddtvinfo Keys:ddkey pagesize:@"30" page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
        NSMutableArray *muarray2=[resultObject objectForKey:@"Data" ];
        NSLog(@"%@",muarray2);
        
        _dropdownMenutwo= [[LMJDropdownMenu alloc] init];
        [_dropdownMenutwo setFrame:CGRectMake(Screen_Width/4.3+10,195,Screen_Width/1.6, 35)];
        [_dropdownMenutwo setMenuTitles:muarray2 rowHeight:30];
        _dropdownMenutwo.layer.borderColor=RGBColor(230, 233, 233).CGColor;
        NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenutwo.mainBtn.currentTitle );
        _dropdownMenutwo.layer.borderWidth= 1.0f;
        //传值到_dropdownMenu页面判断
        _dropdownMenutwo.strpand=@"Deptid";
        _dropdownMenutwo.delegate = self;
        [viewbj addSubview:_dropdownMenutwo];
    }];
    
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 240, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入意见标题";
    _textFile2.layer.borderWidth= 1.0f;
    [viewbj addSubview:_textFile2];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 280, Screen_Width-20, 70)];
    [viewbj addSubview:self.textView];
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
    
    _duiwai=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4,360, Screen_Width/3.5, 25)];
    [_duiwai.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [_duiwai setTitle:@"对外公示" forState:UIControlStateNormal];
    [_duiwai setFont:[UIFont systemFontOfSize:11]];
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
    
    
    _duiwaino=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.7, 360, Screen_Width/3.2, 25)];
    [_duiwaino.layer setMasksToBounds:YES];
    [_duiwaino setTitle:@"对外不公示" forState:UIControlStateNormal];
    [_duiwaino setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_duiwaino setFont:[UIFont systemFontOfSize:11]];
    _duiwainoview=[[UIView alloc]initWithFrame:CGRectMake(5, 8, 10, 10)];
    _duiwainoview.backgroundColor=[UIColor redColor];
    [_duiwainoview.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [_duiwainoview.layer setBorderWidth:1.0];
    _duiwainoview.layer.borderColor=[UIColor redColor].CGColor;
    [_duiwaino.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_duiwaino addSubview:_duiwainoview];
    [_duiwaino addTarget:self action:@selector(duiwainoyuan) forControlEvents:UIControlEventTouchUpInside];
    
    [viewbj addSubview:_duiwaino];
    [viewbj addSubview:_duiwai];
    //    viewtis.backgroundColor=[UIImage imageNamed:@"sqtjcontent_tip_bg.9"];
    UIButton *buttjiao=[[UIButton alloc]initWithFrame:CGRectMake(100,Screen_height-Screen_height/3.85, Screen_Width-200, 35)];
    [buttjiao.layer setMasksToBounds:YES];
    //      _but.font=[UIFont systemFontOfSize:13];
    [buttjiao setTitle:@"提    交" forState:UIControlStateNormal];
    [buttjiao setFont:[UIFont systemFontOfSize:15]];
    buttjiao.backgroundColor=[UIColor redColor];
    [buttjiao.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [buttjiao addTarget:self action:@selector(buttjiaoyuan) forControlEvents:UIControlEventTouchUpInside];
    [buttjiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [viewbj addSubview:buttjiao];

}
-(void)duiwainoyuan{
  _duiwaiview.backgroundColor=[UIColor whiteColor];
     _duiwainoview.backgroundColor=[UIColor redColor];
    Visible=@"0";

}
-(void)duiwaiyuan{
    _duiwaiview.backgroundColor=[UIColor redColor];
    _duiwainoview.backgroundColor=[UIColor whiteColor];
Visible=@"1";
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
// 开启倒计时效果
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
                [butyzm setTitle:@"重新发送" forState:UIControlStateNormal];
                [butyzm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                butyzm.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [butyzm setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [butyzm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                butyzm.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
//发送验证码实现的方法
-(void)butyzmyuan{
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
            [[WebClient sharedClient] ShoujYZ:ddtvinfo Keys:ddkey phone:_textFile1.text YZ:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                YZM=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                NSLog(@"%@",resultObject);
                [self openCountdown];
              
            }];
        }else{
          [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
        }
    
    }
}
/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

//提交实现的方法
-(void)buttjiaoyuan{
    NSLog(@"%@-%@",YZM,_textFile3.text);
    if ([sms containsString:@"1"]) {
     
        if ([YZM isEqualToString:_textFile3.text]) {
            if (self.dropdownMenutwo.suqiu.Deptid.length!=0 && self.dropdownMenu.SuQiuM.OpinionClassId.length!=0) {
                NSLog(@"username-%@-%@-%@",username,self.dropdownMenu.SuQiuM.OpinionClassId,self.dropdownMenutwo.suqiu.Deptid);
                [[WebClient sharedClient]SQtjiao:ddtvinfo Keys:ddkey Deptid:Deptid UserName:username Title:_textFile2.text Content:_textView.text MobileNo:_textFile1.text OpinionClassId:self.dropdownMenutwo.suqiu.Deptid Visible:Visible  SMS:sms Opinionid:self.dropdownMenu.SuQiuM.OpinionClassId ResponseBlock:^(id resultObject, NSError *error) {
                    NSLog(@"resultObject=%@",resultObject);
                }];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:@"你的输入有误"];
            }

        }else{
          [SVProgressHUD showErrorWithStatus:@"你输入的验证码有误"];
        
        }
        
    }else{
        if (self.dropdownMenutwo.suqiu.Deptid.length!=0 && self.dropdownMenu.SuQiuM.OpinionClassId.length!=0) {
            NSLog(@"username-%@-%@-%@",username,self.dropdownMenu.SuQiuM.OpinionClassId,self.dropdownMenutwo.suqiu.Deptid);
            [[WebClient sharedClient]SQtjiao:ddtvinfo Keys:ddkey Deptid:Deptid UserName:username Title:_textFile2.text Content:_textView.text MobileNo:_textFile1.text OpinionClassId:self.dropdownMenutwo.suqiu.Deptid Visible:Visible  SMS:sms Opinionid:self.dropdownMenu.SuQiuM.OpinionClassId ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"resultObject=%@",resultObject);
            }];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"你的输入有误"];
        }

    
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
