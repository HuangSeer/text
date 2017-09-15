//
//  AddCheWeiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddCheWeiViewController.h"
#import "PchHeader.h"
#import <AVFoundation/AVFoundation.h>
#import "SGQRCodeScanningVC.h"
@interface AddCheWeiViewController (){
    UITextField *textId;
    UITextField *textName;
    
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
}

@end

@implementation AddCheWeiViewController
//添加车位
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
   
    [self DaoHang];
    //通知中心是个单例
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(receiveNotification:) name:@"cesuo" object:nil];
}
- (void)receiveNotification:(NSNotification *)noti
{
    NSLog(@"%@ === %@ === %@", noti.object, noti.userInfo, noti.name);
    textId.text=[NSString stringWithFormat:@"%@",noti.userInfo];
}
-(void)DaoHang
{
    self.navigationItem.title=@"车位锁添加";
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setImage:[UIImage imageNamed:@"sao57x57"] forState:UIControlStateNormal];
    //[backFen setTitle:@"扫一扫" forState:UIControlStateNormal];
    //[backFen setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(btnSao) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
    
    
    UILabel *alable=[[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 30)];
    alable.text=@"设备ID:";
    alable.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:alable];
    
    UILabel *blable=[[UILabel alloc] initWithFrame:CGRectMake(10, 90, 80, 30)];
    blable.text=@"设备名称:";
    blable.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:blable];
    
    textId=[[UITextField alloc] initWithFrame:CGRectMake(95, 40, Screen_Width-115, 30)];
    textId.backgroundColor=[UIColor grayColor];
    textId.placeholder=@"推荐使用扫码";
    [self.view addSubview:textId];
    
    textName=[[UITextField alloc] initWithFrame:CGRectMake(95, 90, Screen_Width-115, 30)];
    textName.backgroundColor=[UIColor grayColor];
    textName.placeholder=@"请填写设备名称";
    [self.view addSubview:textName];
    
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width/2-40, 150, 80, 40)];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnTianJia) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
}
-(void)BtnTianJia
{
    [SVProgressHUD showWithStatus:@"加载中"];
    [[WebClient sharedClient] CWSuoTianjia:aatvinfo Keys:aakey UserId:aaid Name:textName.text Num:textId.text ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSString *ad=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Status"]];
        NSString *msg=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"Message"]];
        int edg=[ad intValue];
        if (edg==1) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self btnCkmore];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)btnSao
{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [self presentViewController:vc animated:NO completion:nil];
                       // [self.navigationController pushViewController:vc animated:YES];
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            //[self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
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
