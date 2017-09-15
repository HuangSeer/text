////
////  DhJlTableViewCell.m
////  ZhiXunTong
////
////  Created by mac  on 2017/8/15.
////  Copyright © 2017年 airZX. All rights reserved.
////
//
#import "DhJlTableViewCell.h"
#import "PchHeader.h"

@implementation DhJlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _imagetp.layer.borderColor = [RGBColor(231, 231, 231) CGColor];
    _imagetp.layer.borderWidth = 0.5f;
    [_imagetp.layer setMasksToBounds:YES];
    [_imagetp.layer setCornerRadius:5.0]; //设置矩圆角半径
}
-(void)setJlXqMo:(JlXqModel *)JlXqMo{
    _JlXqMo=JlXqMo;
    
    [_imagetp sd_setImageWithURL:[NSURL URLWithString:JlXqMo.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labbt.text=[NSString stringWithFormat:@"%@",JlXqMo.goods_name];
    self.labjg.text=[NSString stringWithFormat:@"消耗积分:%@",JlXqMo.goods_integral];
    self.labyf.text=[NSString stringWithFormat:@"运费:%@",JlXqMo.ig_trans_fee];
    self.labnum.text=[NSString stringWithFormat:@"兑换数量:%@",JlXqMo.goods_count];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

