//
//  TIOManager.m
//  TerminalIO
//
//  Created by Lutz Vogelsang on 27.09.13.
//  Copyright (c) 2013 Lutz Vogelsang. All rights reserved.
//

#import "TIO.h"
#import "TIOManager_internal.h"
#import "TIOPeripheral_internal.h"
#import "TIOAdvertisement.h"
#import "STTrace.h"
#import "AppDelegate.h"

const NSString *BLENAME = @"1079495";

@interface TIOManager () <CBCentralManagerDelegate>{
    BOOL riss;
}

@property (strong, nonatomic) CBCentralManager *cbCentralManager;
@property (strong, nonatomic)   NSMutableArray *tioPeripherals;
@property (strong, nonatomic)         NSString *RSSI;
@property (strong, nonatomic)         AppDelegate *app;
@property (strong, nonatomic) NSTimer *scantimer;

@end



@implementation TIOManager

NSString *const KNOWN_PERIPHERAL_IDS_FILE_NAME = @"TIOKnownPeripheralIdentifiers";

#pragma  mark - Initialization

- (TIOManager *) init
{
	self = [super init];
	if (self)
	{
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
		// Allocate the IOS Core Bluetooth Central Manager instance opting for restoration.
		self.cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:queue options:@{CBCentralManagerOptionRestoreIdentifierKey:@"TIOManager"}];
		// Allocate an array for holding the discovered peripheral instances.
		self.tioPeripherals = [[NSMutableArray alloc] init];
	}
	return self;
}


#pragma  mark - Properties

- (NSMutableArray *)peripherals
{
	return self.tioPeripherals;
}

#pragma mark - Public methods

+ (TIOManager *)sharedInstance
{
	// Lazyly instantiated TIOManager singleton.
	static __strong TIOManager *_sharedInstance = nil;
	if (!_sharedInstance)
	{
		_sharedInstance = [[TIOManager alloc] init];
	}
	return _sharedInstance;
}

- (CBCentralManagerState)state {
    return self.cbCentralManager.state;
}

- (void)startScan
{
	STTraceMethod(self, @"startScan");
    
	// Scan for devices exposing the TerminalIO Service; do not allow duplicates (default options).
	[self.cbCentralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"A08F7710-C37C-11E3-99CC-0228AC012A70"]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    //sleep(10);
}


- (void)startUpdateScan
{
	STTraceMethod(self, @"startUpdateScan");
	
	// Scan for devices exposing the TerminalIO Service; do allow duplicates.
	// This option is not recommended, leads to increased power consumption and may be disabled by the OS when in background mode.
	// It is used here in order to capture dynamically changing advertisement information during this scan procedure.
    
//    NSDictionary* scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];

	[self.cbCentralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"A08F7710-C37C-11E3-99CC-0228AC012A70"]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}


- (void)stopScan
{
	STTraceMethod(self, @"stopScan");
	
	// Stop scan.
	[self.cbCentralManager stopScan];
}


- (void)loadPeripherals
{
	STTraceMethod(self, @"loadPeripherals");
	
	NSString *path = [TIO pathWithFileName:KNOWN_PERIPHERAL_IDS_FILE_NAME];
	NSMutableArray* idList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	if (idList == nil)
	{
		STTraceError(@"failed to deserialize identifier list");
		return;
	}

	NSArray *idArray = [idList copy];
	NSArray	 *list = [self.cbCentralManager retrievePeripheralsWithIdentifiers:idArray];
	for (CBPeripheral *peripheral in list)
	{
		// check for existing instance
		TIOPeripheral *knownPeripheral = [self findTIOPeripheralByIdentifier:peripheral.identifier];
		if (knownPeripheral != nil)
		{
			continue;
		}
		STTraceLine(@"retrieved peripheral %@", peripheral);
		// Create a new TIOPeripheral instance from discovered data.
		TIOPeripheral *tioPeripheral = [TIOPeripheral peripheralWithCBPeripheral:peripheral];
		// Add new instance to collection.
		[self.tioPeripherals addObject:tioPeripheral];
		// Notify delegate.
		[self raiseDidRetrievePeripheral:tioPeripheral];
	}
}

- (void)savePeripherals
{
	STTraceMethod(self, @"savePeripherals");
	
	NSMutableArray *idList = [[NSMutableArray alloc] init];
	for (TIOPeripheral *peripheral in self.peripherals)
	{
		if (peripheral.shallBeSaved)
		{
			[idList addObject:peripheral.cbPeripheral.identifier];
		}
	}
	NSString *path = [TIO pathWithFileName:KNOWN_PERIPHERAL_IDS_FILE_NAME];
	if (![NSKeyedArchiver archiveRootObject:idList toFile:path])
	{
		STTraceError(@"failed to serialize identifier list");
	}
}

- (void)removePeripheral:(TIOPeripheral *)peripheral
{
	STTraceMethod(self, @"removePeripheral %@", peripheral);
	// disconnect
	[peripheral cancelConnection];
	// remove instance from collection
	[self.tioPeripherals removeObject:peripheral];
	// save updated peripheral collection
	[self savePeripherals];
}


- (void)removeAllPeripherals
{
	STTraceMethod(self, @"removeAllPeripherals");

	for (TIOPeripheral *peripheral in self.tioPeripherals)
	{
		// disconnect
		[peripheral cancelConnection];
	}
	[self.tioPeripherals removeAllObjects];
	// save cleared peripheral collection
	[self savePeripherals];
}


#pragma mark - Internal methods

- (TIOPeripheral *)findTIOPeripheralByIdentifier:(NSUUID *)identifier
{
	STTraceMethod(self, @"findTIOPeripheralByIdentifier %@", identifier);
	
	// Iterate through known peripherals.
	for (TIOPeripheral *peripheral in self.tioPeripherals)
	{
		if ([peripheral.identifier isEqual:identifier])
		{
			// Found matching TIOPeripheral instance.
			return peripheral;
		}
	}
	
	return nil;
}

#pragma mark - CBCentralManagerDelegate implementation
//当central管理器的状态发生更新时调用
//当central管理器更新状态时调用。这个方法是必须实现的，为了确保当前的central设备是否支持BLE以及当前是否可以被利用，当检测到central蓝牙已经打开时，需要做一些操作，比如开始寻找Peripheral。当状态改变为CBCentralManagerStatePoweredOff时，会结束当前的寻找以及断开当前连接的peripheral。当检测到PoweredOff这个状态是所有的APP必须重新开始检索以及寻找
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
	STTraceMethod(self, @"centralManagerDidUpdateState %d", central.state);
	
	if (central.state == CBCentralManagerStatePoweredOn)
	{
		[self raiseBluetoothAvailable];
	}
	else
	{
		[self raiseBluetoothUnavailable];
	}
}

//当central管理器涉及到要被系统来恢复时调用。
//这个方法是说coreBluetooth为APP提供了一个保留和回复的功能，当APP需要在后台完成蓝牙相关的任务时，这是你第一个调用的方法，用这个方法可以是APP与系统蓝牙进行同步。
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
	STTraceMethod(self, @"centralManagerWillRestoreState %@", dict);

//	NSLog(@"centralManagerWillRestoreState %@", dict);
}
//查找蓝牙设备 当central管理者检索与系统连接的一系列peripheral设备时调用。
//当central管理器发现一个peripheral时调用，广播的数据被以AdvertisementDataRetrievalKeys键值的形式接受。你必须建立一个本地的副本，当需要对他进行操作时。在一般的情况下，你的APP要保证能够在一定的范围内自动连接还是上peripheral，你能够使用RSSI的值来判断与发现的peripheral的距离
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
	STTraceMethod(self, @"centralManagerDidDiscoverPeripheral %@  rssi:%@", peripheral.name, RSSI);
    
//    NSLog(@"advertisementData___%@",advertisementData);
	// Instantiate a TIOAdvertisement from discovered advertisement data.
    
    if ([[advertisementData objectForKey:@"kCBAdvDataLocalName"] isEqual:BLENAME]) {
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        self.RSSI = [numberFormatter stringFromNumber:RSSI];
    }
    
	TIOAdvertisement *advertisement = [TIOAdvertisement advertisementWithData:advertisementData];
	if (advertisement == nil)
	{
		STTraceError(@"invalid advertisement");
		//return;
	}
	// Check for already known TIOPeripheral instance.
	TIOPeripheral *knownPeripheral = [self findTIOPeripheralByIdentifier:peripheral.identifier];
	if (knownPeripheral != nil)
	{
		if ([knownPeripheral updateWithAdvertisement:advertisement])
		{
			// The advertisement contains new information and has been updated within the peripheral instance.
			[self raiseDidUpdatePeripheral:knownPeripheral];
		}
		else
		{
			STTraceError(@"peripheral already known");
		}
		return;
	}
	// Create a new TIOPeripheral instance from discovered data.
	TIOPeripheral *newPeripheral = [TIOPeripheral peripheralWithCBPeripheral:peripheral andAdvertisement:advertisement];
	// Add new instance to collection.
	[self.tioPeripherals addObject:newPeripheral];
	// Notify delegate.
	[self raiseDidDiscoverPeripheral:newPeripheral];
	// save updated peripheral collection
	[self savePeripherals];
}

//当与peripheral成功建立连接时调用。当调用connectPeripheral：options成功时，此方法被调用，当然也可以专门实现该方法来设置peripheral的代理以及发现它的服务。。

//此时设备已经连接上了  你要做的就是找到该设备上的指定服务 调用完该方法后会调用代理CBPeripheralDelegate（现在开始调用另一个代理的方法了）的
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接成功");
	STTraceMethod(self, @"centralManagerDidConnectPeripheral %@", peripheral);
	// Find the corresponding TIOPeripheral instance...
	TIOPeripheral *tioPeripheral = [self findTIOPeripheralByIdentifier:peripheral.identifier];
	if (tioPeripheral)
	{
      // ... and let the TIOPeripheral instance handle the event.
		[tioPeripheral didConnect];
	}
}

//当central管理者与peripheral建立连接失败时调用。
//这个方法在方法connectPeripheral：options建立的连接断开时调用，应为建立连接的动作是不能超时的，通常在失败连接时你需要再次试图连接peripheral。
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
	STTraceMethod(self, @"centralManagerDidFailToConnectPeripheral %@", peripheral);

	// Find the corresponding TIOPeripheral instance...
	TIOPeripheral *tioPeripheral = [self findTIOPeripheralByIdentifier:peripheral.identifier];
	if (tioPeripheral)
	{
		// ... and let the TIOPeripheral instance handle the event.
		[tioPeripheral didFailToConnectWithError:error];
	}
}

//当已经与peripheral建立的连接断开时调用。
//当已经建立的连接被断开时调用。这个方法在connectPeripheral：options方法建立的连接断开是调用，如果断开连接不是有cancelPeripheralConnection方法发起的，那么断开连接的详细信息就在error参数中，当这个方法被调用只有peripheral代理中的方法不在被调用。注意：当peripheral断开连接时，peripheral所有的service、characteristic、descriptors都无效。
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
	STTraceMethod(self, @"centralManagerDidDisconnectPeripheral %@   error————%@", peripheral,error);
    //APPDELEGATE.periconnected = @"disconnect";
   //APPDELEGATE.periconnected = @"disconnect";
	// Find the corresponding TIOPeripheral instance...
	TIOPeripheral *tioPeripheral = [self findTIOPeripheralByIdentifier:peripheral.identifier];
	if (tioPeripheral)
	{
		// ... and let the TIOPeripheral instance handle the event.
		[tioPeripheral didDisconnectWithError:error];
	}
     [self.cbCentralManager scanForPeripheralsWithServices:nil options:nil];
    
   //    [self raiseDidConnectPeripheral:tioPeripheral];
}


#pragma mark - Delegate events

- (void)raiseBluetoothAvailable
{
	if ([self.delegate respondsToSelector:@selector(tioManagerBluetoothAvailable:)])
		[self.delegate tioManagerBluetoothAvailable:self];
}
- (void)raiseBluetoothUnavailable
{
	if ([self.delegate respondsToSelector:@selector(tioManagerBluetoothUnavailable:)])
		[self.delegate tioManagerBluetoothUnavailable:self];
}

- (void)raiseDidDiscoverPeripheral:(TIOPeripheral *)peripheral
{
	if ([self.delegate respondsToSelector:@selector(tioManager:didDiscoverPeripheral:)])
		[self.delegate tioManager:self didDiscoverPeripheral:peripheral];
}

- (void)raiseDidRetrievePeripheral:(TIOPeripheral *)peripheral
{
	if ([self.delegate respondsToSelector:@selector(tioManager:didRetrievePeripheral:)])
		[self.delegate tioManager:self didRetrievePeripheral:peripheral];
}

- (void)raiseDidUpdatePeripheral:(TIOPeripheral *)peripheral
{
	if ([self.delegate respondsToSelector:@selector(tioManager:didUpdatePeripheral:)])
		[self.delegate tioManager:self didUpdatePeripheral:peripheral];
}

- (void)raiseDidConnectPeripheral:(TIOPeripheral *)peripheral{
    if ([self.delegate respondsToSelector:@selector(tioManager:didConnectPeripheral:)])
        [self.delegate tioManager:self didConnectPeripheral:peripheral];
}


#pragma mark - Internal interface towards TIOPeripheral

- (void)connectPeripheral:(TIOPeripheral *)peripheral
{
	STTraceMethod(self, @"connectPeripheral %@", peripheral);
    
	[self.cbCentralManager connectPeripheral:peripheral.cbPeripheral options:nil];
}

- (void)cancelPeripheralConnection:(TIOPeripheral *)peripheral
{
	STTraceMethod(self, @"cancelPeripheralConnection %@", peripheral);
    
	[self.cbCentralManager cancelPeripheralConnection:peripheral.cbPeripheral];
}


@end

