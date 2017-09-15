//
//  webViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewController : UIViewController
@property(nonatomic, retain) UIWebView *webView;

-(id)initWithCoderZW:(NSString *)webUrls Title:(NSString *)title;


@end
