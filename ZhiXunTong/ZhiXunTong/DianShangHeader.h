//
//  DianShangHeader.h
//  ZhiXunTong
//
//  Created by Mou on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DianShangHeader : UIView
@property (weak, nonatomic) IBOutlet UIView *GunDongView;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView01;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView02;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView03;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView04;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView05;

+(DianShangHeader *) init;
@end
