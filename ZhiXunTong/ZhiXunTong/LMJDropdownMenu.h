//
//  LMJDropdownMenu.h
//
//  Version:1.0.0
//
//  Created by MajorLi on 15/5/4.
//  Copyright (c) 2015年 iOS开发者公会. All rights reserved.
//
//  iOS开发者公会-技术1群 QQ群号：87440292
//  iOS开发者公会-技术2群 QQ群号：232702419
//  iOS开发者公会-议事区  QQ群号：413102158
//

#import <UIKit/UIKit.h>
#import "lmModel.h"
#import "LovelModel.h"
#import "SuQiuModel.h"
#import "SQbmModel.h"
#import "SJtypeModel.h"
#import "ContentModel.h"
#import "LecwModel.h"
#import "NationModel.h"

@class LMJDropdownMenu;




@protocol LMJDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu;    // 当下拉菜单将要显示时调用
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu;     // 当下拉菜单已经显示时调用
- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu;  // 当下拉菜单将要收起时调用
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu;   // 当下拉菜单已经收起时调用

- (void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number; // 当选择某个选项时调用

@end




@interface LMJDropdownMenu : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIButton * mainBtn;  // 主按钮 可以自定义样式 可在.m文件中修改默认的一些属性
@property (nonatomic,copy) lmModel *typeShop;
@property (nonatomic,copy) LovelModel *LoveM;
@property (nonatomic,copy) SQbmModel *suqiu;
@property (nonatomic,copy) SuQiuModel *SuQiuM;
@property (nonatomic,copy) SJtypeModel *SJtypeM;
@property (nonatomic,copy) ContentModel *ContentM;
@property (nonatomic,copy) NationModel *NationM;
@property (nonatomic,copy) LecwModel *LecwM;
@property (nonatomic, assign) id <LMJDropdownMenuDelegate>delegate;

@property (nonatomic,strong) NSString * strpand;
- (void)setMenuTitles:(NSArray *)titlesArr rowHeight:(CGFloat)rowHeight;  // 设置下拉菜单控件样式

- (void)showDropDown; // 显示下拉菜单
- (void)hideDropDown; // 隐藏下拉菜单

@end
