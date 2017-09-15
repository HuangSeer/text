//
//  FanfuTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FanfuModel.h"

@interface FanfuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagefd;
@property (weak, nonatomic) IBOutlet UILabel *labfd;
@property (copy, nonatomic)FanfuModel *FanfuM;
@end
