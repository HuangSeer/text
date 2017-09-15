//
//  CustomMessageView.h
//  AlterMessageDemo
//
//  Created by dev on 2017/4/20.
//  Copyright © 2017年 nys. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol sendTheValueDelegate <NSObject>

-(void)getTimeToValue:(NSString *)theTimeStr;


@end



@interface CustomMessageView : UIView<UITextFieldDelegate>


@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * contentLab;
@property(nonatomic,strong)UILabel * twoLab;
@property(nonatomic,strong)UIButton  * authCodeBtn;
@property(nonatomic,strong)UIButton  * cancelBtn;
@property(nonatomic,strong)UIButton  * submitBtn;

@property(nonatomic,assign)id delegate;


@end
