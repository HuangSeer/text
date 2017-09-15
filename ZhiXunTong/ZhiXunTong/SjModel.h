//
//  SjModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//
//areaApp =                 {
//    areaId = 0;
//    areaName = "\U9c81\U80fd\U897f\U8def\U793e\U533a\U5c45\U59d4\U4f1a";
//};
//editEventDate = "2017-05-02 18:04:51";
//eventContent = 45645646;
//eventId = 6;
//eventLevel =                 {
//    eventLevelId = 0;
//    eventLevelName = "\U7d27\U6025";
//};
//eventPic = "";
//eventTitle = 5463;
//eventType =                 {
//    eventTypeId = 0;
//    eventTypeName = "\U5bb6\U5ead\U66b4\U529b";
//};
//gridApp =                 {
//    gridId = 0;
//    gridName = "\U9c81\U80fd\U897f\U8def\U7b2c\U4e00\U7f51\U683c";
//};
//gridStaffApp =                 {
//    gridStaffId = 0;
//    gridStaffName = "\U5f20\U6770";
//    gridStaffScope = "";
//    gridStaffSex = "";
//    gridStaffTel = "";
//};
//isFinished = 0;
//isImportant = 1;
//sourceType =                 {
//    sourceTypeId = 0;
//    sourceTypeName = "\U81ea\U5df1\U53d1\U73b0";
//};
//},

#import <Foundation/Foundation.h>

@interface SjModel : NSObject
@property (nonatomic, strong)NSString *eventLevelName;
@property (nonatomic, strong)NSString *eventTitle;
@property (nonatomic, strong)NSString *editEventDate;
@property (nonatomic, strong)NSString *eventTypeName;
@property (nonatomic, strong)NSString *eventId;
@property (nonatomic, strong)NSString *eventPic;
@end
