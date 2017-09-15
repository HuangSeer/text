//
//  DfcxTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DfcxModel.h"

@interface DfcxTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labtime;
@property (weak, nonatomic) IBOutlet UILabel *labpeice;
@property (copy, nonatomic)DfcxModel *DfcxM;
@end
