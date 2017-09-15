//
//  KaoQViewController.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface KaoQViewController : UIViewController
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@end
