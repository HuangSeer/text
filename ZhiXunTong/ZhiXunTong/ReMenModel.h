//
//  ReMenModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/22.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReMenModel : NSObject
//热门话题
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *count;
@property (nonatomic, strong)NSString *vote;
@property (nonatomic, strong)NSString *id;

//物业推荐
@property (nonatomic, strong)NSString *imgurl;
//@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *url;

//物业公示
@property (nonatomic, strong)NSString *EditDate;
@property (nonatomic, strong)NSString *ReDate;
@property (nonatomic, strong)NSString *OpinionId;
@property (nonatomic, strong)NSString *AuditName;
@property (nonatomic, strong)NSString *Title;
@property (nonatomic, strong)NSString *OpinionClassName;
@end
