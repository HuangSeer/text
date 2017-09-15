//
//  TouTiaoModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouTiaoModel : NSObject

@property (strong, nonatomic) NSString *NewsId;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *EditDate;
@property (strong, nonatomic) NSString *DeptName;
@property (strong, nonatomic) NSString *ModuName;

//第二次改版
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *type;
@end
