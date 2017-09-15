//
//  GonggaoViewController.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PchHeader.h"
#import "YJSegmentedControl.h"
@interface GonggaoViewController : UIViewController<YJSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITableView *leftTableView;
//    UITableView *RigeTableView;
}

@end
