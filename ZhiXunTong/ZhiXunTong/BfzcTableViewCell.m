



//
//  BfzcTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BfzcTableViewCell.h"

@implementation BfzcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)setZCM:(ZCModel *)ZCM{
    _ZCM=ZCM;
    self.labtitle.text=[NSString stringWithFormat:@"%@",ZCM.title];
    NSArray *array = [ZCM.time componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
 self.labtime.text=[NSString stringWithFormat:@"%@",array[0]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
