//
//  BfHdTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BfHdTableViewCell.h"
#import "PchHeader.h"

@implementation BfHdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
      self.labhdbt.numberOfLines = 0;
    // Initialization code
}
-(void)setBFhdM:(BFhdModel *)BFhdM{
    _BFhdM=BFhdM;
      [self.imaghd sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:BFhdM.CoverImg ]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labhdbt.text=[NSString stringWithFormat:@"%@",BFhdM.title];
       NSArray *array = [BFhdM.time componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
      self.labtimthd.text=[NSString stringWithFormat:@"%@",array[0] ];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
