//
//  DangyTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZIchaungModel.h"

@interface DangyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagdy;
@property (weak, nonatomic) IBOutlet UILabel *labdy;
@property (copy, nonatomic)ZIchaungModel *ZIchaungM;

@end
