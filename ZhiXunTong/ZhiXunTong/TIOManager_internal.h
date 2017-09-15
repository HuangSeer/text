//
//  TIOManager.h
//  TerminalIO
//
//  Created by Lutz Vogelsang on 27.09.13.
//  Copyright (c) 2013 Lutz Vogelsang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "TIOManager.h"
#import "TIOPeripheral.h"


@interface TIOManager ()

- (void)connectPeripheral:(TIOPeripheral *) peripheral;
- (void)cancelPeripheralConnection:(TIOPeripheral *) peripheral;

@end
