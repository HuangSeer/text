

//
//  WiFiViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WiFiViewController.h"
#import "PchHeader.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"
@interface WiFiViewController (){
    UIButton  *butdata;
    UIButton  *butdata2;

WiFiOneKeyConfigUtil* wifiConfig;
}
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;

@end

@implementation WiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.navigationItem.title=@"设备添加(WiFi配置)";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    WirelessType type[] = {
        Sound,
//        ([ViewController instance].appTypeValue == 1 ? Realtek : MTK)
    };
    int typeLength = sizeof(type) / sizeof(type[0]);
    wifiConfig = [[WiFiOneKeyConfigUtil alloc] initWithTypes:type :typeLength];
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (wifiInterfaces) {
        NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
        for (NSString *interfaceName in interfaces) {
            NSLog(@"interfaceName %@", interfaceName);
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if (dictRef) {
                NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
                [_textFile setText:[networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID]];
                CFRelease(dictRef);
            }
        }
        CFRelease(wifiInterfaces);
    }
    [butdata2 setEnabled:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)onConfigResult:(int)result
{
    if (result==0) {
        [SVProgressHUD showSuccessWithStatus:@"配置成功,请绑定"];
        
        
//        [iOSToast toast:[NSString stringWithFormat:@"WiFi配置结果: %d", result] :2];
        [butdata2 setHighlighted:YES];
        [butdata2 sendActionsForControlEvents:UIControlEventTouchUpInside];
        [butdata2 setHighlighted:NO];
    }else{
    
    [SVProgressHUD showErrorWithStatus:@"配置失败,请检查"];
        [butdata2 setHighlighted:YES];
        [butdata2 sendActionsForControlEvents:UIControlEventTouchUpInside];
        [butdata2 setHighlighted:NO];
    }

}

-(void)initUI{
    WirelessType type[] = {
        Sound,
//        ([ViewController instance].appTypeValue == 1 ? Realtek : MTK)
    };
    int typeLength = sizeof(type) / sizeof(type[0]);
    wifiConfig = [[WiFiOneKeyConfigUtil alloc] initWithTypes:type :typeLength];
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (wifiInterfaces) {
        NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
        for (NSString *interfaceName in interfaces) {
            NSLog(@"interfaceName %@", interfaceName);
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if (dictRef) {
                NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
                [_textFile setText:[networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID]];
                CFRelease(dictRef);
            }
        }
        CFRelease(wifiInterfaces);
    }
    
//    [_textFile1 setText:@"zhuanxian123"];
//    [_textFile2 setText:(_ipcSerialNumberText ? _ipcSerialNumberText : @"1111111a")];
//    [useSoundConfirmSwitch setOn:NO];
    [butdata2 setEnabled:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    NSArray *arrays=@[@"S  S  I   D:",@"密       码:",@"序  列  号:"];
    for (int i=0; i<arrays.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+20,Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrays[i];
        labzhum.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:labzhum];
        
        
    }
    _textFile= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,  20, Screen_Width/1.6 ,35)];
    _textFile.backgroundColor = [UIColor whiteColor];
    _textFile.font = [UIFont systemFontOfSize:14.f];
    _textFile.textColor = [UIColor blackColor];
    _textFile.textAlignment = NSTextAlignmentLeft;
    _textFile.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    //    _textFile.placeholder = @"请输入姓名";
    _textFile.layer.borderWidth= 1.0f;
    [self.view addSubview:_textFile];
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,65, Screen_Width/1.6 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    //    _textFile1.placeholder = @"请输入电话号";
    _textFile1.layer.borderWidth= 1.0f;
    [self.view addSubview:_textFile1];
    
    
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,110, Screen_Width/1.6 ,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    //    _textFile1.placeholder = @"请输入电话号";
    _textFile2.layer.borderWidth= 1.0f;
    [self.view addSubview:_textFile2];
    //绑定设备按钮

    butdata=[[UIButton alloc]initWithFrame:CGRectMake(50,165,Screen_Width/3.5, 30)];
    [butdata.layer setMasksToBounds:YES];
//    butdata.backgroundColor=[UIColor blueColor];
    [butdata setTitle:@"开始配置" forState:UIControlStateNormal];
    [butdata setFont:[UIFont systemFontOfSize:14.0f]];
    [butdata addTarget:self action:@selector(butdatasdyuan) forControlEvents:UIControlEventTouchUpInside];
    [butdata setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:butdata];
    
    //配置wifi按钮
    butdata2=[[UIButton alloc]initWithFrame:CGRectMake((100+Screen_Width/3.5),165,Screen_Width/3.5, 30)];
    [butdata2.layer setMasksToBounds:YES];
//    butdata2.backgroundColor=[UIColor blueColor];
    [butdata2 setTitle:@"结束配置" forState:UIControlStateNormal];
    [butdata2 setFont:[UIFont systemFontOfSize:14.0f]];
    [butdata2 addTarget:self action:@selector(butdataas2yuan) forControlEvents:UIControlEventTouchUpInside];
    [butdata2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:butdata2];
}
-(void)butdatasdyuan{
      [SVProgressHUD showWithStatus:@"加载中"];
    [butdata setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [butdata2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    BOOL useSoundConfirm = [useSoundConfirmSwitch isOn];
    NSString*string =[NSString stringWithFormat:@"%@",_textFile2.text];
    string = [string substringFromIndex:2];//截取掉下标7之后的字符串
    NSLog(@"string==%@",string);
    wifiConfig.configResultDelegate = self;
    BOOL result = [wifiConfig startConfig:string
                                     Ssid:_textFile.text
                                 Password:_textFile1.text
                         WithSoundConfirm:SoundConfirm
                                  Timeout:20];
    if (result) {
        NSLog(@"%d",result);
      
        [butdata setEnabled:NO];
        [butdata2 setEnabled:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:@"配置失败"];
    }
}
-(void)butdataas2yuan{
     [butdata setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
     [butdata2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    dispatch_async(dispatch_get_main_queue(), ^{
        [wifiConfig stopConfig:YES];
    });
    [butdata setEnabled:YES];
    [butdata2 setEnabled:NO];

}
-(void)dismissKeyboard {
    NSArray *subviews = [self.view subviews];
    for (id objInput in subviews) {
        if ([objInput isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
