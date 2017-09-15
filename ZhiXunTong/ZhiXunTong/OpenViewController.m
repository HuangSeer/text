//
//  OpenViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "OpenViewController.h"
#import "PchHeader.h"
#import "MyCollectionViewCell.h"

#import "AJBDoor.h"
#import "CoreBluetooth/CoreBluetooth.h"

#define SEUDID [CBUUID UUIDWithString:@"FFF0"] /// 服务的唯一标识符
#define ReUDID [CBUUID UUIDWithString:@"FFF1"] /// 读端的唯一标识符
#define WRUDID [CBUUID UUIDWithString:@"FFF2"] /// 写端的唯一标识符
@interface OpenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AJBBlueOpenDoorDataDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSArray *classArray;
    NSArray *classArrayImage;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
}
/* 蓝牙开门数据管理对象 **/
@property (nonatomic,strong) AJBBlueOpenDoorData *BlueData;
/* 开门数据 **/
@property (nonatomic,strong) NSArray *keys;

/* 蓝牙相关 **/
@property(nonatomic,strong) CBCentralManager *manager;
@property(nonatomic,strong) CBPeripheral *mPeripheral;
@property(nonatomic,strong) CBCharacteristic *readCh;
@property(nonatomic,strong) CBCharacteristic *writeCh;

///是否已经连接上了设备，标识程序的期望，与实际是否连接无关 用于判断突然断开时判断是否需要连接
@property(nonatomic,readwrite)BOOL isConnected;
@end

@implementation OpenViewController
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    [self panduan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"一键开门";
    [self daohangView];//导航栏
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)panduan{
//    [[WebClient sharedClient] PanDuan:aatvinfo Keys:aakey State:@"1" ResponseBlock:^(id resultObject, NSError *error) {
//        NSLog(@"%@",resultObject);
//        NSString *ss=[NSString stringWithFormat:@"%@",[resultObject objectForKey:@"URL"]];
//        if (ss.length>0) {
//            //   home=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
//            // [self.view addSubview:home];
//            NSString *str=[NSString stringWithFormat:@"%@%@",URL,ss];
//            NSLog(@"str=======%@",str);
//            NSString *url = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height-64)];
//            _webView.scalesPageToFit = YES;
//            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//            [self.view addSubview:_webView];
//        }else{
            classArray =@[@"访客通行码",@"访客二维码",@"蓝牙开门",@"二维码开门"];
            classArrayImage=@[@"fangke001.png",@"erfang001.png",@"kaimen001.png",@"erweima001.png"];
            [self myCollect];
    
//        }
//        if (error!=nil) {
//            [SVProgressHUD showErrorWithStatus:@"网络异常"];
//        }
//    }];
}


-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    UICollectionView *homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-64) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //[homec registerClass:[YiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    //设置footView的尺寸大小
    layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
    
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else if (section==1)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}
//item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classArrayImage objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[classArray objectAtIndex:indexPath.item]];
//        cell.botlabel.frame=CGRectMake(-20, 70, 100, 35);
//        cell.botlabel.font=[UIFont systemFontOfSize:15];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classArrayImage objectAtIndex:indexPath.item+2]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[classArray objectAtIndex:indexPath.item+2]];
        //cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float with = (self.view.bounds.size.width-140) / 2;
    if (indexPath.section==0)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(with, with+20);
    }
    else
    {
        return CGSizeMake(Screen_Width, 10);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 10);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 0);
    }
    else
    {
        return CGSizeMake(Screen_Width, 0);
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, 190);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else
    {
        return CGSizeMake(0, 0);
    }
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(10, 60, 0, 0);
    }
    else if (section==1)
    {
        return UIEdgeInsetsMake(10, 60, 10, 10);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
#pragma mark ----- 重用的问题
    if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            UIImageView *gk=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 160)];
            
            gk.image=[UIImage imageNamed:@"guangkao001.png"];
            [headerView addSubview:gk];
            
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 160, 80, 29)];
            zclable.textColor=[UIColor orangeColor];
            zclable.text=@"访客邀请";
            [headerView addSubview:zclable];
            headerView.backgroundColor = [UIColor clearColor];
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor clearColor];
            return footerView;
        }
        
    }
    else if (indexPath.section==1)
    {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 29)];
            zclable.textColor=[UIColor orangeColor];
            zclable.text=@"我是业主";
            [headerView addSubview:zclable];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor clearColor];
            return footerView;
        }
        
    }
    else
    {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor grayColor];
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor grayColor];
            return footerView;
        }
    }

}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //NSLog(@"%@",msg);
        if (indexPath.item==0) {
            NSLog(@"访客通行ma");
        }
        else if (indexPath.item==1)
        {
            NSLog(@"访客二维码");
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.item==0) {
            NSLog(@"点击开门");
//            [SVProgressHUD showWithStatus:@"加载中"];
            [SVProgressHUD showWithStatus:@"加载中"];
            
            self.BlueData = [[AJBBlueOpenDoorData alloc] initWithHost:@"http://58.249.57.253" Port:8011];
            self.BlueData.delegate = self;
            //楼栋号 后期要根据后台获取
            [self.BlueData RequestData:@[@"9990005351010200"]];
        }
        else if (indexPath.item==1)
        {
            NSLog(@"二维码开门");
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AJBBlueOpenDoorDataDelegate

/// 加载蓝牙开门数据成功 keys 是数据数组
- (void)AJBBlueOpenDoorDidLoadData:(NSArray *)keys{
    NSLog(@"keys:-------%@",keys);
    self.keys = keys;
//    [SVProgressHUD showSuccessWithStatus:@"数据获取成功"];
    [self connect];
    
}

/// 加载蓝牙开门数据失败 Msg  是错误信息
- (void)AJBBlueOpenDoorDidFailLoadData:(NSString *)Msg{
    NSLog(@"Msg:%@",Msg);
}

#pragma mark - 下面是蓝牙搜索、设备连接、发送数据、返回数据的操作流程，可作为参考


/**
 *  2.连接设备
 */
-(void)connect{
    _manager = nil;
    _mPeripheral = nil;
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

/**
 *  3.发送数据到设备
 *
 */
-(void)sendDate{
    /// 做发送前的判断
    if (_mPeripheral.state != CBPeripheralStateConnected) {
        //处于正在连接或者断开连接状态
        NSLog(@"处于正在连接或者断开连接状态");
        _isConnected = NO;
        return ;
    }
    /// 订阅通知
    if (_mPeripheral) {
        [_mPeripheral setNotifyValue:YES forCharacteristic:_readCh];
    }
    /// 发送数据
    for (NSData *senddata in self.keys) {
        //        NSLog(@"senddata-------%@",self.keys);
        //        NSLog(@"_writeCh-------%@",_writeCh);
        //        NSLog(@"_mPeripheral-------%@",_mPeripheral);
        if (_writeCh && _mPeripheral) {
            NSLog(@"senddata-------%@",senddata);
            [_mPeripheral writeValue:senddata forCharacteristic:_writeCh type:CBCharacteristicWriteWithResponse];
        }
    }
    
    return ;
}

/**
 *  4.断开连接
 */
-(void)disConnect{
    _isConnected = NO;
    if (_mPeripheral) {
        [_manager cancelPeripheralConnection:_mPeripheral];
        NSLog(@"主动断开");
    }
    
}


#pragma mark - CBCentralManager 代理方法

/**
 *  中心设备的状态更新
 *
 *  @param central 中心设备的状态更新
 */
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state){
        case CBCentralManagerStateUnsupported:
            NSLog(@"您的设备不支持蓝牙或蓝牙4.0");
            break;
        case CBCentralManagerStatePoweredOff://蓝牙未打开，系统会自动提示打开，所以不用自行提示
            NSLog(@"蓝牙未打开,请打开蓝牙");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已打开,可扫描外设");
            [self scan];//扫描
            break;
            
        case CBCentralManagerStateUnauthorized:
            NSLog(@"未授权");
            
            break;
            
        default:
            break;
    }
}

/**
 *  扫描外设
 */
-(void)scan{
    NSLog(@"开始扫描外设。。");
    NSArray *serverlist = [[NSArray alloc]initWithObjects:SEUDID,nil];
    [_manager scanForPeripheralsWithServices:serverlist  options:nil];
}

/**
 *  发现到设备
 *
 *  @param central           central
 *  @param peripheral        已连接的peripheral
 *  @param advertisementData advertisementData
 *  @param RSSI              信号强度
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    if ([peripheral.name isEqualToString:@"Keyfobdemo"] || [peripheral.name isEqualToString:@"AjbBle"]) {
        NSLog(@"发现目标设备");
        [central stopScan];
        _mPeripheral = peripheral;
        _mPeripheral.delegate = self;
        [_manager connectPeripheral:_mPeripheral options:nil];
    }
    return ;
}

#pragma mark - CBPeripheral 代理方法

/**
 *  已经连接上设备
 *
 *  @param central    central
 *  @param peripheral peripheral
 */
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接成功");
    _mPeripheral = peripheral;
    _mPeripheral.delegate = self;
    //查找服务
    _readCh = nil;
    _writeCh = nil;
    [_mPeripheral discoverServices:@[SEUDID]];
    
}

/**
 *  连接外围设备失败
 *
 *  @return void
 */
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接外围设备失败!");
    
}

/**
 *  成功查找到服务
 *
 *  @param peripheral peripheral
 *  @param error      error
 */
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"已发现可用服务...");
    if(error){
        NSLog(@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription);
        
    }
    //遍历查找到的服务
    for (CBService *service in peripheral.services) {
        if([service.UUID isEqual:SEUDID]){
            //外围设备查找指定服务中的特征
            [peripheral discoverCharacteristics:@[ReUDID,WRUDID] forService:service];
        }
    }
}


/**
 *  外围设备查找到特征
 *
 *  @param peripheral peripheral
 *  @param service    service
 *  @param error      error
 */
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    NSLog(@"已发现可用特征...");
    if (error) {
        NSLog(@"外围设备寻找特征过程中发生错误，错误信息：%@",error.localizedDescription);
        
    }
    if ([service.UUID isEqual:SEUDID]) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            if ([characteristic.UUID isEqual:ReUDID]) {
                _readCh = characteristic;
            }
            if ([characteristic.UUID isEqual:WRUDID]) {
                _writeCh = characteristic;
            }
            if (_writeCh && _readCh) {
                //此处可以发送数据
                NSLog(@"可以发送数据");
                self.isConnected = YES;
                [self sendDate];
            }
        }
    }
    
}


- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"已经写入数据");
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
    NSLog(@"接收设备信息");
    
    /// 过滤掉干扰的数据
    if (!characteristic.isNotifying) {
        NSLog(@"订阅的标志位不正确");
        return;
    }
    
    Byte *testByte = (Byte *)[characteristic.value bytes];
    
    /// 过滤掉干扰的数据
    if (testByte == nil) {
        
        return ;
    }
    
    NSLog(@"开锁状态：%hhu",testByte[2]);
    if (testByte[2] == 0x01) {
        //开门成功
        NSLog(@"开门成功");
        [SVProgressHUD showSuccessWithStatus:@"门锁已开"];
    }
    else{
        //开门失败
        [SVProgressHUD showSuccessWithStatus:@"开门失败"];
        NSLog(@"开门失败");
    }
    return ;
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    if (_isConnected) {
        //此处需要重新连接
        [self connect];
    }
    _manager = nil;
    _mPeripheral = nil;
    NSLog(@"已经断开与设备间的连接");
}

@end
