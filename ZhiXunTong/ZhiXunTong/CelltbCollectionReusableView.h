//
//  CelltbCollectionReusableView.h
//  LeBao
//
//  Created by 小黄人 on 2017/4/19.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMJDropdownMenu.h"

@interface CelltbCollectionReusableView : UICollectionReusableView
/**
 *  图片
 */

@property (strong ,nonatomic) UIButton *buttoubcell;
@property (strong ,nonatomic) UIButton *but;
@property (strong ,nonatomic) UIButton *butche;
@property (strong ,nonatomic)UIView *viewqh;
@property (strong ,nonatomic)NSString *idstr;
@property (strong ,nonatomic)NSString *idtwo;
@property (strong ,nonatomic)UIView *butview;
@property (strong ,nonatomic)UIView *butcheview;
@property (strong ,nonatomic)UITextView *textView;
@property(strong,nonatomic) LMJDropdownMenu * dropdownMenu;
@property (strong ,nonatomic)NSMutableArray *typeArray;
@property (strong ,nonatomic)UITextField *xhtextf;
@property (strong ,nonatomic)UITextField *xhtextf1;
@property (strong ,nonatomic)UITextField *xhtextf2;
@property (strong ,nonatomic)UITextField *xhtextf3;
@property (strong ,nonatomic)UITextField *xhtextf4;

@end
