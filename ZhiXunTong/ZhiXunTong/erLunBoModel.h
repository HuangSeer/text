//
//  erLunBoModel.h
//  ZhiXunTong
//
//  Created by Mou on 2017/6/15.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface erLunBoModel : NSObject
//ad
@property (strong, nonatomic) NSArray *ad;
@property (strong, nonatomic) NSString *Imgurl;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *Url;
@property (strong, nonatomic) NSString *adUrl;

//news
@property (strong, nonatomic) NSArray *News;
@property (strong, nonatomic) NSString *NewsUrl;
//@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) NSString *ImageIndex;


@end
