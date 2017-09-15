//
//  JfDSchengCollectionViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JfModel.h"
@class JfDSchengCollectionViewCell;
@interface JfDSchengCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagece;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UIButton *butjf;
@property (weak, nonatomic) IBOutlet UIButton *butdh;
@property (copy, nonatomic)  JfModel *JfM;
//声明一个名为 AddToCartsBlock  无返回值，参数为XSMyFavoriteTableViewCell 类型的block
typedef void (^AddToCartsBlock) (JfDSchengCollectionViewCell *);
@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;
@end
