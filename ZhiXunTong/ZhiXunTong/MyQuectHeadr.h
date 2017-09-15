//
//  MyQuectHeadr.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuectHeadr : UIView
@property (weak, nonatomic) IBOutlet UILabel *lable_name;
@property (weak, nonatomic) IBOutlet UILabel *lable_address;
+(MyQuectHeadr *) init;
@end
