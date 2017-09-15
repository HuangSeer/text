//
//  DyTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DyModel.h"


@interface DyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lanname;
@property (weak, nonatomic) IBOutlet UILabel *labmz;
@property (weak, nonatomic) IBOutlet UILabel *labyear;
@property (weak, nonatomic) IBOutlet UILabel *labphone;

@property (weak, nonatomic) IBOutlet UILabel *lanage;
@property (weak, nonatomic) IBOutlet UILabel *labbd;
@property (copy, nonatomic)DyModel *DyMo;
@end
