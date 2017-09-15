//
//  ZUzhiModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//
//DepartsId = 0;
//DepartsName = "\U65e0";
//NewsGroup = All;
//deptId = 854;
//id = 2;
//idCard = 123456789321456789;
//image = "/UpLoadFiles/image/News/20170526191647639670.png";
//name = "\U6768\U7fa4";
//organize = "\U9c81\U80fd\U897f\U5927\U793e\U533a\U515a\U59d4\U4e8c\U652f\U90e8";
//pid = 10;
//position = "\U9c81\U80fd\U897f\U8def\U793e\U533a\U652f\U90e8\U4e66\U8bb0";
//rank = "\U652f\U90e8\U4e66\U8bb0";
//shzt = 1;
//
#import <Foundation/Foundation.h>

@interface ZUzhiModel : NSObject
@property (nonatomic, strong)NSString *DepartsId;
@property (nonatomic, strong)NSString *DepartsName;
@property (nonatomic, strong)NSString *NewsGroup;
@property (nonatomic, strong)NSString *deptId;
@property (nonatomic, strong)NSString *idCard;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *organize;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *pid;
@property (nonatomic, strong)NSString *position;
@property (nonatomic, strong)NSString *rank;
@property (nonatomic, strong)NSString *shzt;

@end
