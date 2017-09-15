//
//  DQModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQModel : NSObject
@property (strong, nonatomic) NSString *CoverImg;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *shzt;
@property (strong, nonatomic) NSString *intro;

//@property (strong, nonatomic) NSString *serve;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *Eid;
@property (copy, nonatomic) NSString *categoryid;
@property (copy, nonatomic) NSString *serve;
@property (copy, nonatomic) NSString *procedures;
@property (copy, nonatomic) NSString *materials;
@property (copy, nonatomic) NSString *Responsible;




@property (nonatomic, strong)NSString *tablename;

@end
