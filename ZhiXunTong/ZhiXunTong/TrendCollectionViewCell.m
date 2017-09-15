//
//  TrendCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/6.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TrendCollectionViewCell.h"
#import "PchHeader.h"

@implementation TrendCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _trendImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 3, Screen_Width-20, 127)];
        _trendImage.backgroundColor=[UIColor clearColor];
        [self addSubview:_trendImage];
        
        _alable = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, Screen_Width-20, 29)];
        _alable.textAlignment = NSTextAlignmentCenter;
        _alable.textColor = [UIColor whiteColor];
        _alable.font = [UIFont systemFontOfSize:17];
        _alable.backgroundColor = [UIColor clearColor];
        [_trendImage addSubview:_alable];
        
        UIView *imageView=[[UIView alloc] initWithFrame:CGRectMake(30, 0, 45, 50)];
        imageView.backgroundColor=[UIColor grayColor];
        imageView.alpha=0.5;
        [_trendImage addSubview:imageView];
        
        _lableCont=[[UILabel alloc] initWithFrame:CGRectMake(0, 3, 45, 21)];
        _lableCont.textColor=[UIColor whiteColor];
        _lableCont.textAlignment=NSTextAlignmentCenter;
        _lableCont.font = [UIFont systemFontOfSize:13];
        [imageView addSubview:_lableCont];
        
        _lableCan=[[UILabel alloc] initWithFrame:CGRectMake(0, 26, 45, 21)];
        _lableCan.textColor=[UIColor whiteColor];
        _lableCan.textAlignment=NSTextAlignmentCenter;
        _lableCan.font = [UIFont systemFontOfSize:13];
        [imageView addSubview:_lableCan];
        
        UILabel *toupiao=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, Screen_Width-40, 21)];
        toupiao.textAlignment=NSTextAlignmentRight;
        toupiao.textColor=[UIColor whiteColor];
        toupiao.font = [UIFont systemFontOfSize:13];
        toupiao.text=@"去投票 >";
        [_trendImage addSubview:toupiao];
    }
    
    return self;
}
@end
