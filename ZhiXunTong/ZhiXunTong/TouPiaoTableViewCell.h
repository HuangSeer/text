//
//  TouPiaoTableViewCell.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTModel.h"

@interface TouPiaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labtp;
@property(nonatomic,copy)XZTModel *XZTm;

@end
