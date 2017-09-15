//
//  DiZhiViewController.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CeellBackBlcok) (NSInteger  introw);//1
@interface DiZhiViewController : UIViewController
@property (nonatomic,copy)CeellBackBlcok ceellBackBlock;//2
@property(nonatomic,strong)NSString *strsd;
@end
