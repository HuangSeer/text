//
//  IPCViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "IPCViewController.h"
#import "PchHeader.h"
#import "WiFiViewController.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"

@interface IPCViewController (){

    id<AnjubaoSDK> sdk;
    AJBUserGetAddress* userAddress;
    AJBAddressInfo* addressInfo;
    NSMutableDictionary* map;
    NSMutableArray* homeNameList;
}
@property (strong ,nonatomic)UITextField *textFile;
@property (strong ,nonatomic)UITextField *textFile1;
@end

@implementation IPCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    sdk = [AnjubaoSDK instance];
    map = [[NSMutableDictionary alloc] init];
    userAddress = nil;
    addressInfo = nil;
    AJBUserGetAddress* address = [sdk userGetAddress];
    if (address && address.res == ErrorCode_ERR_OK) {
        userAddress = address;
        [map removeAllObjects];
        homeNameList= [[NSMutableArray alloc] init];
        for (AJBAddressInfo* a in [address my_address]) {
            NSString* homeName =
            [NSString stringWithFormat:@"%@_%@", a.name, a.Address_id];
            [map setObject:a
                    forKey:homeName];
            [homeNameList addObject:homeName];
        }
    }
    [self homeSelected];
    [self initUI];
    self.navigationItem.title=@"设备添加(IPC绑定)";
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
-(void)initUI{
    NSArray *arrays=@[@"序  列  号:",@"设备名称:"];
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
    //绑定设备按钮
  UIButton  *butdata=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/3.5)/2,120,Screen_Width/3.5, 30)];
    [butdata.layer setMasksToBounds:YES];
    butdata.backgroundColor=[UIColor blueColor];
    [butdata setTitle:@"绑   定" forState:UIControlStateNormal];
    [butdata setFont:[UIFont systemFontOfSize:14.0f]];
    [butdata addTarget:self action:@selector(butdatayuan) forControlEvents:UIControlEventTouchUpInside];
    [butdata setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:butdata];
    
    //配置wifi按钮
    UIButton  *butdata2=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/3.5)/2,165,Screen_Width/3.5, 30)];
    [butdata2.layer setMasksToBounds:YES];
    butdata2.backgroundColor=[UIColor blueColor];
    [butdata2 setTitle:@"配置WiFi" forState:UIControlStateNormal];
    [butdata2 setFont:[UIFont systemFontOfSize:14.0f]];
    [butdata2 addTarget:self action:@selector(butdata2yuan) forControlEvents:UIControlEventTouchUpInside];
    [butdata2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:butdata2];
    
}

-(void)butdatayuan{
    if (_textFile.text.length!=0) {
        NSString*string =[NSString stringWithFormat:@"%@",_textFile.text];
        string = [string substringFromIndex:2];//截取掉下标2之后的字符串
        NSLog(@"string==%@",string);
        [AJBIpcInfomation class];
        AJBIpcInfomation* ipc = [[AJBIpcInfomation alloc] init];
        NSLog(@"===========%@====================",addressInfo.Address_id);
        [ipc setAddress_id:addressInfo.Address_id];
        [ipc setIpc_serial_number:string];
        [ipc setName:_textFile1.text];
        [ipc setIpc_factory:@"ajb-ipc"];
        NSString *stringQW =[NSString stringWithFormat:@"%@",_textFile.text];
        stringQW = [stringQW substringFromIndex:2];//截取掉下标7之后的字符串
        AJBrefreshIpcIsOnline* result = [sdk refreshIpcIsOnline:stringQW];
       
            if (result.isOnline) {
                 NSLog(@"==2=2=2=2=====2=2=2=====%d", [sdk homeBindIpc:addressInfo.Address_id ipcInformation:ipc]);
                if (0== [sdk homeBindIpc:addressInfo.Address_id ipcInformation:ipc]) {
                     [iOSToast toast:@"绑定成功" :1];
                } else {
                     [iOSToast toast:@"绑定失败" :1];
            
                }
            } else {
               
                [iOSToast toast:@"IPC不在线，请确保IPC正常联网，或重置IPC，听到\"请配置无线网络\"后进行WiFi配置" :2];
            }
        
        
    }
  
  

}

-(void)butdata2yuan{
    WiFiViewController *WiFiVi=[[WiFiViewController alloc] init];
    [self.navigationController pushViewController:WiFiVi animated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
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
-(void)homeSelected{
    NSString* selectedValue = homeNameList[0];
    addressInfo = [map objectForKey:selectedValue];
    
    NSLog(@"%@====================%@================", addressInfo,selectedValue);
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
