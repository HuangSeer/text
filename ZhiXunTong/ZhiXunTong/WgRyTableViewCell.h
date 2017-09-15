//
//  WgRyTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/12.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WgModel.h"

@interface WgRyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labone;
@property (weak, nonatomic) IBOutlet UILabel *labtwo;
@property (weak, nonatomic) IBOutlet UILabel *labthree;
@property (weak, nonatomic) IBOutlet UILabel *labfour;
@property (copy, nonatomic)  WgModel *WgM;
@end
