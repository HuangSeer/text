//
//  AddressGLTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddressGLTableViewCell.h"
#import "PchHeader.h"

@implementation AddressGLTableViewCell

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
- (IBAction)addToCartsBlock:(UIButton *)sender {
    if (self.addToCartsBlock) {
        self.addToCartsBlock(self);
    }
}
- (IBAction)lodaBlock:(UIButton *)sender {
    if (self.lodaBlock) {
        self.lodaBlock(self);
    }
}


@end
