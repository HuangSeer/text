//
//  GonggaoTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GonggaoTableViewCell.h"

@implementation GonggaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setGongGaoM:(GongGaoModel *)GongGaoM{
    _GongGaoM=GongGaoM;
    self.labbt.text=[NSString stringWithFormat:@"%@",GongGaoM.Atitle];
    NSArray *array = [GongGaoM.Atime componentsSeparatedByString:@" "]; //从字符A中分隔成2
    NSString *strUrl = [array[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    self.labtime.text=[NSString stringWithFormat:@"%@",strUrl];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
