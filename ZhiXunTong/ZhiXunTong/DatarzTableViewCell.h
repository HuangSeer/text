//
//  DatarzTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShiJModel.h"
#import "SjModel.h"

@interface DatarzTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labdate;
@property (weak, nonatomic) IBOutlet UILabel *labqt;
@property (weak, nonatomic) IBOutlet UILabel *labren;
@property (copy, nonatomic)ShiJModel *ShiJM;
@property (copy, nonatomic)SjModel *SjM;
@end
