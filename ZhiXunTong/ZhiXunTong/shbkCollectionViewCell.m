//
//  shbkCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "shbkCollectionViewCell.h"
#import "PchHeader.h"
@implementation shbkCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _bkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, Screen_Width-20, 135)];
        
        [self.contentView addSubview:_bkImage];
        
        _bklabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 114, 80, 21)];
        _bklabel.textAlignment = NSTextAlignmentCenter;
        _bklabel.backgroundColor=[RGBColor(234, 234, 234) colorWithAlphaComponent:0.5];
        _bklabel.textColor=[UIColor whiteColor];
        _bklabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_bklabel];
        
        _bklabelTit = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, Screen_Width-20, 21)];
        _bklabelTit.textAlignment = NSTextAlignmentLeft;
        _bklabelTit.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_bklabelTit];
        
//        _bklabelNei = [[UILabel alloc] initWithFrame:CGRectMake(10, 151, Screen_Width-20, 39)];
//        _bklabelNei.textAlignment = NSTextAlignmentLeft;
//        _bklabelNei.font = [UIFont systemFontOfSize:13];
//        _bklabelNei.numberOfLines=2;
//        [self.contentView addSubview:_bklabelNei];
    }
    
    return self;
}
@end
