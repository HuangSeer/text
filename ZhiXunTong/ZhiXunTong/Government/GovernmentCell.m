//
//  GovernmentCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GovernmentCell.h"
#import "PchHeader.h"
@implementation GovernmentCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float with=(Screen_Width-80)/2;
        float with1=(Screen_Width-60)/2;
        _bianImage = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -5, with+30,70)];
        //_bianImage.backgroundColor=[UIColor blueColor];
        CALayer *layer=[_bianImage layer];
        [layer setMasksToBounds:YES];
        [layer setBorderWidth:0.5];
        [layer setBorderColor:[[UIColor grayColor] CGColor]];
        [self.contentView addSubview:_bianImage];
        
        _mentImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
        _mentImage.backgroundColor = [UIColor clearColor];
        
        
        [self.contentView addSubview:_mentImage];
        
        _mentlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, with1-50, 40)];
        _mentlabel.textAlignment = NSTextAlignmentLeft;
        _mentlabel.textColor = [UIColor grayColor];
        _mentlabel.numberOfLines=2;
        _mentlabel.font = [UIFont systemFontOfSize:11];
        _mentlabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_mentlabel];
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
