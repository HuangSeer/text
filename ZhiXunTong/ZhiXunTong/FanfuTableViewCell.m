//


//  FanfuTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FanfuTableViewCell.h"
#import "PchHeader.h"

@implementation FanfuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFanfuM:(FanfuModel *)FanfuM{
    _FanfuM=FanfuM;
    [self.imagefd sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:FanfuM.CoverImg ]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labfd.text=[NSString stringWithFormat:@"%@",FanfuM.title];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
