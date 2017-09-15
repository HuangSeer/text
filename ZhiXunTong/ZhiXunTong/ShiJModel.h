//
//  ShiJModel.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//     areaId = 22;
//blogContent = Hhdhd;
//blogId = 38;
//blogName = "2017-5-10";
//blogPic = "images/app/blog/zs/20170510134301221.png;images/app/blog/zs/20170510134301574.png;images/app/blog/zs/20170510134301832.png;";
//blogType = "2,3,";
//editBlogDate = "2017-05-10 13:43:01";
//gridId = 1;

#import <Foundation/Foundation.h>

@interface ShiJModel : NSObject
@property (nonatomic, strong)NSString *blogName;
@property (nonatomic, strong)NSString *blogType;
@property (nonatomic, strong)NSString *editBlogDate;
@property (nonatomic, strong)NSString *blogContent;
@property (nonatomic, strong)NSString *blogPic;

@property (nonatomic, strong)NSString *list;
//@property (nonatomic, strong)NSArray *data;
@end
