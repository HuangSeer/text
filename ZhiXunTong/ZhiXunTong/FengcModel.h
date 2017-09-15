//
//  FengcModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//
//CoverImg = "";
//id = 1;
//shzt = 1;
//tablename = "MP_Volunteer";
//time = "2015/12/2 0:00:00";
//title = "\U9f99\U5854\U8857\U9053\U9c81\U80fd\U897f\U8def\U793e\U533a\U5fd7\U613f\U8005\U62db\U52df\U901a\U77e5";
#import <Foundation/Foundation.h>

@interface FengcModel : NSObject

@property (nonatomic, strong)NSString *CoverImg;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *NewsGroup;
@property (nonatomic, strong)NSString *shzt;
@property (nonatomic, strong)NSString *intro;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSString *title;

@end
