//
//  DyTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DyTableViewCell.h"

@implementation DyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labmz.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.labmz.layer.borderWidth = 0.5;//边框宽度
    self.labbd.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.labbd.layer.borderWidth = 0.5;//边框宽度
    self.labyear.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.labyear.layer.borderWidth = 0.5;//边框宽度
    self.labphone.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.labphone.layer.borderWidth = 0.5;//边框宽度
    self.lanage.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.lanage.layer.borderWidth = 0.5;//边框宽度
    self.lanname.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    self.lanname.layer.borderWidth = 0.5;//边框宽度
    // Initialization code
}
-(void)setDyMo:(DyModel *)DyMo{
    _DyMo=DyMo;


}
//192.168.1.222:8099/api/APP1.0.aspx?method=floating&DeptId=851&Key=21218CCA77804D2BA1922C33E0151105&TVInfoId=4
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
