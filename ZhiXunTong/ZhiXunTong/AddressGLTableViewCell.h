//
//  AddressGLTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"

@interface AddressGLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labname;
@property (weak, nonatomic) IBOutlet UILabel *labphone;
@property (weak, nonatomic) IBOutlet UILabel *labaddress;
@property (copy, nonatomic)  DiZhiModel *DiZhiM;
//声明一个名为 AddToCartsBlock  无返回值，参数为PinPCollectionViewCell 类型的block
typedef void (^AddToCartsBlock) (AddressGLTableViewCell *);
@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;
typedef void (^LodaBlock) (AddressGLTableViewCell *);
@property(nonatomic, copy) LodaBlock lodaBlock;
@end
