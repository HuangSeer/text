//
//  BfllTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BfllModel.h"

@interface BfllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labtitle;
@property (weak, nonatomic) IBOutlet UILabel *labll;
@property (copy, nonatomic)BfllModel *BfllM;
@end
