//
//  BangDingViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/21.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
//先定义一个有参数,参数类型为NSString * 类型,无返回值的block类型
typedef void(^Myblock)(NSString *title,NSString *xqid);
@interface BangDingViewController : UIViewController

@property(nonatomic,copy) Myblock frstBlock;

-(void)testANewBlock:(Myblock) block;

@end
