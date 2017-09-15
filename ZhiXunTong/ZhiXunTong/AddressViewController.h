//
//  AddressViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "diyi.h"
@interface AddressViewController : UIViewController
@property (nonatomic,copy) void (^addressBlock)(NSString *model);
@end
