//
//  BFdxTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/4.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFdxModel.h"
@interface BFdxTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagebf;
@property (weak, nonatomic) IBOutlet UILabel *labqt;
@property (weak, nonatomic) IBOutlet UILabel *labtd;
@property (weak, nonatomic) IBOutlet UILabel *labxq;
@property (weak, nonatomic) IBOutlet UILabel *labts;
@property (copy, nonatomic)BFdxModel *BFdxM;
@end
