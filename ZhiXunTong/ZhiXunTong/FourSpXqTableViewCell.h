//
//  FourSpXqTableViewCell.h
//  ZhiXunTong
//
//  Created by mac  on 2017/8/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpPlModel.h"

@interface FourSpXqTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgtx;
@property (weak, nonatomic) IBOutlet UIView *viewpf;
@property (weak, nonatomic) IBOutlet UILabel *labpl;
@property (weak, nonatomic) IBOutlet UILabel *labname;
@property (copy, nonatomic)  SpPlModel *SpPlM;
@end
