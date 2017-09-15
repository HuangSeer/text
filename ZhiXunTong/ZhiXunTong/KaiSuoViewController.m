//
//  KaiSuoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "KaiSuoViewController.h"
#import "PchHeader.h"
#import "BLEPortal.h"
@interface KaiSuoViewController ()
{
    BLEPortal *portal;
    UILabel *lable;
    NSString *lianjie;
    NSString *dianliang;
    NSString *suozhuangtai;
    BOOL wo;
    
    NSString *qq;//设备pwd
    NSString *yy;//设备id
}
@end

@implementation KaiSuoViewController
//车位锁
-(void)viewDidAppear:(BOOL)animated
{

}
-(id)initLockKey:(NSString *)lockKey LockNum:(NSString *)lockNum
{
    if (self=[super init]){
        qq=lockKey;
        yy=lockNum;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showWithStatus:@"加载中"];
    portal=[BLEPortal instance];
    [portal startScan:^(NSString *lockName){
        if (lockName!=nil) {
            NSLog(@"已经找到==%@",lockName);
            [SVProgressHUD dismiss];
            [self connect];
        }
        else
        {
            portal.timeout=10;
            [SVProgressHUD dismiss];
            NSLog(@"没连上再试试吧");
        }
    }];
    [self DaoHang];
}
-(void)DaoHang
{
    self.navigationItem.title=@"车位锁";
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 280)];
    imgView.image=[UIImage imageNamed:@"背景1"];
    
    UIImageView *tubiao=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width/2-80, 30, 160, 160)];
    tubiao.image=[UIImage imageNamed:@"logoChewei"];
    [imgView addSubview:tubiao];
    lable=[[UILabel alloc] initWithFrame:CGRectMake(30, tubiao.frame.size.width+30, Screen_Width-60, 60)];
    
    lable.numberOfLines=2;
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [imgView addSubview:lable];
    
    [self.view addSubview:imgView];
    
    UIButton *btnShen=[[UIButton alloc] initWithFrame:CGRectMake(40, 320, 80, 80)];
    [btnShen setImage:[UIImage imageNamed:@"升"] forState:UIControlStateNormal];
    [btnShen addTarget:self action:@selector(SBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShen];
   
    UIButton *btnJiang=[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-120, 320, 80, 80)];
    [btnJiang setImage:[UIImage imageNamed:@"降"] forState:UIControlStateNormal];
    [btnJiang addTarget:self action:@selector(JBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJiang];
}
-(void)SBtn
{
    NSLog(@"升");
    wo=NO;
    [SVProgressHUD showWithStatus:@"加载中"];
    [portal lock:^(BOOL isSuc,BLE_ERROR error,id data){
        [self getState];
        if (isSuc) {
            [SVProgressHUD showSuccessWithStatus:@"上升成功"];
           // [self showAlert:@"success"];
        }else{
           // [self showAlert:@"failed"];
            [SVProgressHUD showErrorWithStatus:@"上升失败"];
        }
    }];
}
-(void)JBtn
{
    wo=NO;
    NSLog(@"降");
    [SVProgressHUD showWithStatus:@"加载中"];
    [portal unlock:^(BOOL isSuc,BLE_ERROR error,id data){
        [self getState];
        if (isSuc) {
            [SVProgressHUD showSuccessWithStatus:@"成功下降"];
            //[self showAlert:@"成功下降"];
        }else{
            [SVProgressHUD showErrorWithStatus:@"下降失败"];
            //[self showAlert:@"下降失败"];
        }
    }];
}
-(void)connect{
    [SVProgressHUD showWithStatus:@"加载中"];
    portal.lockName=yy;//0000742   //6475530000742
    portal.pwd=qq;//mac: 6472D8C72778  key: U48bJ3J4
    [portal connect:^(BOOL isSuc,BLE_ERROR error,id data){
        if (isSuc) {
            [self getState];
            //[self showAlert:@"success"];
            wo=YES;
            lianjie=@"连接成功";
        }else{
            [self showAlert:@"failed"];
           // [SVProgressHUD showErrorWithStatus:@"连接失败"];
        }
    }];
}
-(void)disconnect{
    [portal disconnect:^(BOOL isSuc,BLE_ERROR error,id data){
        if (isSuc) {
           // [self showAlert:@"success"];
        }else{
           // [self showAlert:@"failed"];
        }
    }];
}
-(void)getState{
    [portal getState:^(BOOL isSuc,BLE_ERROR error,id data){
        if (isSuc) {
            LockState *state=data;
            if ((long)state.power==3) {
                NSLog(@"电量充足");
                dianliang=@"电量充足";
            }
            else if ((long)state.power==0){
                NSLog(@"电量不足");
                dianliang=@"电量不足";
            }
            else{
                NSLog(@"电量正常");
                dianliang=@"电量正常";
            }
            //@property DEVICE_POWER power;电量
            //@property DEVICE_STATE state;升降状态
            if ((long)state.state==0) {
                NSLog(@"关锁状态");
                suozhuangtai=@"关锁状态";
            }
            else if((long)state.state==1){
                NSLog(@"开锁状态");
                suozhuangtai=@"开锁状态";
            }
            else if((long)state.state==2){
                NSLog(@"下降遇阻");
                suozhuangtai=@"下降遇阻";
            }
            else if((long)state.state==3){
                NSLog(@"上升遇阻");
                suozhuangtai=@"上升遇阻";
            }
            lable.text=[NSString stringWithFormat:@"%@,%@,%@",lianjie,dianliang,suozhuangtai];
            if (wo==YES) {
                [SVProgressHUD showSuccessWithStatus:@"连接成功"];
            }
            
        }else{
            LockState *state=data;
            NSLog(@"state:=%ld",(long)state.state);
            [SVProgressHUD showSuccessWithStatus:@"连接失败"];
           // [self showAlert:@"失败"];
        }
    }];
}

- (void)showAlert:(NSString *) _message{//时间
    //NSLog(_message);
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [promptAlert show];
}

-(UIButton *)createBtn{
    UIButton *btn=[[UIButton alloc]init];
    [btn.layer setBorderWidth:1.0];
    
    UIColor *blackColor=[[UIColor alloc] initWithWhite:0 alpha:1];
    
    [btn setTitleColor:blackColor forState:UIControlStateNormal];
    [btn.layer setBorderColor:blackColor.CGColor];
    return btn;
}

-(void)btnCkmore{
    [self disconnect];
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
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
