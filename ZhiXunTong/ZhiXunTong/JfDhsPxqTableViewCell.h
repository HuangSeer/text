//
//  JfDhsPxqTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JfdhModel.h"

@interface JfDhsPxqTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagetp;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labjg;
@property (weak, nonatomic) IBOutlet UILabel *labnum;
@property (copy, nonatomic)  JfdhModel *JfdhM;
@end
