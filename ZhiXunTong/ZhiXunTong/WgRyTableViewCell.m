//
//  WgRyTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WgRyTableViewCell.h"

@implementation WgRyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setWgM:(WgModel *)WgM{
    _WgM=WgM;
    self.labone.text=[NSString stringWithFormat:@"%@",WgM.gridStaffName];
        self.labtwo.text=[NSString stringWithFormat:@"%@",WgM.gridStaffScope];
        self.labthree.text=[NSString stringWithFormat:@"%@",WgM.gridStaffSex];
        self.labfour.text=[NSString stringWithFormat:@"%@",WgM.gridStaffTel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
