



//
//  ZuZhidaTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ZuZhidaTableViewCell.h"
#import "PchHeader.h"

@implementation ZuZhidaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setZUzhiM:(ZUzhiModel *)ZUzhiM{
    _ZUzhiM=ZUzhiM;
       [self.imageone sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:ZUzhiM.image ]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _labname.text=[NSString stringWithFormat:@"%@",ZUzhiM.name];
    _labbt.text=[NSString stringWithFormat:@"%@",ZUzhiM.organize];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
