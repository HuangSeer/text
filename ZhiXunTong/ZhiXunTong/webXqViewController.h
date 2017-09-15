//
//  webXqViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/22.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webXqViewController : UIViewController
@property(nonatomic, retain) UIWebView *webView;

-(id)initWithCoder:(NSString *)webUrl;
@end
