//
//  XdLiuTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "XdLiuTableViewCell.h"
#import "CustomTextField.h"
@implementation XdLiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _contentTextField.placeholder = @"选填:对本次交易的说明";
    _contentTextField.borderStyle = UITextBorderStyleNone;
    // Initialization code
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.contentTextField becomeFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
