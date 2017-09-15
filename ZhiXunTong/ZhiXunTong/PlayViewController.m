
//
//  PlayViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/25.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PlayViewController.h"
#import "PchHeader.h"
#import "UIGLView.h"
#import <AnjubaoSDK/AnjubaoSDK.h>
#import "iOSToast.h"
#import <AnjubaoSDK/MediaSDK_objc.h>
#import <AnjubaoSDK/VoiceController.h>
#import <AnjubaoSDK/LANCommunication.h>
#import "HomeViewController.h"
#import "SheZViewController.h"

#import "LANCommunicationWrapper.h"

@interface PlayViewController (){
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
    
    UIButton *butplay;
     UIButton *button;
    NSString* localDirectory;
    NSMutableArray* ipcNameList;
     NSMutableArray* onlienArray;
    AJBReqWatchIpc* lastReq;
    UIButton *palybut;
    UIGLView *UIGLV;
    
}

@end

@implementation PlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if (_handle != -1) {
        [MediaSDK Stop:_handle];
        if (![LANCommunicationWrapper getIpcInfo:ipc.ipc_serial_number]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [sdk reqStopWatchIpc:streamType ipcId:ipc.ipc_id url:lastReq.url_address_rtsp isException:NO];
            });
        }
    }
    [self initPlayUI];
    NSLog(@"_ipcname%@",_ipcname);
    self.navigationItem.title=@"智能设备";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    sdk = [AnjubaoSDK instance];
    voiceController = [VoiceController voiceController];
    
    map = [[NSMutableDictionary alloc] init];
    AJBUserGetAddress* address = [sdk userGetAddress];
    if (address && address.res == ErrorCode_ERR_OK) {
        userAddress = address;
        [map removeAllObjects];
        
        ipcNameList= [[NSMutableArray alloc] init];
         onlienArray= [[NSMutableArray alloc] init];
        NSString *stronli;
        for (AJBAddressInfo* a in [address my_address]) {
            NSLog(@"asd======%@",[a ipcs]);
            for (AJBIpcInfomation* i in [a ipcs]) {
                NSString* ipcName =
                [NSString stringWithFormat:@"%@_%@", a.name, i.ipc_serial_number];
             
                NSString *stronline=[NSString stringWithFormat:@"%@",i.online?@"YES":@"NO"];
     
                [map setObject:i
                        forKey:ipcName];
                [ipcNameList addObject:ipcName];
                [onlienArray addObject:stronline];
            }
              
        }
         [self ipcSelected];
    }
    for (AJBAddressInfo* a in [address invite_address]) {
        for (AJBIpcInfomation* i in [a ipcs]) {
            NSString* ipcName =
            [NSString stringWithFormat:@"%@_%@", a.name, i.ipc_serial_number];
            [map setObject:i
                    forKey:ipcName];
            [ipcNameList addObject:ipcName];
        }
    }
    
    for (AJBAddressInfo* a in [address public_address]) {
        for (AJBIpcInfomation* i in [a ipcs]) {
            NSString* ipcName =
            [NSString stringWithFormat:@"%@_%@", a.name, i.ipc_serial_number];
            [map setObject:i
                    forKey:ipcName];
            [ipcNameList addObject:ipcName];
        }
    }
    
    NSString* document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    localDirectory = document;


         [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(one) userInfo:nil repeats:YES];




}

-(void)btnCkmore
{
      IPCInfo* info = [LANCommunicationWrapper getIpcInfo:ipc.ipc_serial_number];
    if (!info) { // 走公网
        if (_handle >= 0) {
            [MediaSDK Stop:_handle];
            _handle = -1;
        }
    } else { // 走局域网
        if (_handle >= 0) {
            [MediaSDK Stop:_handle];
            _handle = -1;
        }
    }
    [_isHD setEnabled:NO];
     [self.navigationController popViewControllerAnimated:NO];
}



-(void)initPlayUI{
    UIGLV=[[UIGLView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width , Screen_height/3)];
    UIGLV.backgroundColor=[UIColor blackColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapUIGLV)];
    [UIGLV addGestureRecognizer:singleTap];
    butplay=[[UIButton alloc]initWithFrame:CGRectMake((UIGLV.frame.size.width-30)/2, (UIGLV.frame.size.height-30)/2, 30, 30)];
    [butplay setBackgroundImage:[UIImage imageNamed:@"plays.png"] forState:UIControlStateNormal];
    [butplay addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [UIGLV addSubview:butplay];
    UIView *Viewbj=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/3, Screen_Width, (Screen_height-Screen_height/3))];
    Viewbj.backgroundColor=RGBColor(0, 184, 255);
     NSArray *imagearray=@[@"声音.png",@"录像2.png",@"截图2.png",@"布防.png"];
    for (int i = 0 ; i < imagearray.count; i++) {
        button = [[UIButton alloc]initWithFrame:CGRectMake(Viewbj.frame.size.width/imagearray.count*i+20, 20,40, 40)];
        [button setBackgroundImage:[UIImage  imageNamed:imagearray[i]] forState:UIControlStateNormal];
             button.tag = i+1;
        NSLog(@"%ld",(long)button.tag);
        [button addTarget:self action:@selector(mapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [Viewbj addSubview:button];
        
        
    }
    [self.view addSubview:Viewbj];
    UIButton *butsh=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-150)/2, 100, 150, 150)];
    [butsh setBackgroundImage:[UIImage imageNamed:@"麦1.png"] forState:UIControlStateNormal];
    [butsh addTarget:self action:@selector(butshview:) forControlEvents:UIControlEventTouchUpInside];
    [Viewbj addSubview:butsh];
    
    UIView * backVieww = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItemw = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 20, 18)];
    [backItemw setImage:[UIImage imageNamed:@"sz.png"] forState:UIControlStateNormal];
    [backItemw addTarget:self action:@selector(backItemwview) forControlEvents:UIControlEventTouchUpInside];
    [backVieww addSubview:backItemw];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItemw];
    [self.navigationItem setRightBarButtonItem:leftItemBar];
    [self.view addSubview:UIGLV];


}
-(void)playbutview{
    NSLog(@"=2=2=2======%@",ipc);
    if (!ipc) {
        return;
    }
    if (ErrorCode_ERR_OK == [sdk addressRemoveIpcs:ipc.address_id ipcIds:[NSMutableArray arrayWithObjects:ipc.ipc_id, nil] isDelData:NO isDelSensor:NO]) {
        [iOSToast toast:[NSString stringWithFormat:@"解绑%@成功", ipc.ipc_serial_number] :1];
    } else {
        [iOSToast toast:[NSString stringWithFormat:@"解绑%@失败", ipc.ipc_serial_number] :1];
    }
}
-(void)ipcSelected {
    NSLog(@"_ipcname=================%@",_ipcname);
    NSString* selectedValue =ipcNameList[0];
    ipc = [map objectForKey:_ipcname];

    if (ipc) {
        [MediaSDK SetBackgroundImage:ipc.ipc_id
                                    :UIGLV
                                    :NO
                                    :YES];
    }
  NSLog(@"%@__2=======__===%@=================%@===============%@=========%@======%@",selectedValue,ipc,ipcNameList[0],_ipcname,map);
    
}
-(void)handleSingleTapUIGLV{
[butplay setHidden:NO];
}
-(void)backItemwview{
   
    IPCInfo* info = [LANCommunicationWrapper getIpcInfo:ipc.ipc_serial_number];
    if (!info) { // 走公网
        if (_handle >= 0) {
            [MediaSDK Stop:_handle];
            _handle = -1;
        }
    } else { // 走局域网
        if (_handle >= 0) {
            [MediaSDK Stop:_handle];
            _handle = -1;
        }
    }
    [_isHD setEnabled:NO];
 
    SheZViewController *SheZV=[[SheZViewController alloc] init];
    SheZV.ipcname=_ipcname2;
     SheZV.ind=_ind;
    NSLog(@"ipcName2==================%@",_ipcname2);
    [self.navigationController pushViewController:SheZV animated:NO];
    self.tabBarController.tabBar.hidden=YES;
}
- (void)buttonClick:(UIButton *)buttonClick{
    if (!ipc) {
        return;
    }
      IPCInfo* info = [LANCommunicationWrapper getIpcInfo:ipc.ipc_serial_number];
    NSLog(@"%d",buttonClick.selected);
    buttonClick.selected = !buttonClick.selected;
    [butplay setHidden:YES];
    if(buttonClick.selected) {
            [buttonClick setBackgroundImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal];
        if (!info) { // 走公网
            lastReq = [sdk reqWatchIpc:EStreamType_E_STR_NOTYPE ipcId:ipc.ipc_id addressId:ipc.address_id];
            if (lastReq && ErrorCode_ERR_OK == lastReq.res) {
                streamType = lastReq.ss_type;
                _handle =
                [MediaSDK Play:lastReq.url_address_rtsp
                              :UIGLV
                              :YES
                              :1
                              :200
                              :@""
                              :ipc.ipc_id
                              :YES
                              :self];
                if (_handle >= 0) {
                    [_isHD setOn:(streamType == EStreamType_E_STR_SUB_720P)];
                    [_isHD setEnabled:YES];
//                    [playButton setTitle:@"停止播放" forState:UIControlStateNormal];
                } else {
                    [sdk reqStopWatchIpc:EStreamType_E_STR_NOTYPE ipcId:ipc.ipc_id url:lastReq.url_address_rtsp isException:YES];
                }
            }
        } else { // 走局域网
            _handle =
            [MediaSDK Play:info.mainStreamUrl
                          :UIGLV
                          :YES
                          :1
                          :200
                          :@""
                          :ipc.ipc_id
                          :YES
                          :self];
            if (_handle >= 0) {
                streamType = EStreamType_E_STR_SUB_720P;
                [_isHD setOn:(streamType == EStreamType_E_STR_SUB_720P)];
                [_isHD setEnabled:YES];
//                [playButton setTitle:@"停止播放" forState:UIControlStateNormal];
            }
        }

        
 
    }else {
        [buttonClick setBackgroundImage:[UIImage imageNamed:@"plays.png"] forState:UIControlStateNormal];
        if (!info) { // 走公网
                if (_handle >= 0) {
                    [MediaSDK Stop:_handle];
                    _handle = -1;
                }
                //[sdk reqStopWatchIpc:streamType ipcId:ipc.ipc_id url:lastReq.url_address_rtsp isException:NO];
            } else { // 走局域网
                if (_handle >= 0) {
                    [MediaSDK Stop:_handle];
                    _handle = -1;
                }
            }
            [_isHD setEnabled:NO];
//            [playButton setTitle:@"播放" forState:UIControlStateNormal];
        }
    }
-(void)one{
[butplay setHidden:YES];

}

-(void)butshview:(UIButton *)butshview{
    IPCInfo* info = [LANCommunicationWrapper getIpcInfo:ipc.ipc_serial_number];

    butshview.selected = !butshview.selected;
    if(butshview.selected) {
        if (!info) { // 走公网
            AJBReqStartTalkIpc* result = [sdk reqStartTalkIpc:ipc.ipc_id];
            if (result && ErrorCode_ERR_OK == result.res) {
                if ([voiceController startVoiceTalk:([HomeViewController instance].isVersion2 ? result.server_host : result.streamexchange_ip)
                                               Port:([HomeViewController instance].isVersion2 ? [result.rtp_port intValue] : result.streamexchange_port)
                                               Ssrc:result.app_ssrc]) {
                    ssrc = result.app_ssrc;
                } else {
                    [sdk reqStopTalkIpc:ipc.ipc_id ssrc:result.app_ssrc];
                }
            }
        } else { // 走局域网
             [butshview setBackgroundImage:[UIImage imageNamed:@"麦"] forState:UIControlStateNormal];
            AJBVoiceTalkReqInfo* req = [[AJBVoiceTalkReqInfo alloc] init];
            req.production_id = strtol([ipc.ipc_serial_number UTF8String], NULL, 16);
            AJBVoiceTalkReqInfo* result = (AJBVoiceTalkReqInfo*)[LANCommunicationWrapper sendMsgToIpc:ipc.ipc_serial_number :req];
            if (result && result.err_resp == ErrorCode_ERR_OK) {
                if ([voiceController startVoiceTalk:result.vts_addr.ip Port:result.vts_addr.port Ssrc:result.ipc_ssrc]) {
                    ssrc = result.ipc_ssrc;
                } else {
                    AJBVoiceTalkStop* reqStop = [[AJBVoiceTalkStop alloc] init];
                    reqStop.production_id = strtol([ipc.ipc_serial_number UTF8String], NULL, 16);
                    [LANCommunicationWrapper sendMsgToIpc:ipc.ipc_serial_number :reqStop];
                }
            }
        }
        

      
        
    }else {
         [butshview setBackgroundImage:[UIImage imageNamed:@"麦1"] forState:UIControlStateNormal];
        
        if (!info) { // 走公网
            [voiceController stopVoiceTalk];
            [sdk reqStopTalkIpc:ipc.ipc_id ssrc:ssrc];
        } else { // 走局域网
            [voiceController stopVoiceTalk];
            AJBVoiceTalkStop* reqStop = [[AJBVoiceTalkStop alloc] init];
            reqStop.production_id = strtol([ipc.ipc_serial_number UTF8String], NULL, 16);
            [LANCommunicationWrapper sendMsgToIpc:ipc.ipc_serial_number :reqStop];
        }
//        [talkButton setTitle:@"对讲" forState:UIControlStateNormal];
    }

  
    }


//点击按钮方法,这里容易犯错
-(void)mapBtnClick:(UIButton *)mapBtnClick{
    //记住,这里不能写成"mapBtn.tag",这样你点击任何一个button,都只能获取到最后一个button的值,因为前边的按钮都被最后一个button给覆盖了
//    DYziyemViewController *DYziyemV = [[DYziyemViewController alloc] init];
    if (mapBtnClick.tag==1) {
         mapBtnClick.selected = !mapBtnClick.selected;
        if(mapBtnClick.selected) {
            if (_handle >= 0) {
                [MediaSDK CloseSound:_handle];
                _handle = -1;
            }
            [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"声音1.png"] forState:UIControlStateNormal];
            
        }else {
            if (_handle < 0) {
                [MediaSDK OpenSound:0];
                _handle=0;
            }
            [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"声音"] forState:UIControlStateNormal];
        }

    }else if(mapBtnClick.tag==2){
        mapBtnClick.selected = !mapBtnClick.selected;
        if(mapBtnClick.selected) {
            if (_handle >= 0) {
            if (0 == [MediaSDK RecordStart:_handle:[NSString stringWithFormat:@"%@/AnjubaoSDKDemoRecord.3gp", localDirectory]]) {
                        [iOSToast toast:@"开始本地录像" :1];
             
                    }
               
            }
        
            [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"录像.png"] forState:UIControlStateNormal];
            
        }else {
             [MediaSDK RecordStop:_handle];
            [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"录像2"] forState:UIControlStateNormal];
             [iOSToast toast:@"停止本地录像" :1];
        }
    }else if(mapBtnClick.tag==3){
        if (_handle >= 0) {
            if (0 == [MediaSDK Snapshot:_handle
                                       :[NSString stringWithFormat:@"%@/AnjubaoSDKDemoLocalSnapshot.jpg", localDirectory]]) {
                [iOSToast toast:@"截图成功" :1];
            } else {
                [iOSToast toast:@"截图失败" :1];
            }
        }

      [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"截图"] forState:UIControlStateHighlighted];
    }else{
          [iOSToast toast:@"布防成功" :1];
      [mapBtnClick setBackgroundImage:[UIImage imageNamed:@"布防1"] forState:UIControlStateHighlighted];
    }
//    NSLog(@"%ld",sender.tag);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
@end
