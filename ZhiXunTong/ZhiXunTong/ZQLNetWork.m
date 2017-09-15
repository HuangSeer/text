//
//  ZQLNetWork.m
//  ZQL_LOL
//
//  Created by teacher on 16-12-26.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "ZQLNetWork.h"
#import "PchHeader.h"

@interface ZQLNetWork()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation ZQLNetWork

+(AFHTTPSessionManager *)manager
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];

    return manager;
}

//GET请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure{
//    [SVProgressHUD showProgress:1.0];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
    //get请求
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度：%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *netDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments|NSJSONReadingMutableLeaves error:nil];
        success(netDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
//    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
}

//POST请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure{
//    [SVProgressHUD showProgress:1.0];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    //post请求
    [manager POST:urlString parameters:parameters progress:
     ^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"进度：%@",downloadProgress);
     }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSMutableDictionary *netDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments|NSJSONReadingMutableLeaves error:nil];
         
         success(netDic);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
         failure(error);
     }];
//    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
}
+(void)postAvaterWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters imageData:(UIImage *)image  success:(HttpSuccess)success failure:(HttpFailure)failure{

    [[self manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImageJPEGRepresentation(image, 0.6);
        [formData appendPartWithFormData:data name:[NSString stringWithFormat:@"%@.jpg",@"avater"]];

        NSLog(@"------%@",data);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];

}

@end
