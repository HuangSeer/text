//
//  HuDongCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/30.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "HuDongCollectionViewCell.h"
#import "PchHeader.h"
@implementation HuDongCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _Himg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 30, 30)];
        _Himg.backgroundColor=[UIColor orangeColor];
        _Himg.image=[UIImage imageNamed:@"bakge.png"];
        _Himg.layer.masksToBounds=YES;
        _Himg.layer.cornerRadius=_Himg.bounds.size.width*0.5;
        [self addSubview:_Himg];
        
        _Hname=[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 21)];
        _Hname.font=[UIFont systemFontOfSize:13];
        [self addSubview:_Hname];
        
        _HleiX=[[UILabel alloc] initWithFrame:CGRectMake(50, 38, 60, 21)];
        _HleiX.textColor=RGBColor(241, 169, 54);
        _HleiX.font=[UIFont systemFontOfSize:13];
        [self addSubview:_HleiX];
        
        _Hleirong=[[UILabel alloc] initWithFrame:CGRectMake(120, 38, Screen_Width-130,42)];
        _Hleirong.font=[UIFont systemFontOfSize:13];
        _Hleirong.numberOfLines=2;
        [self addSubview:_Hleirong];
        
        _Htime=[[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-100, 5, 90, 21)];
        _Htime.textAlignment=NSTextAlignmentRight;
        _Htime.font=[UIFont systemFontOfSize:13];
        [self addSubview:_Htime];
        UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(10, 89.5, Screen_Width-20, 0.5)];
        xian.backgroundColor=RGBColor(234, 234, 234);
        [self addSubview:xian];
    }
    return self;
}
@end
