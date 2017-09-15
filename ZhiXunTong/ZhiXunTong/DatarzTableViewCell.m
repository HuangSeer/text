//
//  DatarzTableViewCell.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DatarzTableViewCell.h"

@implementation DatarzTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setShiJM:(ShiJModel *)ShiJM{
    _ShiJM=ShiJM;
    self.labbt.text=[NSString stringWithFormat:@"%@",ShiJM.blogName];
    
    NSArray *array = [ShiJM.editBlogDate componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    self.labdate.text=[NSString stringWithFormat:@"%@",array[1]];
//    NSArray *titleslab=@[@"巡查",@"宣传",@"走访",@"处理"];
//    int lang;
//     NSArray *arrassy = [ShiJM.editBlogDate componentsSeparatedByString:@","];
//    NSLog(@"%@",arrassy);
//    for (int i=1; i<arrassy.count; i++) {
//        lang=[arrassy[i] intValue];
//    
//    }
//     self.labqt.text=[NSString stringWithFormat:@"%@",titleslab[lang]];
 
   
 
}

-(void)setSjM:(SjModel *)SjM{
    _SjM=SjM;

    self.labbt.text=[NSString stringWithFormat:@"%@",SjM.eventTitle];
    
    NSArray *array = [SjM.editEventDate componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    self.labdate.text=[NSString stringWithFormat:@"%@",array[1]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
