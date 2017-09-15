//
//  YfZDBTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "YfZDBTableViewCell.h"

@implementation YfZDBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _butdd.layer.borderColor = [[UIColor redColor] CGColor];
    _butdd.layer.borderWidth = 0.5f;
    [_butdd.layer setMasksToBounds:YES];
    [_butdd.layer setCornerRadius:5.0]; //设置矩圆角半径
    
    _butsure.layer.borderColor = [[UIColor redColor] CGColor];
    _butsure.layer.borderWidth = 0.5f;
    [_butsure.layer setMasksToBounds:YES];
    [_butsure.layer setCornerRadius:5.0]; //设置矩圆角半径
    // Initialization code
}
- (IBAction)Buttonblock:(UIButton *)sender {
    if (self.addToCartsBlock) {
        self.addToCartsBlock(self);
    }
}
- (IBAction)ButSureBlock:(UIButton *)sender {
    if (self.butSureBlocks) {
        self.butSureBlocks(self);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
