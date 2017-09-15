//
//  ViewCollectionViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModel.h"

@interface ViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *butlab;

@property(copy ,nonatomic)ViewModel *ViewMo;
typedef void (^AddToBlock) (ViewCollectionViewCell *);
@property(nonatomic, copy) AddToBlock addToBlock;
@end
