//
//  PinPCollectionViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PinPCollectionViewCell.h"
#import "PchHeader.h"

@implementation PinPCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPinPM:(PinPModel *)PinPM{
    _PinPM=PinPM;
      [_imagetp sd_setImageWithURL:[NSURL URLWithString:PinPM.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _labbt.text=[NSString stringWithFormat:@"%@",PinPM.goodsName];
    _labyj.text=[NSString stringWithFormat:@"原价:¥%@",PinPM.oldGoodsPrice];
     _labscj.text=[NSString stringWithFormat:@"团购价:¥%@",PinPM.storePrice];

}
-(void)setTgMo:(TgModel *)TgMo{
    _TgMo=TgMo;
    [_imagetp sd_setImageWithURL:[NSURL URLWithString:TgMo.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _labbt.text=[NSString stringWithFormat:@"%@",TgMo.group_goods_name];
    _labyj.text=[NSString stringWithFormat:@"原价:¥%@",TgMo.old_price];
    _labscj.text=[NSString stringWithFormat:@"商城价:¥%@",TgMo.group_goods_price];

}
-(void)setTieJMo:(TieJModel *)TieJMo{
    _TieJMo=TieJMo;
    [_imagetp sd_setImageWithURL:[NSURL URLWithString:TieJMo.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    _labbt.text=[NSString stringWithFormat:@"%@",TieJMo.goods_name];
    _labyj.text=[NSString stringWithFormat:@"原价:¥%@",TieJMo.old_price];
    _labscj.text=[NSString stringWithFormat:@"商城价:¥%@",TieJMo.store_price];


}
- (IBAction)addToCartsBlock:(UIButton *)sender {
    if (self.addToCartsBlock) {
        self.addToCartsBlock(self);
    }
}
@end
