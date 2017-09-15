//
//  ZuZhidaTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUzhiModel.h"

@interface ZuZhidaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageone;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labname;
@property (copy, nonatomic)ZUzhiModel *ZUzhiM;
@end
