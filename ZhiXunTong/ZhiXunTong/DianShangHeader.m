//
//  DianShangHeader.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DianShangHeader.h"

@implementation DianShangHeader
+(DianShangHeader *) init{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"DianShangHeader" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
