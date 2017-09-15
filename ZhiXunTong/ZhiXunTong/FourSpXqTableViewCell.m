//
//  FourSpXqTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FourSpXqTableViewCell.h"
#import "PchHeader.h"

@implementation FourSpXqTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSpPlM:(SpPlModel *)SpPlM{
    _SpPlM=SpPlM;
     [_imgtx sd_setImageWithURL:[NSURL URLWithString:SpPlM.userIcon]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _labname.text=[NSString stringWithFormat:@"%@",SpPlM.userName];
     _labpl.text=[NSString stringWithFormat:@"%@",SpPlM.evaluate_info];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
