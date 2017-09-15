//
//  SheZViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/27.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SheZViewController.h"
#import "PchHeader.h"
#import "SheZTableViewCell.h"
#import "iOSToast.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "PlayViewController.h"
#import <AnjubaoSDK/MediaSDK_objc.h>
#import <AnjubaoSDK/VoiceController.h>
#import <AnjubaoSDK/LANCommunication.h>
#import "UIGLView.h"
#import "JiaJuViewController.h"
#import "AddBGViewController.h"

@interface SheZViewController ()<UITableViewDelegate, UITableViewDataSource>{
 UITableView *tableView;
    NSString* localDirectory;
    NSMutableArray* ipcNameList;
    NSMutableArray* onlienArray;
    AJBReqWatchIpc* lastReq;
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
    UIGLView *UIGLV;
    NSArray *shezArray;
     NSArray *imageArray;
    NSString* ipcName;
    NSString* ipcwifi;
      NSMutableArray* ipcwifiList;
}

@end

@implementation SheZViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [ipcNameList removeAllObjects];
    shezArray=@[@"设备号",@"智能家居设备列表",@"智能设备wifi配置"];
    imageArray=@[@"摄像头",@"列表",@"wifi"];
    [self initTableView];
    sdk = [AnjubaoSDK instance];
    voiceController = [VoiceController voiceController];
    
    map = [[NSMutableDictionary alloc] init];
    AJBUserGetAddress* address = [sdk userGetAddress];
    if (address && address.res == ErrorCode_ERR_OK) {
        userAddress = address;
        [map removeAllObjects];
        
        ipcNameList= [[NSMutableArray alloc] init];
        ipcwifiList= [[NSMutableArray alloc] init];
        onlienArray= [[NSMutableArray alloc] init];
        NSString *stronli;
        for (AJBAddressInfo* a in [address my_address]) {
            NSLog(@"asd======%@",[a ipcs]);
            for (AJBIpcInfomation* i in [a ipcs]) {
                ipcName =
                [NSString stringWithFormat:@"%@", i.ipc_serial_number];
                 ipcwifi=[NSString stringWithFormat:@"所属wifi:%@", i.ipc_wifi];
                
                NSString *stronline=[NSString stringWithFormat:@"%@",i.online?@"YES":@"NO"];
                
                [map setObject:i
                        forKey:ipcName];
                [ipcNameList addObject:ipcName];
                [ipcwifiList addObject:ipcwifi];
                
                [onlienArray addObject:stronline];
            }
            
            NSLog(@"asd======%@============",ipcNameList);
        }
        
        [self ipcSelected];
    }
    
    NSString* document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    localDirectory = document;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
   
    // Do any additional setup after loading the view.
}
-(void)ipcSelected {
    NSString* selectedValue =ipcNameList[0];
    ipc = [map objectForKey:_ipcname];
    
    if (ipc) {
        [MediaSDK SetBackgroundImage:ipc.ipc_id
                                    :UIGLV
                                    :NO
                                    :YES];
    }
    NSLog(@"%@__2=======__===%@=================%@===============%@=========%@",selectedValue,ipc,ipcNameList[0],_ipcname,map);
    [tableView reloadData];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SheZTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:tableView];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewwei=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    viewwei.backgroundColor=[UIColor whiteColor];
    UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 5)];
    viewxian.backgroundColor=RGBColor(238, 238, 238);
    [viewwei addSubview:viewxian];
    UIButton *butwei=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/2.5)/2, 20, Screen_Width/2.5, 30)];
    butwei.backgroundColor=[UIColor redColor];
    [butwei setTitle:[NSString stringWithFormat:@"删除设备"] forState:UIControlStateNormal];
    butwei.clipsToBounds=YES;
    [butwei addTarget:self action:@selector(buttjxuzview) forControlEvents:UIControlEventTouchUpInside];
    butwei.layer.cornerRadius=5;
    [viewwei addSubview:butwei];
    return viewwei;
    
    
}
//设置标题尾的宽度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return shezArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SheZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    tableView.separatorStyle = NO;
    cell.lab1.text=shezArray[indexPath.row];
    int intString = [_ind intValue];
    if ([cell.lab1.text isEqualToString:@"设备号"]) {
     cell.lab2.text=[NSString stringWithFormat:@"%@",ipcNameList[intString]];
    }else if([cell.lab1.text isEqualToString:@"智能设备wifi配置"]){
      cell.lab2.text=[NSString stringWithFormat:@"%@",ipcwifiList[intString]];
    }else{
     cell.lab2.text=@"";
    
    }
   
    [cell.butimage setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[indexPath.row]]] forState:UIControlStateNormal];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
      
        AddBGViewController *AddBGV=[[AddBGViewController alloc] init];

        [self.navigationController pushViewController:AddBGV animated:NO];
    }
}

-(void)buttjxuzview{
    if (!ipc) {
        return;
    }
    NSLog(@"%@=========%@",ipc.address_id,ipc.ipc_id);
    if (ErrorCode_ERR_OK == [sdk addressRemoveIpcs:ipc.address_id ipcIds:[NSMutableArray arrayWithObjects:ipc.ipc_id, nil] isDelData:NO isDelSensor:NO]) {
        [iOSToast toast:[NSString stringWithFormat:@"解绑%@成功", ipc.ipc_serial_number] :1];
        for (UIViewController *temp in self.navigationController.viewControllers)
        {
            if ([temp isKindOfClass:[JiaJuViewController class]])
            {
                [self.navigationController popToViewController:temp animated:NO];
            }
        }

        
    } else {
        [iOSToast toast:[NSString stringWithFormat:@"解绑%@失败", ipc.ipc_serial_number] :1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
