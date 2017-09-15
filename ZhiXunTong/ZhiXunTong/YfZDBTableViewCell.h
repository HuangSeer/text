//
//  YfZDBTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/24.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DhJlModel.h"

@interface YfZDBTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *butsure;
@property (weak, nonatomic) IBOutlet UILabel *labyf;
@property (weak, nonatomic) IBOutlet UIButton *butdd;

//声明一个名为 AddToCartsBlock  无返回值，参数为XSMyFavoriteTableViewCell 类型的block
typedef void (^ButSureBlocks) (YfZDBTableViewCell *);
typedef void (^AddToCartsBlock) (YfZDBTableViewCell *);
@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;
@property(nonatomic, copy) ButSureBlocks butSureBlocks;
@property (copy, nonatomic)  DhJlModel *DhJlM;
@end
