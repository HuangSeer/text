//
//  ErCollectionReusableView.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/5.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ErCollectionReusableView.h"
#import "PchHeader.h"
@implementation ErCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _erLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 29)];
        _erLable.textAlignment = NSTextAlignmentCenter;
        _erLable.textColor = [UIColor orangeColor];
        _erLable.font = [UIFont systemFontOfSize:13];
        _erLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_erLable];
        _xianView2=[[UIView alloc] initWithFrame:CGRectMake(10, 29, Screen_Width-20, 1)];
        _xianView2.backgroundColor=[UIColor grayColor];
        [self addSubview:_xianView2];
        
        _erButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _erButton.frame = CGRectMake(Screen_Width-80, 0, 80, 30);
        _erButton.backgroundColor = [UIColor clearColor];
        [_erButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _erButton.titleLabel.font=[UIFont systemFontOfSize:13];
        
        
        [self addSubview:_erButton];
    }
    
    return self;
}
@end
