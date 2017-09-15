//
//  GonggaoTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongGaoModel.h"

@interface GonggaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labtime;
@property (copy, nonatomic)GongGaoModel *GongGaoM;
@end
