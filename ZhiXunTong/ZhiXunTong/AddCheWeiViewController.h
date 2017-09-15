//
//  AddCheWeiViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCheWeiViewController : UIViewController
@property (nonatomic,copy) void (^addressBlock)(NSString *model);
@end
