//
//  PublicCell.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PublicCell.h"
#import "PchHeader.h"
@implementation PublicCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        float with=Screen_Width-20;;
        
        _publicImage  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        _publicImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_publicImage];
        
        _publicTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, with-110, 25)];
        _publicTitle.textAlignment = NSTextAlignmentLeft;
        //_publicTitle.textColor = [UIColor blueColor];
        _publicTitle.font = [UIFont systemFontOfSize:13];
        _publicTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_publicTitle];
        
        _publicName = [[UILabel alloc] initWithFrame:CGRectMake(100, 43, with-110, 45)];
        _publicName.textAlignment = NSTextAlignmentLeft;
       // _publicName.textColor = [UIColor blueColor];
        _publicName.font = [UIFont systemFontOfSize:11];
        _publicName.backgroundColor = [UIColor clearColor];
         _publicName.numberOfLines = 2;
        [self.contentView addSubview:_publicName];
        
        _publicTime = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, with-110, 25)];
        _publicTime.textAlignment = NSTextAlignmentLeft;
        //_publicTime.textColor = [UIColor blueColor];
        _publicTime.font = [UIFont systemFontOfSize:11];
        _publicTime.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_publicTime];
 
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
@end
