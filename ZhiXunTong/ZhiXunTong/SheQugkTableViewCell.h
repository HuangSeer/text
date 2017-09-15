//
//  SheQugkTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuModel.h"

@interface SheQugkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labshequ;
@property (weak, nonatomic) IBOutlet UILabel *labtitle;
@property (copy, nonatomic)SheQuModel *SheQuM;
@end
