


//
//  KaoQViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "KaoQViewController.h"
#import "PchHeader.h"
#import "HHAlertView.h"

@interface KaoQViewController ()<MAMapViewDelegate, AMapLocationManagerDelegate,HHAlertViewDelegate>{
    
    NSString *DateTime;
    UIView *view;
    NSString *strdw;
    NSArray *arraydw ;
    NSMutableArray *arrmudw;
    UIButton *butdw;
    NSString *strcookie;
    NSString *strcode;
     NSString *strdww;
    NSString *strdate;
    NSDateFormatter *formatter2;
}
@property (nonatomic, strong) UISegmentedControl *showSegment;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@end

@implementation KaoQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
    [ZQLNetWork getWithUrlString:[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/work/addStaffClockInInfo.do?start_time=&start_site=&start_memo=&Cookie=%@",strcookie] success:^(id data) {
        NSLog(@"---------------%@",data);
        strcode =[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"] ];
//        [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
//        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
    [self initMapView];
    self.navigationItem.title=@"考勤打卡";
    [self configLocationManager];
    //    __block ViewController weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    [self viewbut];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
-(void)timeFireMethod{
    NSDate *date = [NSDate date];
     formatter2= [[NSDateFormatter alloc] init];
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [componets weekday];//a就是星期几，1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    strdate= [NSString stringWithFormat:@"%@",[formatter2 stringFromDate:date]];
    DateTime= [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [view removeFromSuperview];
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height/4.5)];
    
    [self.view addSubview:view];
    NSArray *array = [DateTime componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    UILabel *labnyr=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/3,10, Screen_Width/3, 20)];
    labnyr.text=[NSString stringWithFormat:@"%@",array[0]];
    labnyr.textAlignment = UITextAlignmentCenter;
    labnyr.textColor=[UIColor blackColor];
    labnyr.font=[UIFont systemFontOfSize:16.0f];
    [view addSubview:labnyr];
    UILabel *labxq=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/3,30, Screen_Width/3, 20)];
    labxq.text=weekStr;
    labxq.textAlignment = UITextAlignmentCenter;
    labxq.textColor=[UIColor blackColor];
    labxq.font=[UIFont systemFontOfSize:16.0f];
    [view addSubview:labxq];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, Screen_Width, view.frame.size.height-70)];
    lab.text=[NSString stringWithFormat:@"%@",array[1]];
    lab.textColor=[UIColor redColor];
    lab.textAlignment = UITextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:50.0f];
    [view addSubview:lab];
    
    
    
}
-(void)viewbut{
    UIView *viewdatax=[[UIView alloc]initWithFrame:CGRectMake(5, 55, Screen_Width-10, 0.5)];
    viewdatax.backgroundColor=RGBColor(224, 224, 224);
    [self.view addSubview:viewdatax];
    UIView *viewfgx=[[UIView alloc]initWithFrame:CGRectMake(0,  Screen_height/4.5, Screen_Width, 7)];
    viewfgx.backgroundColor=RGBColor(224, 224, 224);
    [self.view addSubview:viewfgx];
    
    UIView *viewzx=[[UIView alloc]initWithFrame:CGRectMake(5, Screen_height/2.2, Screen_Width-10, 0.5)];
    viewzx.backgroundColor=RGBColor(224, 224, 224);
    [self.view addSubview:viewzx];
    UIButton *butdk=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-80)/2,  Screen_height/3.8,90, 90)];
    [butdk setBackgroundImage:[UIImage imageNamed:@"按钮.png"] forState:UIControlStateNormal];
    [butdk setTitle:@"打卡" forState:UIControlStateNormal];
    [butdk setFont:[UIFont systemFontOfSize:19.0f]];
    
    [butdk addTarget:self action:@selector(butdkClick) forControlEvents:UIControlEventTouchUpInside];
    [butdk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:butdk];
    
    butdw=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-170)/2,Screen_height/2.15, 170, 20)];
    //从字符A中分隔成2个元素的数组
    [butdw setImage:[UIImage imageNamed:@"定位.png"] forState:UIControlStateNormal];
    [butdw setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butdw setFont:[UIFont systemFontOfSize:11.0f]];
    [self.view addSubview:butdw];
}
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];

    // 带逆地理信息的一次定位（返回坐标和地址信息）
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =10;
//    //   逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 10;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    
}
#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@" amapLocationManager = %@", [manager class]);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    
    //获取到定位信息，更新annotation
    
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        
        [self.mapView addAnnotation:self.pointAnnotaiton];
    }
    
    [self.pointAnnotaiton setCoordinate:location.coordinate];
    
    [self.mapView setCenterCoordinate:location.coordinate];
    [self.mapView setZoomLevel:18 animated:NO];
    if (reGeocode)
    {
        [arrmudw removeAllObjects];
        
        strdw=[NSString stringWithFormat:@"%@",reGeocode.POIName];
        arraydw= [strdw componentsSeparatedByString:@"("];
        arrmudw = [[NSMutableArray alloc] init];
        [arrmudw addObjectsFromArray:arraydw];
        
        strdww=[NSString stringWithFormat:@"%@",arrmudw[0]];
        [butdw setTitle:[NSString stringWithFormat:@"当前位置:%@附近",strdww] forState:UIControlStateNormal];
        
        NSLog(@"reGeocode:%@reGeocode:%@",arrmudw,arraydw);
    }
    
}
#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, Screen_height/1.9, Screen_Width, Screen_height/2.3)];
        [self.mapView setDelegate:self];
        
        [self.view addSubview:self.mapView];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}

-(void)butdkClick{
//    http://192.168.1.223:8080/grid/app/user/login.do?userName=zs&password=123&code=
    
    if ([strcode containsString:@"202"]) {
        if (strdww.length!=0&&strdate.length!=0) {
      NSString *usdf = [strdww stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *datastr = [strdate stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/work/addStaffClockInInfo.do?start_time=%@&start_site=%@&start_memo=ss&Cookie=%@",datastr,usdf,strcookie];
    NSLog(@"strurl2==2=2=2=2====%@",strurl);
     [ZQLNetWork getWithUrlString:strurl success:^(id data) {
    [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"" detail:@"考勤成功" cancelButton:nil Okbutton:@"确定" block:^(HHAlertButton buttonindex) {
                    if (buttonindex == HHAlertButtonOk) {
                            NSLog(@"ok Button is seleced use block");
                        }
                        else
                        {
                            NSLog(@"cancel Button is seleced use block");
                        }
                    }];

//        [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
        }else{
        
       }
            
    }
        else{
        
        [SVProgressHUD showErrorWithStatus:@"你今日已签到"];
        
    }
 
    
    

   
    }
     
     
     
- (void)didReceiveMemoryWarning {
         [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }
     
     
     @end
