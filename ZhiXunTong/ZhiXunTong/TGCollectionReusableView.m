//
//  TGCollectionReusableView.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TGCollectionReusableView.h"
#import "PchHeader.h"

@implementation TGCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _viewdh = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Width/2,Screen_Width ,Screen_height/10)];
        _imgleft=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, _viewdh.frame.size.height-25)];
        _imgleft.image=[UIImage imageNamed:@"时钟"];
       
        _Labbt=[[UILabel alloc]initWithFrame:CGRectMake(45, 5, Screen_Width/2, (_viewdh.frame.size.height-10)/2)];
        _Labbt.textAlignment = UITextAlignmentLeft;
        _Labbt.text=@"距离本次团购结束还剩";
        _Labbt.font=[UIFont systemFontOfSize:14.0f];
        _Labtime=[[UILabel alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/1.7-5), 5+(_viewdh.frame.size.height-10)/2, Screen_Width/1.7, (_viewdh.frame.size.height-10)/2)];
        _Labtime.textColor=[UIColor redColor];
        _Labtime.font=[UIFont systemFontOfSize:14.0f];
        _Labtime.textAlignment = UITextAlignmentRight;
         [_viewdh addSubview:_imgleft];
        [_viewdh addSubview:_Labtime];
        [_viewdh addSubview:_Labbt];
        [self addSubview:_viewdh];
    }
    
    return self;
}
@end
