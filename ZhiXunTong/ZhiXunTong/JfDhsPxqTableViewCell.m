//
//  JfDhsPxqTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JfDhsPxqTableViewCell.h"
#import "PchHeader.h"

@implementation JfDhsPxqTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setJfdhM:(JfdhModel *)JfdhM{
    _JfdhM=JfdhM;
    [_imagetp sd_setImageWithURL:[NSURL URLWithString:JfdhM.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labbt.text=[NSString stringWithFormat:@"%@",JfdhM.igc__goods_name];
      self.labjg.text=[NSString stringWithFormat:@"%@",JfdhM.igc_goods_integral];
      self.labnum.text=[NSString stringWithFormat:@"%ld",JfdhM.igc_count];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
