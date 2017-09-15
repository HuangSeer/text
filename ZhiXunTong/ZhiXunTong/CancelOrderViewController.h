//
//  CancelOrderViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/10.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelOrderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lab_Dan;

@property (weak, nonatomic) IBOutlet UIView *btn_view;
@property (weak, nonatomic) IBOutlet UIView *btn_view1;
@property (weak, nonatomic) IBOutlet UIView *btn_view2;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (weak, nonatomic) IBOutlet UIButton *btn_TiJiao;
- (IBAction)tijiao_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img_01;
@property (weak, nonatomic) IBOutlet UIImageView *img_02;
@property (weak, nonatomic) IBOutlet UIImageView *img_03;
@property(nonatomic,assign)NSString  *ordId;
@end
