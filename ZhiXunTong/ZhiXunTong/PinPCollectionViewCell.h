//
//  PinPCollectionViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinPModel.h"
#import "TgModel.h"
#import "TieJModel.h"

@interface PinPCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagetp;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UILabel *labyj;
@property (weak, nonatomic) IBOutlet UILabel *labscj;
@property (copy, nonatomic)  PinPModel *PinPM;
@property (copy, nonatomic)  TgModel *TgMo;
@property (copy, nonatomic)  TieJModel *TieJMo;
//声明一个名为 AddToCartsBlock  无返回值，参数为PinPCollectionViewCell 类型的block
typedef void (^AddToCartsBlock) (PinPCollectionViewCell *);
@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;
@end
