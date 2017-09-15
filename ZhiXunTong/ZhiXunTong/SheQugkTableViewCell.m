//
//  SheQugkTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SheQugkTableViewCell.h"

@implementation SheQugkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSheQuM:(SheQuModel *)SheQuM{
    _SheQuM=SheQuM;
    self.labshequ.text=[NSString stringWithFormat:@"[%@]",SheQuM.DeptName];
    self.labtitle.text=[NSString stringWithFormat:@"%@",SheQuM.Title];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
