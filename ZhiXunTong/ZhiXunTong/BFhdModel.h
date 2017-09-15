//
//  BFhdModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//  Aid = 4;
//CoverImg = "";
//content =
//id = 1;
//time = "2015/5/16 0:00:00";
//title = "\U5f00\U5c55\U6276\U8d2b\U5e2e\U56f0\U732e\U7231\U5fc3\U6d3b\U52a8";

#import <Foundation/Foundation.h>

@interface BFhdModel : NSObject
@property (nonatomic, strong)NSString *Aid;
@property (nonatomic, strong)NSString *CoverImg;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *title;
@end
