//
//  QuerSpTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/16.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "QuerSpTableViewCell.h"
#import "PchHeader.h"

@implementation QuerSpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labbt.numberOfLines = 0;
//    _labtian.layer.borderColor = [[UIColor redColor]CGColor];
//    _labtian.layer.borderWidth = 0.5f;
//    _labtian.layer.masksToBounds = YES;
}
-(void)setQuerRSpM:(QuerRSpModel *)QuerRSpM{
    _QuerRSpM=QuerRSpM;
    [_imagtp sd_setImageWithURL:[NSURL URLWithString:QuerRSpM.goods_img]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labbt.text=[NSString stringWithFormat:@"%@",QuerRSpM.goods_name];
    self.labprice.text=[NSString stringWithFormat:@"¥ %@",QuerRSpM.price];
    self.labts.text=[NSString stringWithFormat:@"原价: %@",QuerRSpM.goods_price];
    self.labnum.text=[NSString stringWithFormat:@"X%@",QuerRSpM.count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
