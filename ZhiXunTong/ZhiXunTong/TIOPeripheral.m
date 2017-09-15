//
//  TIOPeripheral.m
//  TerminalIO
//
//  Created by Lutz Vogelsang on 18.11.13.
//  Copyright (c) 2013 Lutz Vogelsang. All rights reserved.
//

#import "TIO.h"
#import "TIOPeripheral_internal.h"
#import "TIOManager_internal.h"
#import "STTrace.h"
#import "crc.h"



@interface TIOPeripheral () <CBPeripheralDelegate>

@property	(strong, nonatomic) CBService *tioService;
//
@property	(strong, nonatomic) CBCharacteristic *uartTxCharacteristic;
@property   (strong, nonatomic) CBCharacteristic *uartSeRxCharacteristic;
//@property	(strong, nonatomic) CBCharacteristic *uartINDICharacteristic;
//@property	(strong, nonatomic) CBCharacteristic *uartRxCreditsCharacteristic;

@property (nonatomic) BOOL hadToPerformServiceDiscovery;
@property (nonatomic) BOOL didSubscribeUARTTx;
@property (nonatomic) BOOL didSubscribeUARTTxCredits;
@property (nonatomic) BOOL didGrantInitialUARTRxCredits;

@property (strong, nonatomic) NSMutableData *uartDataToBeWritten;
@property	(nonatomic) BOOL isWriting;
@property (strong, readonly, nonatomic) NSObject *writeLock;
@property	(nonatomic) NSInteger localUARTCreditsCount;   // RX credits granted to the peripheral
@property (nonatomic) NSInteger pendingLocalUARTCreditsCount;
@property	(nonatomic) NSInteger remoteUARTCreditsCount;  // TX credits granted by the peripheral

@end



@implementation TIOPeripheral
@synthesize isConnected = _isConnected;
@synthesize isConnecting = _isConnecting;

NSInteger const MIN_UART_CREDITS_COUNT = 32;

#pragma  mark - Initialization

- (TIOPeripheral *)initWithCBPeripheral:(CBPeripheral *)cbPeripheral andAdvertisement:(TIOAdvertisement *)advertisement
{
    self = [super init];
    if (self)
    {
        self.cbPeripheral = cbPeripheral;
        cbPeripheral.delegate = self;
        self.advertisement = advertisement;
        self.maxLocalUARTCreditsCount = TIO_MAX_UART_CREDITS_COUNT;
        self.minLocalUARTCreditsCount = MIN_UART_CREDITS_COUNT;
        self.shallBeSaved = YES;
    }
    return self;
}

#pragma  mark - Properties

- (NSUUID *)identifier
{
    return self.cbPeripheral.identifier;
}


- (NSString *)name
{
    //    if (self.advertisement == nil)
    //        return ([NSString stringWithFormat:@"[%@]", self.cbPeripheral.name]);
    //
    //    if (![self.advertisement.localName isEqualToString:self.cbPeripheral.name])
    //        return ([NSString stringWithFormat:@"[%@]", self.cbPeripheral.name]);
    
    if (self.cbPeripheral.name.length == 0 || [self.cbPeripheral.name isEqualToString:@"(null)"]) {
        if (self.advertisement.localName.length > 7) {
            return [self.advertisement.localName substringToIndex:7];
        } else {
            return self.advertisement.localName;
        }
    }
    return self.cbPeripheral.name;
}


- (void)setCbPeripheral:(CBPeripheral *)cbPeripheral
{
    self-> _cbPeripheral = cbPeripheral;
}

- (void)setAdvertisement:(TIOAdvertisement *)advertisement
{
    self-> _advertisement	= advertisement;
}

- (void)setIsConnecting:(BOOL)isConnecting
{
    self->_isConnecting = isConnecting;
}


- (void)setIsConnected:(BOOL)isConnected
{
    self->_isConnected = isConnected;
}

- (BOOL)isConnected {
    if (self.cbPeripheral.state != CBPeripheralStateConnected) {
        _isConnected = false;
    }
    return _isConnected;
}

- (BOOL)isConnecting {
    //    if (self.cbPeripheral.state != CBPeripheralStateConnected) {
    //        _isConnecting = false;
    //    }
    return _isConnecting;
}


@synthesize uartDataToBeWritten = _uartDataToBeWritten;
- (NSMutableData *)uartDataToBeWritten
{
    if (!self->_uartDataToBeWritten)
    {
        self->_uartDataToBeWritten = [[NSMutableData alloc] init];
    }
    return self->_uartDataToBeWritten;
}


@synthesize writeLock = _writeLock;
- (NSObject *)writeLock
{
    if (!self->_writeLock)
    {
        self->_writeLock = [[NSObject alloc] init];
    }
    return self->_writeLock;
}

- (NSString *)description
{
    return self.cbPeripheral.description;
}


- (void)setMaxLocalUARTCreditsCount:(NSInteger)maxLocalUARTCreditsCount
{
    NSInteger count = (maxLocalUARTCreditsCount < self.minLocalUARTCreditsCount) ? self.minLocalUARTCreditsCount : ((maxLocalUARTCreditsCount > TIO_MAX_UART_CREDITS_COUNT) ? TIO_MAX_UART_CREDITS_COUNT : maxLocalUARTCreditsCount	);
    self->_maxLocalUARTCreditsCount = count;
}


- (void)setMinLocalUARTCreditsCount:(NSInteger)minLocalUARTCreditsCount
{
    NSInteger count = (minLocalUARTCreditsCount > self.maxLocalUARTCreditsCount) ? self.maxLocalUARTCreditsCount : ((minLocalUARTCreditsCount < 0) ? 0 : minLocalUARTCreditsCount	);
    self->_minLocalUARTCreditsCount = count;
}


#pragma  mark - Public methods

- (void)connect
{
    STTraceMethod(self, @"connect");
    
    if (self.isConnected)
    {
        STTraceError(@"already connected...");
        return;
    }
    
    self.hadToPerformServiceDiscovery = NO;
    self.didSubscribeUARTTx = NO;
    self.didSubscribeUARTTxCredits = NO;
    self.didGrantInitialUARTRxCredits	 = NO;
    
    self.isWriting = NO;
    if (self.isConnecting) {
        NSLog(@"isconnection");
    }
    self.isConnecting = YES;
    [self processTIOConnection];
}

- (void)cancelConnection
{
    STTraceMethod(self, @"cancelConnection");
    
    _isConnected = false;
    _isConnecting = false;
    self.uartRxCharacteristic = nil;
    self.uartTxCharacteristic = nil;
    self.uartSeRxCharacteristic = nil;
    [[TIOManager sharedInstance] cancelPeripheralConnection:self];
}


- (void)writeUARTData:(NSData *)data
{
    
    if (!self.isConnected)
    {
        STTraceError(@"not connected...");
        return;
    }
    
    // append data to write buffer taking care of thread safety, as the background thread might be working on the buffer...
    @synchronized(self.writeLock)
    {
        [self.uartDataToBeWritten appendData:data];
    }
    
    [self launchUARTDataWritingOnBackgroundThread];
}

- (void)writeStartBeforeWriteData:(NSData *)data
{
    if (self.uartSeRxCharacteristic != nil) {
        [self.cbPeripheral writeValue:data forCharacteristic:self.uartSeRxCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

- (void)readRSSI
{
    //	STTraceMethod(self, @"readRSSI");
    if (!self.isConnected)
    {
        STTraceError(@"not connected...");
        return;
    }
    
    [self.cbPeripheral readRSSI];
}


#pragma mark - Internal methods

- (void)processTIOConnection
{
    STTraceMethod(self, @"processTIOConnection");
    // self.cbPeripheral.state != CBPeripheralStateConnected
    if (self.cbPeripheral.state != CBPeripheralStateConnected)
    {
        [[TIOManager sharedInstance] connectPeripheral:self];
    }
    else if (self.cbPeripheral.services == nil || self.tioService == nil)
    {
        // BLE connection has been established but the iOS service instance is not known, so a service discovery is required.
        //此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
        //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
        [self discoverServices];
        self.hadToPerformServiceDiscovery = YES;
    }
    else if (self.hadToPerformServiceDiscovery || self.uartRxCharacteristic==nil || self.uartTxCharacteristic == nil || self.uartSeRxCharacteristic == nil)
    {
        NSLog(@"hadToPerformServiceDiscovery:%d",self.hadToPerformServiceDiscovery);
        
        self.hadToPerformServiceDiscovery = NO;
        // TIO service instance is known but not all characteristics instances are known, so  a characteristics discovery is required.
        //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
        //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [self discoverCharacteristics];
        
    }
    else if (!self.didSubscribeUARTTx && !_uartTxCharacteristic.isNotifying)
    {
        // UART TX data notification subscription is required.
        [self subscribeToCharacteristic:self.uartTxCharacteristic];
    }
    else if (!self.didGrantInitialUARTRxCredits && self.mCreditInUUID.length > 0)
    {
        // UART RX credits have to be granted to the peripheral in order to establish the TerminalIO connection
        [self grantLocalUARTCredits];
    }
    else
    {
        // TIO connection has been established
        self.isConnected = YES;
        self.isConnecting = NO;
        [self raiseDidConnect];
    }
}

- (void)handleTIOConnectionErrorWithMessage:(NSString *)message
{
    STTraceMethod(self, @"handleTIOConnectionErrorWithMessage %@", message);
    
    [self cancelConnection];
    self.isConnecting = NO;
    
    NSError *error = [TIO errorWithCode:TIOConnectionError andMessage:message];
    [self raiseDidFailToConnectWithError:error];
}


- (void)discoverServices
{
    STTraceMethod(self, @"discoverServices");
    
    // erase invalid characteristics instances
    //    self.uartTxCharacteristic	= nil;
    //    self.uartTxCreditsCharacteristic = nil;
    
    [self.cbPeripheral discoverServices: @[[TIO SERVICE_UUID]]];
}


- (void)discoverCharacteristics
{
    STTraceMethod(self, @"discoverCharacteristics");
    
    [self.cbPeripheral discoverCharacteristics:nil forService:self.tioService];
}

- (void)subscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    STTraceMethod(self, @"subscribeToCharacteristic %@", characteristic);
    
    //当setNotifyValue方法调用后调用代理CBPeripheralDelegate的
    //    - (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    
    [self.cbPeripheral setNotifyValue:YES forCharacteristic:characteristic];
}


- (void)grantLocalUARTCredits
{
    STTraceMethod(self, @"grantLocalUARTCredits");
    
    if (self.pendingLocalUARTCreditsCount != 0)
        return;
    
    self.pendingLocalUARTCreditsCount = self.maxLocalUARTCreditsCount - self.localUARTCreditsCount;
    Byte value = (Byte) (self.pendingLocalUARTCreditsCount);
    NSData *valueData = [NSData dataWithBytes:&value length:1];
    [self.cbPeripheral writeValue:valueData forCharacteristic:self.uartSeRxCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)launchUARTDataWritingOnBackgroundThread
{
    STTraceMethod(self, @"launchUARTDataWritingOnBackgroundThread");
    
    // take care of thread safety of self.isWriting
    @synchronized(self.writeLock)
    {
        if (self.isWriting)
            return;
        
        self.isWriting = YES;
    }
    
    [self performSelectorInBackground:@selector(writeUARTDataBlocks) withObject:nil];
}


- (void)writeUARTDataBlocks
{
    STTraceMethod(self, @"writeUARTDataBlocks");
    
    // we are in a background thread here and will loop sending as many data blocks as possible...
    do
    {
        // take care of thread safety of self.uartDataToBeWritten, self.isWriting and self.remoteUARTCreditsCount
        @synchronized(self.writeLock)
        {
            if (!self.isConnected)
            {
                self.isWriting = NO;
                break;
            }
            
            if (self.uartDataToBeWritten.length == 0)
            {
                // write buffer empty
                [self performSelectorOnMainThread:@selector(raiseUARTWriteBufferEmpty) withObject:nil waitUntilDone:NO];
                self.isWriting = NO;
                break;
            }
            if (self.remoteUARTCreditsCount == 0 && self.mCreditInUUID.length > 0)
            {
                // no more UART credits for remote device
                self.isWriting = NO;
                break;
            }
            // get next data block
            NSData *data = [self getNextUARTDataBlock];
            
            [self.cbPeripheral writeValue:data forCharacteristic:self.uartRxCharacteristic type:CBCharacteristicWriteWithoutResponse];
            self.remoteUARTCreditsCount--;
            // notify upper layer in main thread
            [self performSelectorOnMainThread:@selector(raiseDidWriteNumberOfUARTBytes:) withObject: [NSNumber numberWithLong: data.length] waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(raiseDidUpdateRemoteUARTCreditsCount:) withObject:[NSNumber numberWithLong:self.remoteUARTCreditsCount] waitUntilDone:NO];
        }
    } while (YES);
}


- (NSData *)getNextUARTDataBlock
{
    // determine length of next data block
    NSInteger length = (self.uartDataToBeWritten.length > TIO_MAX_UART_DATA_SIZE) ? TIO_MAX_UART_DATA_SIZE : self.uartDataToBeWritten.length;
    
    // crop data to be written from buffer
    NSData *data = [self.uartDataToBeWritten subdataWithRange:NSMakeRange(0, length)];
    [self.uartDataToBeWritten replaceBytesInRange:NSMakeRange(0, length) withBytes:NULL length:0];
    
    return data;
}


#pragma mark - CBPeripheralDelegate implementation

//在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
//该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    STTraceMethod(self, @"didDiscoverServices, error %@", error);
    
    self.tioService	 = nil;
    for (CBService *service in self.cbPeripheral.services)
    {
        STTraceLine(@"discovered service %@", service.UUID);
        if ([service.UUID isEqual:[TIO SERVICE_UUID]])
        {
            STTraceLine(@"TIO service discovered");
            // memorize iOS service instance
            self.tioService = service;
            break;
        }
    }
    
    if (self.tioService == nil)
    {
        // the remote module does not provide the TIO service (should not occur...)
        [self handleTIOConnectionErrorWithMessage:@"TIO service not discovered."];
        return;
    }
    // TIO service has been discovered; proceed with TIO connection establishment
    [self processTIOConnection];
}

//该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    STTraceMethod(self, @"didDiscoverCharacteristicsForService, error %@", error);
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        STTraceLine(@"found characteristic %@", characteristic.UUID);
        if ([characteristic.UUID isEqual:[TIO UART_RX_UUID]])
        {
            STTraceLine(@"UART_RX characteristic found, properties = %@", [TIO characteristicsPropertiesToString:characteristic.properties]);
            self.uartRxCharacteristic = characteristic;
        }
        if ([characteristic.UUID isEqual:[TIO UART_TX_UUID]]) {
            self.uartTxCharacteristic = characteristic;
        }
        if ([characteristic.UUID isEqual:[TIO UART_RX_CREDITS_UUID]]) {
            self.uartSeRxCharacteristic = characteristic;
        }
    }
    
    if ( self.uartRxCharacteristic == nil || self.uartSeRxCharacteristic == nil || self.uartTxCharacteristic == nil)
    {
        // the remote module does not provide mandatory TIO characteristics (should not occur...)
        [self handleTIOConnectionErrorWithMessage:@"TIO characteristics missing."];
        
        return;
    }
    
    // TIO characteristics have been discovered; proceed with TIO connection establishment
    [self processTIOConnection];
}

//当setNotifyValue方法调用后调用代理CBPeripheralDelegate的
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    STTraceMethod(self, @"didUpdateNotificationStateForCharacteristic %@, error %@", characteristic.UUID, error);
    STTraceMethod(self, @"连接成功 %@, error %@", peripheral, error);
    
    //    if (error != nil)
    //    {
    //        // an error occurred while subscribing for notifications; cancel connection process
    //        [self handleTIOConnectionErrorWithMessage:[NSString stringWithFormat: @"Failed to subscribe for %@.", characteristic]];
    //        return;
    //    }
    if ([characteristic.UUID isEqual:[TIO UART_TX_UUID]])
    {
        STTraceLine(@"  subscribed to UART characteristic");
        self.didSubscribeUARTTx = YES;
    }
    // proceed with TIO connection establishment
    [self processTIOConnection];
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    STTraceMethod(self, @"didUpdateValueForCharacteristic %@, error %@", characteristic.value, error);
    if ([characteristic.UUID isEqual:[TIO UART_TX_UUID]])
    {
        // the remote device has sent UART data
        if (error == nil)
        {
            [self raiseDidReceiveUARTData:characteristic.value];
        }
        
        // by sending this UART data packet, the remote device has consumed one of the granted local credits
        self.localUARTCreditsCount--;
        [self raiseDidUpdateLocalUARTCreditsCount:[NSNumber numberWithLong:self.localUARTCreditsCount]];
        if (self.localUARTCreditsCount <= self.minLocalUARTCreditsCount)
        {
            // grant a reasonable amount of new credits before an underrun occurs on the remote device
            //[self grantLocalUARTCredits];
        }
    }
    else if ([characteristic.UUID isEqual:peripheral])
    {
        // the remote device has granted additional UART credits
        if (error == nil)
        {
            // extract credits count from characteristic value
            Byte *value = (Byte *) characteristic.value.bytes;
            Byte creditCount = value[0];
            // add received credits to counter taking care of write thread safety
            @synchronized (self.writeLock)
            {
                self.remoteUARTCreditsCount += creditCount;
                if (self.remoteUARTCreditsCount > TIO_MAX_UART_CREDITS_COUNT)
                {
                    STTraceError(@"invalid remote UART credit count %d", self.remoteUARTCreditsCount);
                    self.remoteUARTCreditsCount = TIO_MAX_UART_CREDITS_COUNT;
                }
                [self raiseDidUpdateRemoteUARTCreditsCount:[NSNumber numberWithLong:self.remoteUARTCreditsCount]];
            }
            // trigger writing if required
            [self launchUARTDataWritingOnBackgroundThread];
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    STTraceMethod(self, @"didWriteValueForCharacteristic %@  ————————%@, error %@", characteristic.UUID,characteristic.value, error);
    if ([characteristic.UUID isEqual:[TIO UART_RX_UUID]] || [characteristic.UUID isEqual:[TIO UART_RX_CREDITS_UUID]])
    {
        if (error==nil)
        {
            // granting of local credits to remote device was successful
            if (self.isConnecting)
            {
                self.didGrantInitialUARTRxCredits = YES;
                [self processTIOConnection];
            }
            self.localUARTCreditsCount += self.pendingLocalUARTCreditsCount;
            self.pendingLocalUARTCreditsCount = 0;
            [self raiseDidUpdateLocalUARTCreditsCount:[NSNumber numberWithLong:self.localUARTCreditsCount]];
        }
        else
        {
            if (self.isConnecting)
            {
                // an error occurred while granting intital UART credits to the remote device; cancel connection process
                [self handleTIOConnectionErrorWithMessage:[NSString stringWithFormat: @"Failed to grant initial UART credits."]];
                return;
            }
        }
    }
}
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    //	STTraceMethod(self, @"didUpdateRSSI %@, error %@", peripheral.RSSI, error);
    
    if (error != nil)
        return;
    
    [self raiseDidUpdateRSSI:peripheral.RSSI];
}


#pragma mark - Delegate events

- (void)raiseDidConnect
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheralDidConnect:)])
        [self.delegate tioPeripheralDidConnect:self];
}

- (void)raiseDidFailToConnectWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didFailToConnectWithError:)])
        [self.delegate tioPeripheral:self didFailToConnectWithError:error];
}

- (void)raiseDidDisconnectWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didDisconnectWithError:)])
        [self.delegate tioPeripheral:self didDisconnectWithError:error];
}

- (void)raiseDidReceiveUARTData:(NSData *)data
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didReceiveUARTData:)])
        [self.delegate tioPeripheral:self didReceiveUARTData:data];
}

- (void)raiseDidWriteNumberOfUARTBytes:(NSNumber *)bytesWritten
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didWriteNumberOfUARTBytes:)])
        [self.delegate tioPeripheral:self didWriteNumberOfUARTBytes:bytesWritten.intValue];
}

- (void)raiseUARTWriteBufferEmpty
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheralUARTWriteBufferEmpty:)])
        [self.delegate tioPeripheralUARTWriteBufferEmpty:self];
}

- (void)raiseDidUpdateRSSI:(NSNumber *)rssi
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didUpdateRSSI:)])
        [self.delegate tioPeripheral:self didUpdateRSSI:rssi];
}

- (void)raiseDidUpdateLocalUARTCreditsCount:(NSNumber *)creditsCount
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didUpdateLocalUARTCreditsCount:)])
        [self.delegate tioPeripheral:self didUpdateLocalUARTCreditsCount:creditsCount];
}

- (void)raiseDidUpdateRemoteUARTCreditsCount:(NSNumber *)creditsCount
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheral:didUpdateRemoteUARTCreditsCount:)])
        [self.delegate tioPeripheral:self didUpdateRemoteUARTCreditsCount:creditsCount];
}

- (void)raiseDidUpdateAdvertisement
{
    if ([self.delegate respondsToSelector:@selector(tioPeripheralDidUpdateAdvertisement:)])
        [self.delegate tioPeripheralDidUpdateAdvertisement:self];
}


#pragma mark - Internal interface towards TIOManager

+ (TIOPeripheral *)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral
{
    return [[TIOPeripheral alloc] initWithCBPeripheral:cbPeripheral andAdvertisement:nil];
}


+ (TIOPeripheral *)peripheralWithCBPeripheral:(CBPeripheral *)cbPeripheral andAdvertisement:(TIOAdvertisement *)advertisement
{
    return [[TIOPeripheral alloc] initWithCBPeripheral:cbPeripheral andAdvertisement:advertisement];
}

- (void)didConnect
{
    STTraceMethod(self, @"didConnect");
    
    [self processTIOConnection];
}


- (void)didFailToConnectWithError:(NSError *)error
{
    STTraceMethod(self, @"didFailtoConnectWithError %@", error);
    
    self.isConnected = NO;
    self.isConnecting = NO;
    [self raiseDidFailToConnectWithError:error];
}


- (void)didDisconnectWithError:(NSError *)error
{
    STTraceMethod(self, @"didDisconnectWithError %@", error);
    
    self.isConnected = NO;
    self.isConnecting = NO;
    
    self.localUARTCreditsCount = 0;
    @synchronized (self.writeLock)
    {
        self.remoteUARTCreditsCount = 0;
        self.uartDataToBeWritten = nil;
    }
    [self raiseDidUpdateLocalUARTCreditsCount:[NSNumber numberWithLong:self.localUARTCreditsCount]];
    [self raiseDidUpdateRemoteUARTCreditsCount:[NSNumber numberWithLong:self.remoteUARTCreditsCount]];
    
    [self raiseDidDisconnectWithError:error];
}


- (BOOL)updateWithAdvertisement:(TIOAdvertisement *)advertisement
{
    STTraceMethod(self, @"updateWithAdvertisement %@", advertisement);
    BOOL result = NO;
    if (![self.advertisement isEqualToAdvertisement:advertisement])
    {
        self.advertisement = advertisement;
        result = YES;
        [self raiseDidUpdateAdvertisement];
    }
    return result;
}


@end


