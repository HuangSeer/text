//
//  GDTableViewCell.h
//  ZhiXunTong
//
//  Created by Mou on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTableViewCell : UITableViewCell
//用户名
@property(nonatomic,retain) UILabel *name;
//用户介绍
@property(nonatomic,retain) UILabel *introduction;


//给用户介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
