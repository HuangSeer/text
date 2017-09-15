//
//  ViewController.m
//  LeBao
//
//  Created by 小黄人 on 2017/4/13.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import "AddBGViewController.h"
#import "PchHeader.h"
#import "AddbgTableViewCell.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"
#import <AnjubaoSDK/MediaSDK_objc.h>
#import <AnjubaoSDK/VoiceController.h>
#import <AnjubaoSDK/LANCommunication.h>
#import "LANCommunicationWrapper.h"
#import "PlayViewController.h"

@interface AddBGViewController () <UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *tableView;
    NSMutableArray *_dataArray;
    NSMutableDictionary *userInfo;
    id<AnjubaoSDK> sdk;
    id<VoiceController> voiceController;
    AJBUserGetAddress* userAddress;
    AJBIpcInfomation* ipc;
    NSMutableDictionary* map;
    NSMutableDictionary* mapIpc;
    AJBIpcFile* file;
    int _handle;
    int ssrc;
    AJBEStreamType streamType;
    
    NSString* localDirectory;
    NSMutableArray* ipcNameList;
      NSMutableArray* ipcNameList1;
    NSMutableArray* onlienArray;
     NSMutableArray* ipcNameListas;

}
@property(assign,nonatomic) NSInteger currentPage;

@end

@implementation AddBGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title=@"设备列表";
 
    [self initTableView];
    //    [self loadData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
        }
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)ipcSelected {
 
        NSString* selectedValue =ipcNameList[0];
        ipc = [mapIpc objectForKey:selectedValue];
 
    

    //    [self loadImage];
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, Screen_height-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AddbgTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ipcNameList1.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 109;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddbgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labbh.text=[NSString stringWithFormat:@"设备序列号:%@",ipcNameList1[indexPath.row]];
    NSString *ss=[NSString stringWithFormat:@"%@",onlienArray[indexPath.row]];
     cell.labzaix.text=[NSString stringWithFormat:@"%@",ss];
    NSLog(@"ss======%@",ss);
  
    if ([ss isEqualToString:@"在线"]) {
        cell.labzaix.textColor=RGBColor(90, 149, 255);
        [cell.butimag setBackgroundImage:[UIImage imageNamed:@"在线"] forState:UIControlStateNormal];
    }else if([ss isEqualToString:@"不在线"]){
        NSLog(@"%@",ss);
    cell.labzaix.textColor=[UIColor redColor];
           [cell.butimag setBackgroundImage:[UIImage imageNamed:@"不在线"] forState:UIControlStateNormal];
    }
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayViewController *PlayV=[[PlayViewController alloc] init];
    PlayV.ipcname=ipcNameList[indexPath.row];
      PlayV.ipcname2=ipcNameListas[indexPath.row];
    PlayV.ind=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"PlayV.indPlayV.ind=============%@",PlayV.ind);
    [self.navigationController pushViewController:PlayV animated:NO];
    self.tabBarController.tabBar.hidden=YES;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sdk = [AnjubaoSDK instance];
    voiceController = [VoiceController voiceController];
    
    map = [[NSMutableDictionary alloc] init];
    AJBUserGetAddress* address = [sdk userGetAddress];
    
    if (address && address.res == ErrorCode_ERR_OK) {
        userAddress = address;
        [map removeAllObjects];
        
        ipcNameList= [[NSMutableArray alloc] init];
        ipcNameListas= [[NSMutableArray alloc] init];
        ipcNameList1= [[NSMutableArray alloc] init];
        onlienArray= [[NSMutableArray alloc] init];
        NSString *stronli;
        //        NSString *address=[address]
        
        for (AJBAddressInfo* a in [address my_address]) {
            
            for (AJBIpcInfomation* i in [a ipcs]) {
                NSString* ipcName1 =
                [NSString stringWithFormat:@"%@", i.ipc_serial_number];
                NSString* ipcName = [NSString stringWithFormat:@"%@_%@", a.name, i.ipc_serial_number];
                NSString* ipcName2 = [NSString stringWithFormat:@"%@",i.ipc_serial_number];
                NSLog(@"ipcName2=======%@",ipcName2);
                NSString *stronline=[NSString stringWithFormat:@"%@",i.online?@"YES":@"NO"];
                if ([stronline containsString:@"YES"]) {
                    stronli=[NSString stringWithFormat:@"在线"];
                    
                }else{
                    stronli=[NSString stringWithFormat:@"不在线"];
                }
                
                [map setObject:i
                        forKey:ipcName];
                
                [ipcNameList1 addObject:ipcName1];
                [onlienArray addObject:stronli];
                [ipcNameList addObject:ipcName];
                [ipcNameListas addObject:ipcName2];
            }
        
        }
        [self ipcSelected];
        [tableView reloadData];
    }
    

}

@end
