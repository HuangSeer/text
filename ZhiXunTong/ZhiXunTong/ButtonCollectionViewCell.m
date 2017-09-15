//
//  ButtonCollectionViewCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ButtonCollectionViewCell.h"
#import "PchHeader.h"

@implementation ButtonCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float with = (Screen_Width-90) / 2;
        
        _duoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _duoButton.frame = CGRectMake(0, 0,with, 40);
        _duoButton.backgroundColor = [UIColor clearColor];
        [_duoButton setTitle:@"pushVC2" forState:UIControlStateNormal];
        [_duoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self addSubview:_duoButton];
        
        _titLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, with, 40)];
        _titLable.textAlignment = NSTextAlignmentCenter;
        _titLable.textColor = [UIColor blackColor];
        _titLable.font = [UIFont systemFontOfSize:13];
        _titLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_titLable];
        
        _titImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,with,40)];
        CALayer *layer=[_titImage layer];
        [layer setMasksToBounds:YES];
        [layer setBorderWidth:1];
        [layer setCornerRadius:15];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        [self.contentView addSubview:_titImage];
    }
    return self;
}
@end
