//
//  TIOPeripheral.h
//  TerminalIO
//
//  Created by Lutz Vogelsang on 29.09.13.
//  Copyright (c) 2013 Lutz Vogelsang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIOPeripheral.h"


@interface TIOPeripheral ()

+ (TIOPeripheral *)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral;
+ (TIOPeripheral *)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral andAdvertisement:(TIOAdvertisement*)advertisement;

@property (strong, readonly, nonatomic) CBPeripheral *cbPeripheral;

- (void)didConnect;
- (void)didFailToConnectWithError:(NSError *)error;
- (void)didDisconnectWithError:(NSError *)error;
- (BOOL)updateWithAdvertisement:(TIOAdvertisement *)advertisement;

@end
