//
//  DYziyemViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DYziyemViewController.h"
#import "LMJDropdownMenu.h"
#import "WebClient.h"
#import "PchHeader.h"
#import "DyMAFANViewController.h"
#import "DfcxTableViewCell.h"

@interface DYziyemViewController ()<UITextViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    UILabel *_placeholderLabel;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSString *aaid;
    NSString *Deptid;
    UIButton *butyzm;
    UIButton *login;
    NSString *Status;
    UITableView *tableView;
    NSMutableArray *_dataArray;
}
@property (strong ,nonatomic)UITextView *textView;
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;
@property (strong ,nonatomic)UITextField *textFile3;
@property (strong ,nonatomic)UITextField *textFile4;
@property (strong ,nonatomic)UITextField *textFile5;

@end

@implementation DYziyemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    ddtvinfo=[userDefaults objectForKey:TVInfoId];
    ddkey=[userDefaults objectForKey:Key];
    Deptid=[userDefaults objectForKey:DeptId];
   
    
    if ([_dystr containsString:@"1"]) {
        self.navigationItem.title=@"党员登录";
        
    }else if ([_dystr containsString:@"2"]) {
        self.navigationItem.title=@"党费查询";
        
    }else{
        self.navigationItem.title=@"入党申请";
        
    }
    [self initDYgl];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    // Do any additional setup after loading the view.
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)initDYgl{
    //判断传过来的值是否为1，如果是加载1对应的页面
    if ([_dystr containsString:@"1"]) {
        NSArray *arrayone=@[@"姓名",@"身份证号",@"手机号",@"验证码"];
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:14.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = UITextAlignmentCenter;
            [self.view addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入身份证号";
        _textFile1.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile1];
        _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 100, Screen_Width/1.6 ,35)];
        _textFile2.backgroundColor = [UIColor whiteColor];
        _textFile2.font = [UIFont systemFontOfSize:14.f];
        _textFile2.textColor = [UIColor blackColor];
        _textFile2.textAlignment = NSTextAlignmentLeft;
        _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile2.placeholder = @"请输入手机号";
        _textFile2.layer.borderWidth= 1.0f;
        
        [self.view addSubview:_textFile2];
        _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 145, Screen_Width/3.2 ,35)];
        _textFile3.backgroundColor = [UIColor whiteColor];
        _textFile3.font = [UIFont systemFontOfSize:14.f];
        _textFile3.textColor = [UIColor blackColor];
        _textFile3.textAlignment = NSTextAlignmentLeft;
        _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile3.placeholder = @"请输入验证码";
        _textFile3.layer.borderWidth= 1.0f;
        
        [self.view addSubview:_textFile3];
        butyzm=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.6,147, Screen_Width/3.7, 30)];
        [butyzm.layer setMasksToBounds:YES];
        //      _but.font=[UIFont systemFontOfSize:13];
        [butyzm setTitle:@"获取验证码" forState:UIControlStateNormal];
       // [butyzm setFont:[UIFont systemFontOfSize:13]];
        butyzm.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        butyzm.backgroundColor=[UIColor redColor];
        [butyzm.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [butyzm addTarget:self action:@selector(butyzmyuan) forControlEvents:UIControlEventTouchUpInside];
        [butyzm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:butyzm];
        login=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2,210,100, 30)];
        [login.layer setMasksToBounds:YES];
        [login setTitle:@"登  录" forState:UIControlStateNormal];
        login.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        
       // [login setFont:[UIFont systemFontOfSize:13]];
        login.backgroundColor=[UIColor redColor];
        [login.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [login addTarget:self action:@selector(loginyuan) forControlEvents:UIControlEventTouchUpInside];
        [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:login];
        
        
    }else if ([_dystr containsString:@"2"])
    {
        NSArray *arrayone=@[@"姓名",@"身份证号"];
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:14.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入身份证号";
        _textFile1.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile1];
        
        login=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2,110,100, 30)];
        [login.layer setMasksToBounds:YES];
        [login setTitle:@"查  询" forState:UIControlStateNormal];
        login.titleLabel.font = [UIFont systemFontOfSize: 13.0];
      //  [login setFont:[UIFont systemFontOfSize:13]];
        login.backgroundColor=[UIColor redColor];
        [login.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [login addTarget:self action:@selector(loginyuan) forControlEvents:UIControlEventTouchUpInside];
        [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:login];
    }else{
        
        NSArray *arrayone=@[@"姓名",@"身份证号",@"年龄",@"单位",@"职务",@"电话",@"学历",@"名族",@"入党申请书"];
        for (int i=0; i<arrayone.count; i++) {
            NSInteger page = i/1;
            UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
            labzhum.textColor=[UIColor blackColor];
            labzhum.font=[UIFont systemFontOfSize:13.0f];
            labzhum.text=arrayone[i];
            labzhum.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:labzhum];
        }
        _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,10, Screen_Width/1.6 ,35)];
        _textFile.backgroundColor = [UIColor whiteColor];
        _textFile.font = [UIFont systemFontOfSize:14.f];
        _textFile.textColor = [UIColor blackColor];
        _textFile.textAlignment = NSTextAlignmentLeft;
        _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile.placeholder = @"请输入姓名";
        _textFile.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile];
        _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,55, Screen_Width/1.6 ,35)];
        _textFile1.backgroundColor = [UIColor whiteColor];
        _textFile1.font = [UIFont systemFontOfSize:14.f];
        _textFile1.textColor = [UIColor blackColor];
        _textFile1.textAlignment = NSTextAlignmentLeft;
        _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile1.placeholder = @"请输入身份证号";
        _textFile1.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile1];
        _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 100, Screen_Width/1.6 ,35)];
        _textFile2.backgroundColor = [UIColor whiteColor];
        _textFile2.font = [UIFont systemFontOfSize:14.f];
        _textFile2.textColor = [UIColor blackColor];
        _textFile2.textAlignment = NSTextAlignmentLeft;
        _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile2.placeholder = @"请输入年龄";
        _textFile2.layer.borderWidth= 1.0f;
        
        [self.view addSubview:_textFile2];
        _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 145, Screen_Width/1.6 ,35)];
        _textFile3.backgroundColor = [UIColor whiteColor];
        _textFile3.font = [UIFont systemFontOfSize:14.f];
        _textFile3.textColor = [UIColor blackColor];
        _textFile3.textAlignment = NSTextAlignmentLeft;
        _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile3.placeholder = @"请输入单位";
        _textFile3.layer.borderWidth= 1.0f;
        
        [self.view addSubview:_textFile3];
        
        _textFile4= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 190, Screen_Width/1.6 ,35)];
        _textFile4.backgroundColor = [UIColor whiteColor];
        _textFile4.font = [UIFont systemFontOfSize:14.f];
        _textFile4.textColor = [UIColor blackColor];
        _textFile4.textAlignment = NSTextAlignmentLeft;
        _textFile4.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile4.placeholder = @"请输入职务";
        _textFile4.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile4];
        _textFile5= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 235, Screen_Width/1.6 ,35)];
        _textFile5.backgroundColor = [UIColor whiteColor];
        _textFile5.font = [UIFont systemFontOfSize:14.f];
        _textFile5.textColor = [UIColor blackColor];
        _textFile5.textAlignment = NSTextAlignmentLeft;
        _textFile5.layer.borderColor= RGBColor(230, 233, 233).CGColor;
        _textFile5.placeholder = @"请输入电话";
        _textFile5.layer.borderWidth= 1.0f;
        [self.view addSubview:_textFile5];
        [[WebClient sharedClient] nation:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            
            NSLog(@"resultObjectresultObjectresultObjectresultObject===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu setFrame:CGRectMake( Screen_Width/4.3+10,275, Screen_Width/1.6, 35)];
            [_dropdownMenu setMenuTitles:muarray rowHeight:30];
            _dropdownMenu.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu.strpand=@"Nation";
            _dropdownMenu.delegate = self;
            [self.view addSubview:_dropdownMenu];
        }];
        [[WebClient sharedClient] culturelevel:ddtvinfo Keys:ddkey deptid:Deptid ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"LMJDropdownMenuLMJDropdownMenu===%@",resultObject);
            NSMutableArray *muarray=[resultObject objectForKey:@"Data" ];
            NSLog(@"%@",muarray);
            
            _dropdownMenu1= [[LMJDropdownMenu alloc] init];
            [_dropdownMenu1 setFrame:CGRectMake(10+Screen_Width/4.3,320, Screen_Width/1.6, 35)];
            [_dropdownMenu1 setMenuTitles:muarray rowHeight:30];
            _dropdownMenu1.layer.borderColor=RGBColor(230, 233, 233).CGColor;
            //            NSLog(@" dropdownMenu.mainBtn.titleLabel%@", _dropdownMenu.mainBtn.currentTitle );
            _dropdownMenu1.layer.borderWidth= 1.0f;
            //传值到_dropdownMenu页面判断
            _dropdownMenu1.strpand=@"one";
            _dropdownMenu1.delegate = self;
            [self.view addSubview:_dropdownMenu1];
        }];
        
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10+Screen_Width/4.3, 365, Screen_Width/1.6, 80)];
        [self.view addSubview:self.textView];
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
        self.textView.layer.cornerRadius = 1.0f;
        self.textView.layer.borderWidth = 1;
        self.textView.layer.borderColor =[UIColor grayColor].CGColor;
        
        //模仿UTextField的placeholder属性
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.textView.frame), 20)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.text = @"请输入内容";
        _placeholderLabel.font = self.textView.font;
        [self.textView addSubview:_placeholderLabel];
        
        login=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-100)/2,455,100, 30)];
        [login.layer setMasksToBounds:YES];
        [login setTitle:@"申  请" forState:UIControlStateNormal];
      //  [login setFont:[UIFont systemFontOfSize:13]];
        login.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        login.backgroundColor=[UIColor redColor];
        [login.layer setCornerRadius:3.0]; //设置矩形四个圆角半径
        [login addTarget:self action:@selector(loginyuan) forControlEvents:UIControlEventTouchUpInside];
        [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.view addSubview:login];
        
        
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
    if (_textFile2.text.length < 11)
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
        BOOL isMatch1 = [pred1 evaluateWithObject:_textFile2.text];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:_textFile2.text];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:_textFile2.text];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            [[WebClient sharedClient] ShoujYZ:ddtvinfo Keys:ddkey phone:_textFile2.text YZ:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                //                YZM=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                Status=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"YZM"]];
                NSLog(@"%@",resultObject);
                [self openCountdown];
                
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
        }
        
    }
}

-(void)loginyuan{
    
    if ([_dystr containsString:@"1"]) {
        if (_textFile.text.length!=0) {
            
            if (_textFile1.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile1.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile1.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile1.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);
                    //if(idCardMod==2) {
                        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                            if([Status isEqualToString:_textFile3.text] ){
                                if (_textFile2.text.length < 11)
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
                                    BOOL isMatch1 = [pred1 evaluateWithObject:_textFile2.text];
                                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                                    BOOL isMatch2 = [pred2 evaluateWithObject:_textFile2.text];
                                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                                    BOOL isMatch3 = [pred3 evaluateWithObject:_textFile2.text];
                                    
                                    if (isMatch1 || isMatch2 || isMatch3) {
                                        
                                        
                                        [[WebClient sharedClient] partylogin:_textFile1.text name:_textFile.text LinkTel:_textFile2.text ResponseBlock:^(id resultObject, NSError *error) {
                                            NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                            if ([strfh isEqualToString:@"0"]) {
                                                [SVProgressHUD showErrorWithStatus:@"无此党员或信息有误"];
                                            }else{
                                                DyMAFANViewController *  DyMAFANV=[[DyMAFANViewController alloc]init];
                                                [self.navigationController pushViewController: DyMAFANV animated:NO];
                                                
                                            }
                                            
                                        }];
                                        
                                        
                                    }else{
                                        [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
                                    }
                                }
                            } else{
                                
                                [SVProgressHUD showErrorWithStatus:@"你输入的验证码有误"];
                            }
                            
                        
                    }
                    else{
                        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//                        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                            NSLog(@"Status=%@",Status);
                            
                            if([Status isEqualToString:_textFile3.text] ){
                                if (_textFile2.text.length < 11)
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
                                    BOOL isMatch1 = [pred1 evaluateWithObject:_textFile2.text];
                                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                                    BOOL isMatch2 = [pred2 evaluateWithObject:_textFile2.text];
                                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                                    BOOL isMatch3 = [pred3 evaluateWithObject:_textFile2.text];
                                    
                                    if (isMatch1 || isMatch2 || isMatch3) {
                                        NSLog(@"%@-%@-%@-",_textFile.text,_textFile1.text,_textFile2.text);
                                        
                                        
                                        [[WebClient sharedClient] partylogin:_textFile1.text name:_textFile.text LinkTel:_textFile2.text ResponseBlock:^(id resultObject, NSError *error) {
                                            NSLog(@"%@",resultObject);
                                            NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                            if ([strfh isEqualToString:@"0"]) {
                                                [SVProgressHUD showErrorWithStatus:@"无此党员或信息有误"];
                                            }else{
                                                DyMAFANViewController *  DyMAFANV=[[DyMAFANViewController alloc]init];
                                                [self.navigationController pushViewController: DyMAFANV animated:NO];
                                                
                                                
                                            }
                                        }];
                                        
                                        
                                    }else{
                                        [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
                                    }
                                }
                            } else{
                                
                                [SVProgressHUD showErrorWithStatus:@"你输入的验证码有误"];
                            }
                            
//                        }else{
//                            [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
//                            
//                        }
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
                
            }
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            
        }
    }else  if ([_dystr containsString:@"2"]) {
        if (_textFile.text.length!=0) {
            
            
            if (_textFile1.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile1.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile1.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile1.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);
                    //if(idCardMod==2) {
                        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                            [[WebClient sharedClient] interface:ddtvinfo Keys:ddkey idcard:_textFile1.text name:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                                NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                if ([strfh isEqualToString:@"0"]) {
                                    [SVProgressHUD showErrorWithStatus:@"无此党费或信息有误"];
                                }else{
                                    _dataArray=[DfcxModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                                      [self initTableView];
                                }
                                
                            }];
    
                    }else{
                        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//                        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                            [[WebClient sharedClient] interface:ddtvinfo Keys:ddkey idcard:_textFile1.text name:_textFile.text ResponseBlock:^(id resultObject, NSError *error) {
                                NSLog(@"resultObject==%@",resultObject);
                                NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                if ([strfh isEqualToString:@"0"]) {
                                [SVProgressHUD showErrorWithStatus:@"无此党费或信息有误"];
                                }else{
                                 
                                    _dataArray=[DfcxModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
                                    [self initTableView];
                                }
                                
                            }];
                     
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                    
                }
                
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"你的姓名输入有误"];
        }
        
    }else{
        
        if (_textFile.text.length!=0 &&_textFile1.text.length!=0 && _textFile2.text.length!=0 &&_textFile3.text.length!=0  &&_textFile4.text.length!=0  &&_textView.text.length!=0 &&_textFile5.text.length!=0 && _dropdownMenu1.LecwM.levelId.length!=0 &&_dropdownMenu.NationM.NationId.length!=0) {
            
            
            if (_textFile1.text.length != 18){
                [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                
            }else{
                // 正则表达式判断基本 身份证号是否满足格式
                NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
                //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
                NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
                //如果通过该验证，说明身份证格式正确，但准确性还需计算
                if([identityStringPredicate evaluateWithObject:_textFile1.text]){
                    //** 开始进行校验 *//
                    
                    //将前17位加权因子保存在数组里
                    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
                    
                    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                    
                    //用来保存前17位各自乖以加权因子后的总和
                    NSInteger idCardWiSum = 0;
                    for(int i = 0;i < 17;i++) {
                        NSInteger subStrIndex = [[_textFile1.text substringWithRange:NSMakeRange(i, 1)] integerValue];
                        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                        idCardWiSum+= subStrIndex * idCardWiIndex;
                    }
                    
                    //计算出校验码所在数组的位置
                    NSInteger idCardMod=idCardWiSum%11;
                    //得到最后一位身份证号码
                    NSString *idCardLast= [_textFile1.text substringWithRange:NSMakeRange(17, 1)];
                    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                    NSLog(@"idCardMod==%ld",idCardMod);
                    //if(idCardMod==2) {
                        if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                            if (_textFile5.text.length < 11)
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
                                BOOL isMatch1 = [pred1 evaluateWithObject:_textFile5.text];
                                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                                BOOL isMatch2 = [pred2 evaluateWithObject:_textFile5.text];
                                NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                                BOOL isMatch3 = [pred3 evaluateWithObject:_textFile5.text];
                                
                                if (isMatch1 || isMatch2 || isMatch3) {
                                    
                                    [[WebClient sharedClient] Application:ddtvinfo Keys:ddkey deptid:Deptid name:_textFile.text idcard:_textFile1.text age:_textFile2.text unit:_textFile3.text job:_textFile4.text content:_textView.text phone:_textFile5.text levelId:_dropdownMenu1.LecwM.levelId  nationId:_dropdownMenu.NationM.NationId ResponseBlock:^(id resultObject, NSError *error) {
                                        
                                        NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                        if ([strfh isEqualToString:@"1"]) {
                                            [SVProgressHUD showErrorWithStatus:@"申请成功"];
                                        }else{
                                            [SVProgressHUD showErrorWithStatus:@"你已经提交请耐心等待"];
                                            
                                        }
                                    }];
                                    
                                    
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
                                }
                            }
                        
                    }else{
                        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                        
                        if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                            if (_textFile5.text.length < 11)
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
                                BOOL isMatch1 = [pred1 evaluateWithObject:_textFile5.text];
                                NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                                BOOL isMatch2 = [pred2 evaluateWithObject:_textFile5.text];
                                NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                                BOOL isMatch3 = [pred3 evaluateWithObject:_textFile5.text];
                                
                                if (isMatch1 || isMatch2 || isMatch3) {
                                    
                                    NSLog(@"ddkey==%@-%@-%@-%@-%@-%@-%@-%@-%@-%@-%@-%@",ddkey,ddtvinfo,Deptid,_textFile.text ,_textFile1.text,_textFile2.text ,_textFile3.text ,_textFile4.text ,_textView.text, _textFile5.text ,_dropdownMenu1.LecwM.levelId  ,_dropdownMenu.NationM.NationId );
                                    [[WebClient sharedClient] Application:ddtvinfo Keys:ddkey deptid:Deptid name:_textFile.text idcard:_textFile1.text age:_textFile2.text unit:_textFile3.text job:_textFile4.text content:_textView.text phone:_textFile5.text levelId:_dropdownMenu1.LecwM.levelId  nationId:_dropdownMenu.NationM.NationId ResponseBlock:^(id resultObject, NSError *error) {
                                        NSString *strfh=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
                                        if ([strfh isEqualToString:@"1"]) {
                                            [SVProgressHUD showErrorWithStatus:@"申请成功"];
                                        }else{
                                            [SVProgressHUD showErrorWithStatus:@"你已经提交请耐心等待"];
                                            
                                        }
                                    }];
                                    
                                    
                                }else{
                                    [SVProgressHUD showErrorWithStatus:@"你输入的电话有误"];
                                }
                            }
                            
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"你的身份证输入有误"];
                            
                        }
                    }
                }
                
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"你的姓名输入有误"];
        }
        
        
    }
    
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
- (void)initTableView {
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Screen_height/3.8,Screen_Width, self.view.frame.size.height-Screen_height/3) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DfcxTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    UIView *viewdi=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/1.22,Screen_Width,Screen_height-Screen_height/1.22)];
     [self.view addSubview:viewdi];
    UILabel *labzj=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, Screen_Width/3,30)];
    labzj.text=@"党费小计:";
     labzj.textColor=[UIColor blackColor];
    [viewdi addSubview:labzj];
    UILabel *labprice=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-(Screen_Width/3+5), 5, Screen_Width/3, 30)];
    labprice.text=@"51";
    labprice.textColor=[UIColor blackColor];
     labprice.textAlignment = NSTextAlignmentRight;
    [viewdi addSubview:labprice];
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
//    view.backgroundColor=[UIColor redColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/3, 30)];
    lab.text=@"日期";
    UILabel *labfy=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-Screen_Width/3, 0, Screen_Width/3, 30)];
    labfy.text=@"费用";
    
//    NSTextAlignmentLeft
    labfy.textAlignment = NSTextAlignmentRight;
     [view addSubview:labfy];
    [view addSubview:lab];
    return view;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  30;
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DfcxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.DfcxM=_dataArray[indexPath.row];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    SheQUwebViewController *SheQUwebV = [[SheQUwebViewController alloc] init];
    //    SheQuModel * SheQuM=_dataArray[indexPath.row];
    //    SheQUwebV.webid= SheQuM.NewsId;
    //    NSLog(@"%@",SheQUwebV.webid);
    //    [self.navigationController pushViewController:SheQUwebV animated:YES];
    
}


/*
 **监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //    [self endEditing:YES];
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
