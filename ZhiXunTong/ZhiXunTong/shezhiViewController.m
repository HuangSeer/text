//
//  shezhiViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/9.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "shezhiViewController.h"
#import "PchHeader.h"
#import "iphoneViewController.h"
#import "PWDViewController.h"
#import "BDImagePicker.h"
#import "ZJInptutView.h"//在view界面展示内容
#import "DiZhiViewController.h"
#import "FangWuBDViewController.h"//房屋绑定
#import "JiaJuViewController.h"
#define WS(weakSelf)        __weak __typeof(&*self)weakSelf = self
@interface shezhiViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationBarDelegate>
{
    UITableView *sheTabView;
    UITextField *textUserName;
    UITextField *textPass;
    NSString *notid;
     NSString *username;
    NSString *imgString;
    NSMutableDictionary *userInfo;
    UIImageView *touImag;
    NSString *phone;
    UIImage *HeadImg;
    NSString *filePath;
    
    NSString *ddtvinfo;
    NSString *ddkey;
    
    UILabel *lab;
    UILabel *lab2;
    NSString *touxiang;
    NSString *str;
    NSUserDefaults *userDefaults;
    NSString *xiuName;
    NSString *yhName;
    int sh;
    id<AnjubaoSDK> sdk;
}
@property (nonatomic,strong) UIButton *button_popView;
@property (nonatomic,strong) ZJInptutView *view_inputView;

@end

@implementation shezhiViewController
static shezhiViewController* instance;
@synthesize  serverAddress, appType, appTypeValue, areaTypeValue, isVersion2;
-(void)viewWillAppear:(BOOL)animated{
}
-(void)connectService
{
    isVersion2 = YES;
    [sdk setVersion2:YES];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [sdk connectService];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    username=[userDefaults objectForKey:nikName];
    NSDictionary *ttxx=[userDefaults objectForKey:TX];
    NSString *ss=[userDefaults objectForKey:shzts];
 
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    sh=[ss intValue];
    instance = self;
    
    isVersion2 = NO;
    
    sdk = [AnjubaoSDK instance];
    
    [sdk setDebug:YES];
    [sdk setOfflineDelegate:self];
    //    NSString* areaType = [self.areaTypePicker text];
    areaTypeValue = 1;
    appTypeValue = 2;
    NSLog(@"username=%@",username);
    if (userInfo.count>0) {
        NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
        arry=[userInfo objectForKey:@"Data"];
        ddtvinfo=[userInfo objectForKey:@"TVInfoId"];
        ddkey=[userInfo objectForKey:@"Key"];
        
        if (ttxx!=nil) {
            imgString=[userDefaults objectForKey:TX];
        }else{
            imgString=[[arry objectAtIndex:0] objectForKey:@"Head_portrait"];
            yhName=[[arry objectAtIndex:0] objectForKey:@"userName"];
        }
        notid=[[arry objectAtIndex:0] objectForKey:@"id"];
    }
    
    [self daohangView];
}

-(void)daohangView
{
    self.navigationItem.title=@"个人资料";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    sheTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];    sheTabView.delegate=self;
    sheTabView.dataSource=self;
    [self.view addSubview:sheTabView];
    lab=[[UILabel alloc] initWithFrame:CGRectMake(110, 20, 100, 30)];
    lab2=[[UILabel alloc] initWithFrame:CGRectMake(110, 50, 180, 30)];
    lab2.text=[NSString stringWithFormat:@"用户名:%@",yhName];
    NSLog(@"oooo=%@-----%@",username,xiuName);
    lab.text=@"";
    NSLog(@"lab.text=%@",lab.text);
    if (xiuName.length>0) {
        lab.text=[NSString stringWithFormat:@"%@",xiuName];;
    }
    else{
        lab.text=username;
    }
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return 0;
    }
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 3;
    }else if (section==3){
        return 4;
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 100;
        }
        return 100;
    }else if (indexPath.section==3){
        if (indexPath.row==3) {
            return 80;
        }
        return 40;
    }
    return 40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
    UIImageView *youjiantou=[[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width-35, (cell.frame.size.height-24)/2, 16, 24)];//16, 24
    youjiantou.image=[UIImage imageNamed:@"youjiantou.png"];
    [cell.contentView addSubview:youjiantou];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            youjiantou.hidden=YES;
            touImag=[[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 80, 80)];
            touImag.userInteractionEnabled = YES;//打开用户交互
            touImag.layer.masksToBounds=YES;
            touImag.layer.cornerRadius=touImag.bounds.size.width*0.5;
            //touImag.layer.borderWidth=5;
            touImag.layer.borderColor=[UIColor whiteColor].CGColor;
            touImag.backgroundColor=[UIColor clearColor];
            if (!touImag) {
                str=[NSString stringWithFormat:@"%@%@",URL,touImag];
            }else{
                str=[NSString stringWithFormat:@"%@%@",URL,imgString];
            }
            
            NSURL *url=[NSURL URLWithString:str];
            [touImag addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shangchuan)]];
            //设置网络图片--默认图片
            [touImag sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headimg.png"]];
            [cell.contentView addSubview:touImag];
            [cell.contentView addSubview:lab2];
            [cell.contentView addSubview:lab];
        }
    }else if(indexPath.section==1){
        cell.textLabel.text=@"地址管理";
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            cell.textLabel.text=@"房屋绑定";
        }else if (indexPath.row==1){
            cell.textLabel.text=@"门禁绑定";
            UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
            chu.backgroundColor=RGBColor(245, 245, 245);
            [cell.contentView addSubview:chu];
        }else if (indexPath.row==2){
            cell.textLabel.text=@"监控绑定";
            
          
            UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
            chu.backgroundColor=RGBColor(245, 245, 245);
            [cell.contentView addSubview:chu];
        }
    }else if(indexPath.section==3){
        if (indexPath.row==0) {
            cell.textLabel.text=@"修改手机号";
        }else if (indexPath.row==1){
            UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
            chu.backgroundColor=RGBColor(245, 245, 245);
            [cell.contentView addSubview:chu];
            cell.textLabel.text=@"修改密码";
        }else if(indexPath.row==3){
            youjiantou.hidden=YES;
            UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
            chu.backgroundColor=RGBColor(245, 245, 245);
            [cell.contentView addSubview:chu];
    
            UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
            zhuce.frame = CGRectMake(Screen_Width/2-70, 30, 140, 35);
            zhuce.backgroundColor =RGBColor(58, 145, 246);
            [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
            [zhuce setTitle:@"退出登录" forState:UIControlStateNormal];
            zhuce.layer.cornerRadius=5;
            zhuce.tag=500;
            [zhuce addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:zhuce];
        }
        else if (indexPath.row==2)
        {
            cell.textLabel.text=@"修改昵称";
        }
    }
//    if (indexPath.row==0) {
//        touImag=[[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 80, 80)];
//        touImag.userInteractionEnabled = YES;//打开用户交互
//        touImag.layer.masksToBounds=YES;
//        touImag.layer.cornerRadius=touImag.bounds.size.width*0.5;
//        //touImag.layer.borderWidth=5;
//        touImag.layer.borderColor=[UIColor whiteColor].CGColor;
//        touImag.backgroundColor=[UIColor clearColor];
//        if (!touImag) {
//                str=[NSString stringWithFormat:@"%@%@",URL,touImag];
//        }else{
//                str=[NSString stringWithFormat:@"%@%@",URL,imgString];
//        }
//        
//        NSURL *url=[NSURL URLWithString:str];
//        [touImag addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shangchuan)]];
//        //设置网络图片--默认图片
//        [touImag sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headimg.png"]];
//        [cell.contentView addSubview:touImag];
//        [cell.contentView addSubview:lab];
//    }
//    else if (indexPath.row==1)
//    {
//        cell.textLabel.text=@"个人设置";
//        cell.textLabel.textColor=[UIColor orangeColor];
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//       
//    }
//    else if (indexPath.row==2)
//    {
//        cell.textLabel.text=@"修改呢称";
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//        UIImageView *aa=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-30, 15, 12, 20)];
//        aa.image=[UIImage imageNamed:@"youjiantou.png"];
//        [cell.contentView addSubview:aa];
//    }
//    else if (indexPath.row==3)
//    {
//        cell.textLabel.text=@"修改手机号";
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//        UIImageView *aa=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-30, 15, 12, 20)];
//        aa.image=[UIImage imageNamed:@"youjiantou.png"];
//        [cell.contentView addSubview:aa];
//    }
//    else if (indexPath.row==4)
//    {
//        cell.textLabel.text=@"密码修改";
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//        UIImageView *aa=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-30, 15, 12, 20)];
//        aa.image=[UIImage imageNamed:@"youjiantou.png"];
//        [cell.contentView addSubview:aa];
//    }
//    else if(indexPath.row==5)
//    {
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//        
//        UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
//        zhuce.frame = CGRectMake(Screen_Width/2-70, 30, 140, 35);
//        zhuce.backgroundColor =RGBColor(58, 145, 246);
//        [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
//        [zhuce setTitle:@"退出登录" forState:UIControlStateNormal];
//        zhuce.layer.cornerRadius=5;
//        zhuce.tag=500;
//        [zhuce addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:zhuce];
//    }
//    else
//    {
//        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
//        chu.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:chu];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    sheTabView.separatorStyle = NO;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            iphoneViewController *iphone=[[iphoneViewController alloc] init];
            [self.navigationController pushViewController:iphone animated:NO];
        }else if (indexPath.row==1){
            PWDViewController *pwd=[[PWDViewController alloc] init];
            [self.navigationController pushViewController:pwd animated:NO];
        }else if (indexPath.row==2){
            [self popInputSubview];
        
        }
        else {
            
        }
    }else if (indexPath.section==1){
        DiZhiViewController *dizhi=[[DiZhiViewController alloc] init];
        
        dizhi.strsd=@"1";
        [self.navigationController pushViewController:dizhi animated:NO];
        
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
//            [SVProgressHUD showSuccessWithStatus:@"房屋绑定"];
            //房屋绑定
            FangWuBDViewController *fangwu=[[FangWuBDViewController alloc] init];
            [self.navigationController pushViewController:fangwu animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
        }else if (indexPath.row==1){
            
//            [SVProgressHUD showSuccessWithStatus:@"门禁绑定"];
        }
        else if (indexPath.row==2){
            if (sh==1)
            {
                int result =[sdk thirdPartyLogin:phone  subAccounts:nil isMainAccountLogin:YES deviceId:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
                NSLog(@"%@ %d========%@", @"thirdPartyLogin", result,phone);
                if (result == ErrorCode_ERR_OK) {
                    //                        [iOSToast toast:@"账号登录成功" :1];
                    JiaJuViewController *JiaJuV=[[JiaJuViewController alloc] init];
                    [self.navigationController pushViewController:JiaJuV animated:NO];
                    self.tabBarController.tabBar.hidden=YES;
                    
                } else {
                    //                        [iOSToast toast:@"账号登录失败" :1];
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
            }
 
//            [SVProgressHUD showSuccessWithStatus:@"监控绑定"];
        }
    }
    else {
        
    }
//    if (indexPath.row==3) {
//        iphoneViewController *iphone=[[iphoneViewController alloc] init];
//        [self.navigationController pushViewController:iphone animated:NO];
//    }
//    else if (indexPath.row==4)
//    {
//        PWDViewController *pwd=[[PWDViewController alloc] init];
//        [self.navigationController pushViewController:pwd animated:NO];
//    }else if (indexPath.row==2)
//    {
//        [self popInputSubview];
//    }
}
//展示 弹出框的输入内容 ybh7
- (void) popInputSubview
{
    NSLog(@"hahah");
    WS(weakSelf);// 防止循环引用
    self.view_inputView = [[ZJInptutView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height) andTitle:@"请输入昵称" andPlaceHolderTitle:@"请输入"];
    [self.view addSubview:self.view_inputView];
//    NSLog(@"%@-%@-%@-",ddkey,ddtvinfo,notid);
    self.view_inputView.removeView = ^(NSString *title){
        NSLog(@"hehehe--%@",title);
        [[WebClient sharedClient] NiChen:ddtvinfo Keys:ddkey deptid:notid nickName:title ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"resultObject=%@",resultObject);
            //
            NSString *sta=[resultObject objectForKey:@"Status"];
            
            int ss=[sta intValue];
            NSLog(@"%d",ss);
            if (ss==1) {
//                username=@"";
//                lab.text=@"";
                xiuName=[resultObject objectForKey:@"nickname"];
//                    NSLog(@"username=%@",username);
//                
                [userDefaults removeObjectForKey:nikName];
                [[NSUserDefaults standardUserDefaults] setObject:xiuName forKey:nikName];
                lab.text=xiuName;
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [sheTabView reloadData];
                NSLog(@"username=%@",xiuName);
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
            
        }];
       // [weakSelf.button_popView setTitle:title forState:0];
        
        [weakSelf.view_inputView removeFromSuperview];
    };
    
}
-(void)BtnClick:(UIButton *)btn
{
    if (btn.tag==500) {
        NSLog(@"注销");
        [[WebClient sharedClient]GetId:notid ResponseBlock:^(id resultObject, NSError *error) {
          
            NSString *ss=[resultObject objectForKey:@"Status"];
            int aa=[ss intValue];
            if (aa==1) {
               // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:UserInfo];
                [SVProgressHUD showSuccessWithStatus:@"成功退出"];
                [self btnCkmore];
                
            }else{
                NSLog(@"注销失败");
            }
            
        }];
    }
}

//上传头像
-(void)shangchuan
{
    //选取照片上传
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}
// 图片选择结束之后，走这个方法，字典存放所有图片信息
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //01.21 应该在提交成功后再保存到沙盒，下次进来直接去沙盒路径取
    
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    //读取路径进行上传
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    //序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //JSON
    NSString *url=[NSString stringWithFormat:@"%@/api/APP1.0.aspx",URL];
    //NSLog(@"%@---%@",ddtvinfo,ddkey);
    NSDictionary *dics=@{
                         @"method":@"tp",
                         @"TVInfoId":ddtvinfo,
                         @"Key":ddkey
                         };
    NSURLSessionDataTask *task = [manager POST:url parameters:dics constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(image,1);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //上传成功
        NSString *testString =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *jsonData = [testString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"testString=%@",testString);
       NSString *Status= [jsonDict objectForKey:@"Status"];
        NSString *hedimg=[jsonDict objectForKey:@"URL"];
        int aa=[Status intValue];
        NSLog(@"jsonDict=%@",[jsonDict objectForKey:@"Status"]);
        if (aa==1) {
            NSLog(@"111111111");
            [[WebClient sharedClient] Tvinfo:ddtvinfo keys:ddkey userid:notid headimg:hedimg ResponseBlock:^(id resultObject, NSError *error) {
                NSLog(@"resultObject=图片路径：：%@",resultObject);
                NSString *Status2= [resultObject objectForKey:@"Status"];
                
                int aa2=[Status2 intValue];
                if (aa2==1) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                    NSLog(@"hedimg=%@",hedimg);
                    [[NSUserDefaults standardUserDefaults] setObject:hedimg forKey:TX];
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"修改失败"];
                }
                
                
            }];
        }else if (aa==0){
            NSLog(@"22222222222");
            [SVProgressHUD showSuccessWithStatus:@"修改失败"];
        }else{
            NSLog(@"请求失败");
        }
        
    
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //上传失败
        NSLog(@"%@",error);
    }];

    
    [touImag setImage:savedImage];//图片赋值显示
    
}

#pragma mark - 保存图片至沙盒（应该是提交后再保存到沙盒,下次直接去沙盒取）
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
