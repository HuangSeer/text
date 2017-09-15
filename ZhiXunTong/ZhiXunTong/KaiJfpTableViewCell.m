//
//  KaiJfpTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "KaiJfpTableViewCell.h"

@implementation KaiJfpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labgs.lineBreakMode = NSLineBreakByWordWrapping;
    self.labgs.numberOfLines = 0;
    // Initialization code
}
- (IBAction)GerenBlock:(UIButton *)sender {
    if (self.addToGerenBlock) {
        self.addToGerenBlock(self);
    }
}
- (IBAction)GsiBlock:(UIButton *)sender {
    if (self.addTogsBlock) {
        self.addTogsBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
