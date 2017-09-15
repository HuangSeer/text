//
//  WiFiViewController.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AnjubaoSDK/WiFiOneKeyConfigUtil.h>


@interface WiFiViewController : UIViewController<WiFiOneKeyConfigDelegate>
@property(nonatomic, readwrite, copy, null_unspecified) NSString* ipcSerialNumberText;
@end
