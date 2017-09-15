//
//  AJBCustomCodeData.h
//  AJBDoor
//
//  Created by ZYP on 16/7/12.
//  Copyright © 2016年 ANJUBAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJBCustomCodeDataDelegate <NSObject>

/// 加载数据成功 key 是数据
- (void)AJBCustomCodeDataDidLoadData:(NSDictionary *)dict;

/// 加载数据失败 Msg  是错误信息
- (void)AJBCustomCodeDataDidFailLoadData:(NSString *)Msg;

@end

@interface AJBCustomCodeData : NSObject

/* 代理 **/
@property (nonatomic,weak) id <AJBCustomCodeDataDelegate> delegate;

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
 *  请求数据 QR数据
 *
 *  @param userId     用户ID
 *  @param estatecode 6位小区号
 *  @param housecode  8位楼栋号

 */
-  (void)RequestQRDataWithUserId:(NSString *)userId estatecode:(NSString *)estatecode housecode:(NSString *)housecode guestName:(NSString *)guestName;

/**
 *  @author ZYP
 *
 *  请求数据 TemPass数据
 *
 *  @param userId     用户ID
 *  @param estatecode 6位小区号
 *  @param housecode  8位楼栋号
 *  @param guestName  访客名称
 */
-  (void)RequestTemPassDataWithUserId:(NSString *)userId estatecode:(NSString *)estatecode housecode:(NSString *)housecode guestName:(NSString *)guestName;

@end
