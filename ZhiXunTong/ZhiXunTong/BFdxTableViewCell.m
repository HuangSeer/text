


//
//  BFdxTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BFdxTableViewCell.h"

@implementation BFdxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
         self.labtd.numberOfLines = 0;
       self.labts.numberOfLines = 0;
       self.labxq.numberOfLines = 0;
    // Initialization code
}
-(void)setBFdxM:(BFdxModel *)BFdxM{
    _BFdxM=BFdxM;
    self.labtd.text=[NSString stringWithFormat:@"群体特点:%@",BFdxM.characteristics];
     self.labts.text=[NSString stringWithFormat:@"服务需求:%@",BFdxM.Special];
     self.labxq.text=[NSString stringWithFormat:@"特殊群体:%@",BFdxM.requirements];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
