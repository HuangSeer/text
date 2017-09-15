//
//  PJXiangQingViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/8/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJXiangQingViewController : UIViewController
@property(nonatomic,assign)NSString  *PG_id;
@property(nonatomic,assign)NSString  *PG_name;
@property(nonatomic,assign)NSString  *PG_img;
@property(nonatomic,assign)NSString  *pg_good_id;
@property(nonatomic,assign)NSString  *PG_count;
@property(nonatomic,assign)NSString  *pg_price;


@property (weak, nonatomic) IBOutlet UILabel *pj_ding;
@property (weak, nonatomic) IBOutlet UILabel *pj_title;
@property (weak, nonatomic) IBOutlet UILabel *pj_con;
@property (weak, nonatomic) IBOutlet UILabel *pj_price;
@property (weak, nonatomic) IBOutlet UIImageView *pj_img;
@property (weak, nonatomic) IBOutlet UIView *pj_View;
@property (weak, nonatomic) IBOutlet UITextView *text_View;

@end
