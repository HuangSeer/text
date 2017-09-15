//
//  WuYewebViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuYewebViewController : UIViewController
@property(nonatomic, retain) UIWebView *webView;

-(id)initWithCoders:(NSString *)webUrls Title:(NSString *)title;
@end
