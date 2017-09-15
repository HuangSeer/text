//
//  SheQuCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/30.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SheQuCollectionViewCell.h"
#import "PchHeader.h"
@implementation SheQuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _Himg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, Screen_Width/2-38, 80)];
//        _Himg.backgroundColor=[UIColor orangeColor];
        _Himg.image=[UIImage imageNamed:@"默认图片"];
        [self addSubview:_Himg];
        
        _Hname=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-25, 5, Screen_Width-(Screen_Width/2-20), 42)];
        _Hname.numberOfLines=2;
        _Hname.font=[UIFont systemFontOfSize:13];
        [self addSubview:_Hname];
        
        _HleiX=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-25, 45, Screen_Width-(Screen_Width/2-20), 21)];
//        _HleiX.textColor=RGBColor(241, 169, 54);
        _HleiX.font=[UIFont systemFontOfSize:13];
        [self addSubview:_HleiX];
        
        _Hleirong=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width/2-25, 69, Screen_Width-(Screen_Width/2-20),21)];
        _Hleirong.font=[UIFont systemFontOfSize:13];
        _Hleirong.numberOfLines=2;
        [self addSubview:_Hleirong];
        
//        _Htime=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-100, 5, 90, 21)];
//        _Htime.textAlignment=NSTextAlignmentRight;
//        _Htime.font=[UIFont systemFontOfSize:13];
//        [self addSubview:_Htime];
        UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(10, 99.5, Screen_Width-20, 0.5)];
        xian.backgroundColor=RGBColor(234, 234, 234);
        [self addSubview:xian];
    }
    return self;
}
@end
