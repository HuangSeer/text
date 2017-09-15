//
//  YHqModel.h
//  LeBao
//
//  Created by 小黄人 on 2017/5/8.
//  Copyright © 2017年 小黄人. All rights reserved.
//
//"coupon_amount" = 20;
//"coupon_begin_time" = "2014-09-01 00:00:00";
//"coupon_end_time" = "2017-10-19 00:00:00";
//"coupon_id" = 48;
//"coupon_name" = "20\U5143\U4f18\U60e0\U5238";
//"coupon_order_amount" = 200;
//"coupon_sn" = "da7765bd-c664-42d7-b446-9dc44e2afea7";
//},

#import <Foundation/Foundation.h>

@interface YHqModel : NSObject

@property(nonatomic,strong)NSString *coupon_amount;
@property(nonatomic,strong)NSString *coupon_begin_time;
@property(nonatomic,strong)NSString *coupon_end_time;
@property(nonatomic,strong)NSString *coupon_id;
@property(nonatomic,strong)NSString *coupon_name;
@property(nonatomic,strong)NSString *coupon_order_amount;
@property(nonatomic,strong)NSString *coupon_sn;

@end
