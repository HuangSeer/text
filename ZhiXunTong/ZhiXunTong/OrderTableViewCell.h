//
//  OrderTableViewCell.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *Lalbe_title;
@property (weak, nonatomic) IBOutlet UILabel *lab_zt;
@property (weak, nonatomic) IBOutlet UILabel *lab_prict;
@property (weak, nonatomic) IBOutlet UILabel *lab_cont;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *ThreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *Stor_name;
@property (weak, nonatomic) IBOutlet UIView *hui_View;

@end
