//
//  iOSToast.h
//  sdk_test
//
//  Created by YangFan on 6/2/16.
//  Copyright © 2016 yangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSToast : NSObject

+(void)toast:(NSString*)message
            :(int)seconds;

@end
