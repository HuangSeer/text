//
//  AJBOwnerQRData.h
//  AJBDoor
//
//  Created by ZYP on 16/7/11.
//  Copyright © 2016年 ANJUBAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJBOwnerQRDataDelegate <NSObject>

/// 加载数据成功 keys 是数据数组
- (void)AJBOwnerQRDataDidLoadData:(NSDictionary *)key;

/// 加载数据失败 Msg  是错误信息
- (void)AJBOwnerQRDataDidFailLoadData:(NSString *)Msg;

@end

@interface AJBOwnerQRData : NSObject

/* 代理 **/
@property (nonatomic,weak) id <AJBOwnerQRDataDelegate>delegate;

/**
 *
 *  初始化方法
 *
 *  @param host 服务器地址
 *  @param port 服务器端口
 *
 *  @return 此实例对象
 */
- (instancetype)initWithHost:(NSString *)host Port:(NSInteger )port;

/**
 *
 *  请求数据（结果通过代理方法回调）
 *
 *  @param userId     用户ID
 *  @param estatecode 6位小区号
 *  @param housecode  8位楼栋号
 */
- (void)RequestDataWithUserId:(NSString *)userId estatecode:(NSString *)estatecode housecode:(NSString *)housecode;

@end
