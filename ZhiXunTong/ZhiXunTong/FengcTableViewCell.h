//
//  FengcTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FengcModel.h"

@interface FengcTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagefc;
@property (weak, nonatomic) IBOutlet UILabel *labfcname;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (copy, nonatomic)FengcModel *FengcM;
@end
