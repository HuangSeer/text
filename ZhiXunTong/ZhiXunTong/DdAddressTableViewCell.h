//
//  DdAddressTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"

@interface DdAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labname;
@property (weak, nonatomic) IBOutlet UILabel *labphone;
@property (weak, nonatomic) IBOutlet UILabel *labaddress;
@property (copy, nonatomic)  DiZhiModel *DiZhiM;
@end
