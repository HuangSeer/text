//
//  WuYeCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/26.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "WuYeCollectionViewCell.h"
#import "PchHeader.h"
@implementation WuYeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *aView=[[UIView alloc] initWithFrame:CGRectMake(10, 10, Screen_Width-20, 100)];
        aView.backgroundColor=[UIColor whiteColor];
        [self addSubview:aView];
        _imagtix=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        //给cell建议的图片
        
//        _imagtix.backgroundColor=[UIColor redColor];
        [aView addSubview:_imagtix];
        _alable = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 29)];
        _alable.textAlignment = NSTextAlignmentLeft;
        _alable.textColor = [UIColor blackColor];
        _alable.font = [UIFont systemFontOfSize:16];
        _alable.backgroundColor = [UIColor clearColor];
        [aView addSubview:_alable];
        
        _blable = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-90, 8, 60, 20)];
        _blable.textAlignment = NSTextAlignmentCenter;
        _blable.textColor = [UIColor whiteColor];
        _blable.backgroundColor=[UIColor redColor];
        _blable.font = [UIFont systemFontOfSize:13];
        [aView addSubview:_blable];
        
        _clable = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 200, 29)];
        _clable.textAlignment = NSTextAlignmentLeft;
        _clable.textColor = [UIColor blackColor];
        _clable.font = [UIFont systemFontOfSize:13];
        _clable.backgroundColor = [UIColor clearColor];
        [aView addSubview:_clable];
        
        _dlable = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 140, 29)];
        _dlable.textAlignment = NSTextAlignmentLeft;
        _dlable.textColor = [UIColor blackColor];
        _dlable.font = [UIFont systemFontOfSize:13];
        _dlable.backgroundColor = [UIColor clearColor];
        [aView addSubview:_dlable];
        
        _elable = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width-160, 70, 140, 29)];
        _elable.textAlignment = NSTextAlignmentLeft;
        _elable.textColor = [UIColor blackColor];
        _elable.font = [UIFont systemFontOfSize:13];
        _elable.backgroundColor = [UIColor clearColor];
        [aView addSubview:_elable];
        
    }
    
    return self;
}

@end
