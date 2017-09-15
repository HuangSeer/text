//
//  DhJlModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DhJlModel : NSObject
@property (nonatomic, assign)NSInteger goods_count;
@property (nonatomic, strong)NSString *goods_id;
@property (nonatomic, strong)NSString *goods_integral;
@property (nonatomic, strong)NSString *goods_name;
@property (nonatomic, strong)NSString *ig_trans_fee;
@property (nonatomic, strong)NSString *image;

@property (nonatomic, strong)NSString *addTime;
@property (nonatomic, strong)NSString *order_sn;
@property (nonatomic, strong)NSString *payment;
@property (nonatomic, strong)NSString *order_status;
@property (nonatomic, strong)NSString *trans_fee;
@property (nonatomic, strong)NSString *order_id;
@property (nonatomic, strong)NSString *goods_order_id;
@property (nonatomic, strong)NSArray *integral_goods;
@end
