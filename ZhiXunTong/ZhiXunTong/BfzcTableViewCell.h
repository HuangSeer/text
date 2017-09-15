//
//  BfzcTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCModel.h"

@interface BfzcTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labtitle;
@property (weak, nonatomic) IBOutlet UILabel *labtime;
@property (copy, nonatomic)ZCModel *ZCM;

@end
