//
//  SGQRCodeScanningVC.h
//  SGQRCodeExample
//
//  Created by kingsic on 17/3/20.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CallBackBlcok) (NSString *text);//1
@interface SGQRCodeScanningVC : UIViewController
@property (nonatomic,copy)CallBackBlcok callBackBlock;//2
@end
