//
//  OrderModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic, strong)NSString *count;
@property (nonatomic, strong)NSString *goods_img;
@property (nonatomic, strong)NSString *goods_name;
@property (nonatomic, strong)NSString *store_name;
@property (nonatomic, strong)NSString *addr_trueName;//下单人名
@property (nonatomic, strong)NSString *to_user_id;
@property (nonatomic, strong)NSString *totalPrice;
@property (nonatomic, strong)NSString *goods_count;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *goods_id;
@property (nonatomic, strong)NSString *order_id;
@property (nonatomic, strong)NSString *complaint;//投诉
@property (nonatomic, strong)NSString *evaluate;//评价
@property (nonatomic, strong)NSString *addr_mobile;
@property (nonatomic, strong)NSString *addTime;
@property (nonatomic, strong)NSString *return_shipTime;
@property (nonatomic, strong)NSString *shipTime;
@property (nonatomic, strong)NSString *addr_info;
@property (nonatomic, strong)NSString *transport;//配送方式
@property (nonatomic, strong)NSMutableArray *gcs;
//
@property (nonatomic, strong)NSString *order_status;//状态值
@property (nonatomic, strong)NSString *button_text;
@property (nonatomic, strong)NSString *payment_mark;//支付方式
@property (nonatomic, strong)NSString *invoiceType;
@property (nonatomic, strong)NSString *coupon_amount;//优惠卷
@property (nonatomic, strong)NSString *ship_price;//运费
@end
