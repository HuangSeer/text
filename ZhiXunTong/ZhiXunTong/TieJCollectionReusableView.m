

//
//  TieJCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TieJCollectionReusableView.h"
#import "PchHeader.h"

@implementation TieJCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _viewdh = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width ,Screen_height/12)];
        _imgleft=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20,20)];
        _imgleft.image=[UIImage imageNamed:@"闪电"];
        _butleft=[[UIButton alloc]initWithFrame:CGRectMake(36, 10,Screen_Width/3 , 30)];
        [_butleft setBackgroundImage:[UIImage imageNamed:@"输入框"] forState:UIControlStateNormal];
        [_butleft setTitle:@"正在进行中" forState:UIControlStateNormal];
        [_butleft setTitleColor:RGBColor(96, 211, 120) forState:UIControlStateNormal];
      _butleft.titleLabel.font= [UIFont systemFontOfSize: 13.0f];
        [_viewdh addSubview:_butleft];
        
        [_viewdh addSubview:_imgleft];
        [self addSubview:_viewdh];
    }
    
    return self;
}

@end
