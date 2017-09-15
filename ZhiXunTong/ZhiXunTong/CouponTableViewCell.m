//
//  CouponTableViewCell.m

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setYHqM:(YHqModel *)YHqM{
    _YHqM=YHqM;
    self.labjm.text=[NSString stringWithFormat:@"¥%@",YHqM.coupon_amount];
    self.labbt.text=[NSString stringWithFormat:@"%@",YHqM.coupon_name];
    self.labtj1.text=[NSString stringWithFormat:@"满%@元可用",YHqM.coupon_order_amount];
    NSArray *array = [YHqM.coupon_begin_time componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
  NSArray *array2 = [YHqM.coupon_end_time componentsSeparatedByString:@" "];
    self.labtj2.text=[NSString stringWithFormat:@"限%@到%@",array[0],array2[0]];



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
