//
//  DianShangTableViewCell.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DianShangTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ds_img;
@property (weak, nonatomic) IBOutlet UIView *ds_Bakguder;
@property (weak, nonatomic) IBOutlet UILabel *ds_shijia;
@property (weak, nonatomic) IBOutlet UILabel *ds_title;
@property (weak, nonatomic) IBOutlet UILabel *ds_yuanjia;

@end
