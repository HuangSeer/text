//
//  QuerRSpModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//
//complaint = 0;
//count = 1;
//evaluate = 0;
//"goods_id" = 98459;
//"goods_img" = "http://192.168.1.223:8080/shopping/upload/store/32769/2014/09/25/66049433-8a3c-4ee6-9a38-7a0f4a5159ce.jpg";
//"goods_name" = "\U5c0f\U7c73\U624b\U673a\U5b98\U7f51\U5c0f\U7c732s\U7535\U6c60\U5c0f\U7c732s \U7535\U6c60\U6b63\U54c1\U5c0f\U7c732S\U539f\U88c5\U7535\U6c60\U5c0f\U7c732\U7535\U6c60";
//"goods_price" = 199;
//price = 99;
//"spec_info" = "";
//"store_id" = 32769;
#import <Foundation/Foundation.h>
@interface QuerRSpModel : NSObject
@property (assign,nonatomic)NSInteger complaint;
@property (copy,nonatomic)NSString *count;
@property (copy,nonatomic)NSString *evaluate;
@property (copy,nonatomic)NSString *goods_id;
@property (strong,nonatomic)NSString *goods_img;
@property (copy,nonatomic)NSString *goods_name;
@property (strong,nonatomic)NSString *goods_price;
@property (strong,nonatomic)NSString *price;
@property (copy,nonatomic)NSString *spec_info;
@property (strong,nonatomic)NSString *store_id;

@end
