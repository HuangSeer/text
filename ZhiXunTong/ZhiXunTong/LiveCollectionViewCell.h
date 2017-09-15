//
//  LiveCollectionViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQModel.h"

@interface LiveCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagLIve;
@property (weak, nonatomic) IBOutlet UILabel *lablive;
@property (copy, nonatomic)DQModel *DQM;
@end
