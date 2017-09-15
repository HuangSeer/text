
//
//  LiveCollectionViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "LiveCollectionViewCell.h"
#import "PchHeader.h"

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDQM:(DQModel *)DQM{
    _DQM=DQM;
    [self.imagLIve sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:DQM.CoverImg ]]placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.lablive.text=[NSString stringWithFormat:@"%@",DQM.title];

    

}
@end
