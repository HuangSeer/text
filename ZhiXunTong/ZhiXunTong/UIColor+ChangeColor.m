//
//  UIColor+ChangeColor.m
//  AlterMessageDemo
//
//  Created by dev on 2017/4/20.
//  Copyright © 2017年 nys. All rights reserved.
//

#import "UIColor+ChangeColor.h"

@implementation UIColor (ChangeColor)


+ (UIColor*)HexString:(NSString*)hexString
{
    
    NSInteger hexStringLength = hexString.length ;
    
    unsigned int    redColor = 0 ;
    unsigned int    greenColor = 0 ;
    unsigned int    blueColor = 0 ;
    
    UIColor *resultColor = nil ;
    
    
    if ([hexString hasPrefix:@"#"]) {
        
        NSAssert(hexStringLength == 7, @"hexString is Error !");
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(1, 2)]]scanHexInt:&redColor];
        
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(3, 2)]]scanHexInt:&greenColor];
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(5, 2)]]scanHexInt:&blueColor];
        
        
        resultColor = [UIColor colorWithRed:redColor/255.0f green:greenColor/255.0f blue:blueColor/255.0f alpha:1];
        
        
        return resultColor;
        
    }
    else
    {
        
        NSAssert(hexStringLength  == 6, @"hexString is Error !");
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(0, 2)]]scanHexInt:&redColor];
        
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(2, 2)]]scanHexInt:&greenColor];
        
        [[NSScanner scannerWithString:[hexString substringWithRange:NSMakeRange(4, 2)]]scanHexInt:&blueColor];
        
        
        resultColor = [UIColor colorWithRed:redColor/255.0f green:greenColor/255.0f blue:blueColor/255.0f alpha:1];
        
        return resultColor;
    }
    
}




@end
