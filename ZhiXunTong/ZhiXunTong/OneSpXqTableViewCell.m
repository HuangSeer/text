//
//  OneSpXqTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "OneSpXqTableViewCell.h"

@implementation OneSpXqTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      _labbt.numberOfLines = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
