//
//  diyi.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface diyi : NSObject
@property (copy, nonatomic) NSString *Deptname;
@property (copy, nonatomic) NSString *DeptName;
@property (copy, nonatomic) NSString *Deptid;
@property (copy, nonatomic) NSString *NewsId;
@property (copy, nonatomic) NSString *ModuName;

@property (copy, nonatomic) NSString *Title;
@property (copy, nonatomic) NSString *EditUserName;

@property (copy, nonatomic) NSString *EditDate;
@property (strong, nonatomic) NSMutableArray *Data;
@end
