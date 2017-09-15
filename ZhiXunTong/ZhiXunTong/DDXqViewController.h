//
//  DDXqViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface DDXqViewController : UIViewController
@property(nonatomic,assign)NSString *DDid;

@property(nonatomic,assign)NSString *DDaddTime;//下单时间
@property(nonatomic,assign)NSString *DDaddr_info;//地址
@property(nonatomic,assign)NSString *DDbutton_text;//状态
@property(nonatomic,assign)NSArray *DDgcs;//商品有多少个
@property(nonatomic,assign)OrderModel *DDmodel;


@end
