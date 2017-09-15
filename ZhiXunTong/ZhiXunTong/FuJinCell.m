//
//  FuJinCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FuJinCell.h"

@implementation FuJinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _labnr.numberOfLines = 0;//这句一定要写
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
