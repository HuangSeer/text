//
//  FengcTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FengcTableViewCell.h"
#import "PchHeader.h"

@implementation FengcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labbt setNumberOfLines:0];
    // Initialization code
}
-(void)setFengcM:(FengcModel *)FengcM{
    _FengcM=FengcM;
      [self.imagefc sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:FengcM.CoverImg ]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labfcname.text=[NSString stringWithFormat:@"%@",FengcM.title];
        self.labbt.text=[NSString stringWithFormat:@"%@",FengcM.intro];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
