//
//  TouPiaoTableViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TouPiaoTableViewCell.h"

@implementation TouPiaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setXZTm:(XZTModel *)XZTm{
    _XZTm=XZTm;
    self.labtp.text=[NSString stringWithFormat:@"  %@",XZTm.aname];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
