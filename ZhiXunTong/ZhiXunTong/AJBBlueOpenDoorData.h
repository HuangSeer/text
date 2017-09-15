//
//  AJBBlueOpenDoorData.h
//  AJBDoor
//
//  Created by ZYP on 16/7/11.
//  Copyright © 2016年 ANJUBAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AJBBlueOpenDoorDataDelegate <NSObject>

@optional

/// 加载蓝牙开门数据成功 key 是数据
- (void)AJBBlueOpenDoorDidLoadData:(NSArray *)keys;

/// 加载蓝牙开门数据失败 Msg  是错误信息
- (void)AJBBlueOpenDoorDidFailLoadData:(NSString *)Msg;

@end


@interface AJBBlueOpenDoorData : NSObject

/* 代理 **/
@property (nonatomic,weak) id <AJBBlueOpenDoorDataDelegate> delegate;

/**
 *  请求数据（结果通过代理方法回调）
 *
 *  @param host 服务器地址
 *  @param port 服务器端口
 *
 *  @return 此实例对象
 */
- (instancetype)initWithHost:(NSString *)host Port:(NSInteger )port;

/**
 *  请求数据
 *
 *  @param OringinalRoomNumStrs 16位房间号列表
 */
- (void)RequestData:(NSArray *)OringinalRoomNumStrs;

@end
