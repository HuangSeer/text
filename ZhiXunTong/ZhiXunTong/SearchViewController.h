//
//  SearchViewController.h
//  LeBao
//
//  Created by 小黄人 on 2017/4/7.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SousuoModel.h"

@interface SearchViewController : UIViewController
@property (nonatomic,strong) UIColor *cursorColor;//光标颜色
@property (nonatomic,strong) SousuoModel *SousuoM;
@property (assign,nonatomic) NSString *uid;
@end
