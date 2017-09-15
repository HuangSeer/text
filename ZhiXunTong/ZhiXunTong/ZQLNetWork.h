//
//  ZQLNetWork.h
//  ZQL_LOL
//
//  Created by teacher on 16-12-26.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>


//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

@interface ZQLNetWork : NSObject
//get请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;

//post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;
// post上传头像
//+(void)postAvaterWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters imageData:(UIImage *)image  success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
