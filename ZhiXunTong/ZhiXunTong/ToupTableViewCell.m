


//
//  ToupTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/6/26.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ToupTableViewCell.h"

@implementation ToupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    // Initialization code
}
-(void)setXztt:(XZTModel *)xztt{
    _xztt=xztt;
      self.lab1.text=[NSString stringWithFormat:@"  %@",xztt.aname];
  self.lab4.text=[NSString stringWithFormat:@"%@票",xztt.count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
