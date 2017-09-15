//
//  JeFenCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JeFenCollectionReusableView.h"
#import "PchHeader.h"

@implementation JeFenCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _viewdh = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Width/2,Screen_Width ,Screen_height/10)];
        _yiLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,_viewdh.frame.size.width/5 ,_viewdh.frame.size.height/3)];
        _yiLable.textAlignment = NSTextAlignmentLeft;
        _yiLable.textColor = [UIColor blackColor];
        _yiLable.font = [UIFont systemFontOfSize:12];
        _yiLable.text=@"我的积分";
        
        _Labts = [[UILabel alloc] initWithFrame:CGRectMake(5, (_viewdh.frame.size.height- _viewdh.frame.size.height/3),_viewdh.frame.size.width/2 ,_viewdh.frame.size.height/3)];
        _Labts.textAlignment = NSTextAlignmentLeft;
        _Labts.textColor = [UIColor grayColor];
        _Labts.font = [UIFont systemFontOfSize:12];
        _Labts.text=@"如何让获得更多积分？";
    
        _butdh = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width-Screen_Width/4-8), 12,_viewdh.frame.size.width/4 ,_viewdh.frame.size.height-24)];
        [_butdh setTitle:@"兑换记录" forState:UIControlStateNormal];
            [_butdh.layer setMasksToBounds:YES];
        [_butdh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_butdh.layer setCornerRadius:3.0]; //设置矩圆角半径
        [_butdh.layer setBorderWidth:1.0];   //边框宽度
        _butdh.font = [UIFont systemFontOfSize:12];
        [_butdh.layer setBorderColor:RGBColor(186, 233, 193).CGColor];//边框颜色
        _xianView = [[UIView alloc] initWithFrame:CGRectMake(2,Screen_Width/2+Screen_height/10,Screen_Width-4,4)];
        _xianView.backgroundColor=RGBColor(238, 238, 238);
        _viewbt1 = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Width/2+Screen_height/10+4,Screen_Width ,30)];

        UIButton *butig=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        [butig setBackgroundImage:[UIImage imageNamed:@"lb"] forState:UIControlStateNormal];
        
        UILabel *labbt1 = [[UILabel alloc] initWithFrame:CGRectMake(35,0,_viewdh.frame.size.width/2 ,_viewbt1.frame.size.height)];
        labbt1.textAlignment = NSTextAlignmentLeft;
        labbt1.textColor = [UIColor blackColor];
        labbt1.font = [UIFont systemFontOfSize:12];
        labbt1.text=@"积分兑换礼品专区";
        [_viewbt1 addSubview:butig];
        [_viewbt1 addSubview:labbt1];
        [self addSubview:_viewbt1];
        [self addSubview:_xianView];
        [_viewdh addSubview:_butdh];
        [_viewdh addSubview:_Labts];
        [_viewdh addSubview:_yiLable];
        
        [self addSubview:_viewdh];
        
    }
    
    return self;
}
@end
