//
//  CouponViewController.h
//  LeBao
//
//  Created by 小黄人 on 2017/4/25.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CeBackBlcok) (NSString  *intrid,NSString *strbb,NSString *stra);//1
@interface CouponViewController : UIViewController
@property (nonatomic,copy)CeBackBlcok ceBackBlock;//2
@property(nonatomic,strong)NSArray *Cyhqtwoarry;
@property(nonatomic,strong)NSString *strprice;
@property(nonatomic,strong)NSMutableArray *straarray;
@end
