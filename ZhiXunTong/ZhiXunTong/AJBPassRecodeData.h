//
//  AJBPassRecodeData.h
//  AJBDoor
//
//  Created by ZYP on 16/7/19.
//  Copyright © 2016年 ANJUBAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJBPassRecodeDataDelegate <NSObject>

/// 加载数据成功 keys 是数据数组
- (void)AJBPassRecodeDataDidLoadData:(NSArray *)keys;

/// 加载数据失败 Msg  是错误信息
- (void)AJBPassRecodeDataDidFailLoadData:(NSString *)Msg;

@end

@interface AJBPassRecodeData : NSObject

/* 代理 **/
@property (nonatomic,weak) id <AJBPassRecodeDataDelegate>delegate;

/**
 *  @author ZYP
 *
 *  初始化方法
 *
 *  @param host 服务器地址
 *  @param port 服务器端口
 *
 *  @return 此对象
 */
- (instancetype)initWithHost:(NSString *)host Port:(NSInteger )port;

/**
 *  @author ZYP
 *
 *  请求数据
 *
 *  @param userId     用户ID
 *  @param estatecode 6位小区号
 *  @param housecode  8位楼栋号
 */
- (void)RequestDataWithUserId:(NSString *)userId estatecode:(NSString *)estatecode housecode:(NSString *)housecode;

@end
