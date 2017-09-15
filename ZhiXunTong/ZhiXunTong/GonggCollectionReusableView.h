//
//  GonggCollectionReusableView.h
//  ZhiXunTong
//
//  Created by mac  on 2017/6/29.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"

@interface GonggCollectionReusableView : UICollectionReusableView
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenu;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenu1;
@property (strong ,nonatomic)UITextView *textView;
@end
