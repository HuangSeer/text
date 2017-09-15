//
//  DfcxTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DfcxTableViewCell.h"

@implementation DfcxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDfcxM:(DfcxModel *)DfcxM{
    _DfcxM=DfcxM;
    self.labtime.text=[NSString stringWithFormat:@"%@",DfcxM.time];
    self.labpeice.text=[NSString stringWithFormat:@"%@",DfcxM.Payable];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
