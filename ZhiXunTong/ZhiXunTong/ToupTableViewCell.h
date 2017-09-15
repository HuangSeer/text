//
//  ToupTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/6/26.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTModel.h"

@interface ToupTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property(nonatomic,copy)XZTModel *xztt;
@end
