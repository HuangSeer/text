//
//  YiCollectionReusableView.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/5.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "YiCollectionReusableView.h"
#import "PchHeader.h"

@implementation YiCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _yiLable = [[UILabel alloc] initWithFrame:CGRectMake(10, Screen_Width/2, 80, 29)];
        _yiLable.textAlignment = NSTextAlignmentCenter;
        _yiLable.textColor = [UIColor orangeColor];
        _yiLable.font = [UIFont systemFontOfSize:13];
        _yiLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_yiLable];
        
        _xianView=[[UIView alloc] initWithFrame:CGRectMake(10, Screen_Width/2+29, Screen_Width-20, 1)];
        _xianView.backgroundColor=[UIColor grayColor];
        [self addSubview:_xianView];
        
        _yiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _yiButton.frame = CGRectMake(Screen_Width-80, Screen_Width/2, 80, 30);
        _yiButton.backgroundColor = [UIColor clearColor];
        [_yiButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _yiButton.titleLabel.font=[UIFont systemFontOfSize:13];
        
        
        [self addSubview:_yiButton];
        
    }
    
    return self;
}
@end
