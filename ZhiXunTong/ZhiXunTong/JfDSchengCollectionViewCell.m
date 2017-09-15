//
//  JfDSchengCollectionViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JfDSchengCollectionViewCell.h"
#import "PchHeader.h"

@implementation JfDSchengCollectionViewCell
- (IBAction)addToShoppingCart:(UIButton *)sender {
    if (self.addToCartsBlock) {
        self.addToCartsBlock(self);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_butdh.layer setMasksToBounds:YES];
    [_butdh.layer setCornerRadius:2.0]; //设置矩圆角半径
    // Initialization code
}
-(void)setJfM:(JfModel *)JfM{
    _JfM=JfM;
       [_imagece sd_setImageWithURL:[NSURL URLWithString:JfM.image]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.labbt.text=[NSString stringWithFormat:@"%@",JfM.igs_name];
    [self.butjf setTitle:[NSString stringWithFormat:@"%@",JfM.igs_integral] forState:UIControlStateNormal];
    

}
@end
