//



//  DangyTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DangyTableViewCell.h"
#import "PchHeader.h"
@implementation DangyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setZIchaungM:(ZIchaungModel *)ZIchaungM{
    _ZIchaungM=ZIchaungM;
  
    [ self.imagdy setImage:[UIImage imageNamed:ZIchaungM.image]];
    self.labdy.text=[NSString stringWithFormat:@"%@",ZIchaungM.title];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
