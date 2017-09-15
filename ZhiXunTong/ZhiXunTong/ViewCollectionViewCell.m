//
//  ViewCollectionViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ViewCollectionViewCell.h"
#import "PchHeader.h"

@implementation ViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.butlab.layer setMasksToBounds:YES];
    [self.butlab.layer setCornerRadius:5]; //设置矩圆角半径
    [self.butlab.layer setBorderWidth:1];
    [self.butlab.layer setBorderColor:RGBColor(0, 181, 75).CGColor];//边框颜色
    // Initialization code
}
- (IBAction)addToBlock:(UIButton *)sender {


    if (self.addToBlock) {
        self.addToBlock(self);
    }
}
-(void)setViewMo:(ViewModel *)ViewMo{
 _ViewMo=ViewMo;
    [self.butlab setTitle:[NSString stringWithFormat:@"%@",ViewMo.property_value] forState:UIControlStateNormal];
}
@end
