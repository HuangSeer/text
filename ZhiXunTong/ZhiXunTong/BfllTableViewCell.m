//
//  BfllTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BfllTableViewCell.h"
#import "PchHeader.h"

@implementation BfllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

 
    
    // Initialization code
}
-(void)setBfllM:(BfllModel *)BfllM{
    _BfllM=BfllM;

    
    self.labtitle.text=[NSString stringWithFormat:@"%@",BfllM.title];
    self.labll.text=[NSString stringWithFormat:@"%@",BfllM.content];
     self.labll.lineBreakMode = UILineBreakModeWordWrap;
     self.labll.numberOfLines = 0;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
