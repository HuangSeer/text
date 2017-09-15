//
//  BfHdTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFhdModel.h"

@interface BfHdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imaghd;
@property (weak, nonatomic) IBOutlet UILabel *labhdbt;
@property (weak, nonatomic) IBOutlet UILabel *labtimthd;
@property (copy, nonatomic)BFhdModel *BFhdM;
@end
