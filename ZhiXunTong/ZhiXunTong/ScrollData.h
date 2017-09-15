//
//  ScrollData.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJAd;
@interface ScrollData : NSObject

/** 微博作者 */
@property (strong, nonatomic) MJAd *mjad;
/** 转发的微博 */
//广告标题
@property (strong, nonatomic) NSString *Message;
@property (strong, nonatomic) ScrollData *Data;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *DeptName;
@property (strong, nonatomic) NSString *ModuName;
@property (strong, nonatomic) NSString *EditDate;
@property (strong, nonatomic) NSString *EditUserName;

@end
