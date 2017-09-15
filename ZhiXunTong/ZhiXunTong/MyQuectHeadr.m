//
//  MyQuectHeadr.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "MyQuectHeadr.h"

@implementation MyQuectHeadr
+(MyQuectHeadr *) init{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"MyQuectHeadr" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


@end
