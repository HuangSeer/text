//
//  QuerSpTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuerRSpModel.h"

@interface QuerSpTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labts;
@property (weak, nonatomic) IBOutlet UILabel *labprice;
@property (weak, nonatomic) IBOutlet UILabel *labnum;
@property (weak, nonatomic) IBOutlet UIImageView *imagtp;
@property (weak, nonatomic) IBOutlet UILabel *labtian;
@property (copy, nonatomic)  QuerRSpModel *QuerRSpM;
@end
