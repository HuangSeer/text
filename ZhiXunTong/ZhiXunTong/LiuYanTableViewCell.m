//
//  LiuYanTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LiuYanTableViewCell.h"

@implementation LiuYanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     _textfiledly.placeholder = @"请输入你想说的话";
    _textfiledly.borderStyle = UITextBorderStyleNone;
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
