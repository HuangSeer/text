//
//  JiaJuViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/21.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JiaJuViewController.h"
#import "PchHeader.h"
#import "IPCViewController.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"
#import <AnjubaoSDK/MediaSDK_objc.h>
#import <AnjubaoSDK/VoiceController.h>
#import <AnjubaoSDK/LANCommunication.h>
#import "AddBGViewController.h"
#import "iOSToast.h"

@interface JiaJuViewController (){

    NSMutableDictionary *userInfo;
    id<AnjubaoSDK> sdk;
    id<VoiceController> voiceController;
    AJBUserGetAddress* userAddress;
    AJBIpcInfomation* ipc;
    NSMutableDictionary* map;
    NSMutableDictionary* mapIpc;
    AJBIpcFile* file;
    int _handle;
    int ssrc;
    AJBEStreamType streamType;
    
    NSString* localDirectory;
    NSMutableArray* ipcNameList1;
 
}

@end

@implementation JiaJuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.navigationItem.title=@"可视对讲";
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
    //广告图片
    UIImageView *imagseView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height/5)];
    imagseView.image=[UIImage imageNamed:@"广告"];
    //摄像头按钮
    UIButton   *butsx=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-70)/2, Screen_height/5+20, 70, 70)];
     [butsx addTarget:self action:@selector(butsxmore) forControlEvents:UIControlEventTouchUpInside];
    [butsx setBackgroundImage:[UIImage imageNamed:@"摄像头"] forState:UIControlStateNormal];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((Screen_Width-100)/2, Screen_height/5+110, 100, 10)];
    
    lab.text=@"摄像机/智能网关";
    lab.font=[UIFont systemFontOfSize:13.0f];
    lab.textAlignment = UITextAlignmentCenter;
    UILabel *labti=[[UILabel alloc]initWithFrame:CGRectMake((Screen_Width-140)/2, Screen_height/5+140, 140, 10)];
    
    labti.text=@"365天想念,不如一分钟看见";
    labti.font=[UIFont systemFontOfSize:10.0f];
    labti.textAlignment = UITextAlignmentCenter;
    
    UIView  *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/2, Screen_Width, 5)];
    viewxian.backgroundColor=RGBColor(230, 230, 230);
    [self.view addSubview:viewxian];
    //摄像头按钮
    UIButton   *buttj=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-70)/2, Screen_height/2+20, 70, 70)];
    [buttj setBackgroundImage:[UIImage imageNamed:@"添加1"] forState:UIControlStateNormal];
     [buttj addTarget:self action:@selector(buttjmore) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake((Screen_Width-130)/2, Screen_height/2+110, 130, 10)];
    
    lab2.text=@"设备添加/全面智能化";
    lab2.font=[UIFont systemFontOfSize:13.0f];
    lab2.textAlignment = UITextAlignmentCenter;
    UILabel *labti2=[[UILabel alloc]initWithFrame:CGRectMake((Screen_Width-170)/2, Screen_height/2+140, 170, 10)];
    
    labti2.text=@"为家添加智能设备,指尖控制整个家";
    labti2.font=[UIFont systemFontOfSize:10.0f];
    labti2.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:labti2];
    [self.view addSubview:lab2];
    [self.view addSubview:buttj];
    [self.view addSubview:labti];
    [self.view addSubview:lab];
    [self.view addSubview:butsx];
    [self.view addSubview:imagseView];
    


}
-(void)butsxmore{
    if (ipcNameList1 != nil && ![ipcNameList1 isKindOfClass:[NSNull class]] && ipcNameList1.count != 0){
        
        AddBGViewController *AddBGV=[[AddBGViewController alloc] init];
        [self.navigationController pushViewController:AddBGV animated:NO];
        self.tabBarController.tabBar.hidden=YES;
        
    }else{
    
      [iOSToast toast:@"暂无设备,请添加" :1];
    }


}
-(void)buttjmore{
    IPCViewController *IPCV=[[IPCViewController alloc] init];
    [self.navigationController pushViewController:IPCV animated:NO];
    self.tabBarController.tabBar.hidden=YES;


}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sdk = [AnjubaoSDK instance];
    voiceController = [VoiceController voiceController];
    
    map = [[NSMutableDictionary alloc] init];
    AJBUserGetAddress* address = [sdk userGetAddress];
    
    if (address && address.res == ErrorCode_ERR_OK) {
        userAddress = address;
        [map removeAllObjects];
        ipcNameList1= [[NSMutableArray alloc] init];
        
        NSString *stronli;
        //        NSString *address=[address]
        
        for (AJBAddressInfo* a in [address my_address]) {
            
            for (AJBIpcInfomation* i in [a ipcs]) {
                NSString* ipcName1 =
                [NSString stringWithFormat:@"%@", i.ipc_serial_number];
                NSString* ipcName = [NSString stringWithFormat:@"%@_%@", a.name, i.ipc_serial_number];
                NSString *stronline=[NSString stringWithFormat:@"%@",i.online?@"YES":@"NO"];
                if ([stronline containsString:@"YES"]) {
                    stronli=[NSString stringWithFormat:@"在线"];
                }else{
                    stronli=[NSString stringWithFormat:@"不在线"];
                }
                
                [map setObject:i
                        forKey:ipcName];
                
                [ipcNameList1 addObject:ipcName1];
                
            }
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
