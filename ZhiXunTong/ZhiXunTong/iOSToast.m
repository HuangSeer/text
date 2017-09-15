//
//  iOSToast.m
//  sdk_test
//
//  Created by YangFan on 6/2/16.
//  Copyright © 2016 yangfan. All rights reserved.
//

#import "iOSToast.h"

@implementation iOSToast

+(void)toast:(NSString*)message
            :(int)seconds
{
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    toast.backgroundColor = [UIColor blackColor];
    [toast show];
    dispatch_after(
                   dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC),
                   dispatch_get_main_queue(),
                   ^{
                       [toast dismissWithClickedButtonIndex:0 animated:YES];
                   });
}

@end
