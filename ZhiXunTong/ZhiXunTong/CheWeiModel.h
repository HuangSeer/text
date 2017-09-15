//
//  CheWeiModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheWeiModel : NSObject
@property (nonatomic)int id;
@property (nonatomic, strong)NSString *lockKey;
@property (nonatomic, strong)NSString *lockMac;
@property (nonatomic, strong)NSString *lockName;
@property (nonatomic, strong)NSString *lockNum;
@property (nonatomic, strong)NSString *userName;
@end
