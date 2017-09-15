//
//  CouponTableViewCell.h


#import <UIKit/UIKit.h>
#import "YHqModel.h"

@interface CouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labjm;
@property (weak, nonatomic) IBOutlet UILabel *labbt;
@property (weak, nonatomic) IBOutlet UIImageView *imgxgt;
@property (weak, nonatomic) IBOutlet UILabel *labtj1;
@property (weak, nonatomic) IBOutlet UILabel *labtj2;
@property(nonatomic,strong)YHqModel *YHqM;

@end
