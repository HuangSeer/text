//
//  DdAddressTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DdAddressTableViewCell.h"

@implementation DdAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDiZhiM:(DiZhiModel *)DiZhiM{
    _DiZhiM=DiZhiM;
    self.labname.text=[NSString stringWithFormat:@"%@",DiZhiM.trueName];
    self.labaddress.text=[NSString stringWithFormat:@"%@%@",DiZhiM.areaName,DiZhiM.area_info];
    self.labphone.text=[NSString stringWithFormat:@"%@",DiZhiM.mobile];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
