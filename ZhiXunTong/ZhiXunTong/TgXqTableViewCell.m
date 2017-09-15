//
//  TgXqTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/9.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TgXqTableViewCell.h"

@implementation TgXqTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lab1.numberOfLines = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
