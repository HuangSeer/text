//
//  KaiJfpTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KaiJfpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *butgs;
@property (weak, nonatomic) IBOutlet UILabel *labgs;
@property (weak, nonatomic) IBOutlet UIButton *butgr;
//声明一个名为 AddToCartsBlock  无返回值，参数为XSMyFavoriteTableViewCell 类型的block
typedef void (^AddToGerenBlock) (KaiJfpTableViewCell *);
@property(nonatomic, copy) AddToGerenBlock addToGerenBlock;
//声明一个名为 AddToCartsBlock  无返回值，参数为XSMyFavoriteTableViewCell 类型的block
typedef void (^AddTogsBlock) (KaiJfpTableViewCell *);
@property(nonatomic, copy) AddTogsBlock addTogsBlock;
@end
