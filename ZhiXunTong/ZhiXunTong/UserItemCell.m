//
//  UserItemCell.m
//  UserItem
//
//  Created by Yizhong on 17/6/20.
//  Copyright © 2017年 Yizhong. All rights reserved.
//

#import "UserItemCell.h"
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
@interface UserItemCell ()

@end

@implementation UserItemCell

//init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.user_image];
       
    }
    return self;
}
//lazy
- (UIImageView *)user_image{
    if (!_user_image) {
        _user_image = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        _user_image.layer.masksToBounds = YES;
        _user_image.layer.cornerRadius = 5;
        //添加边框
        CALayer * layer = [_user_image layer];
        layer.borderColor = [[UIColor grayColor] CGColor];
        layer.borderWidth = 1.0f;
        //添加四个边阴影
        _user_image.layer.shadowColor = [UIColor greenColor].CGColor;//阴影颜色
        _user_image.layer.shadowOffset = CGSizeMake(10, 10);//偏移距离
        _user_image.layer.shadowOpacity = 0.5;//不透明度
        _user_image.layer.shadowRadius = 2.0;//半径
    }
    return _user_image;
}


@end
