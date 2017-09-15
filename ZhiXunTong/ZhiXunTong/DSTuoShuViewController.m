//
//  DSTuoShuViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DSTuoShuViewController.h"
#import "PchHeader.h"
#import "BRPlaceholderTextView.h"
#import "UIImageView+WebCache.h"
#define iphone4 (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
#define iphone5 (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
#define iphone6 (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
#define iphone6plus (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))
@interface DSTuoShuViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    UITextView *textView;
    UILabel *lable1;
    
    UITextView *textView2;
    UILabel *lable2;
    
    NSMutableDictionary *userinfo;
    NSString *phone;
    
    float _TimeNUMX;
    float _TimeNUMY;
    int _FontSIZE;
}
@property (nonatomic, strong) UIScrollView *mianScrollView;
@property (nonatomic,strong) NSMutableArray * photoArr;
@end

@implementation DSTuoShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"tjiage=%@",_Tjias);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    self.navigationItem.title=@"投诉";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    _TimeNUMX = [self BackTimeNUMX];
    _TimeNUMY = [self BackTimeNUMY];
    
    
}
- (void)createUI{
    _mianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, Screen_Width, 90)];
    _mianScrollView.contentSize =CGSizeMake(Screen_Width, 90);
    _mianScrollView.bounces =YES;
    _mianScrollView.showsVerticalScrollIndicator = false;
    _mianScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView addSubview:_mianScrollView];
    [_mianScrollView setDelegate:self];
    self.showInView = _mianScrollView;
    
    /** 初始化collectionView */
    [self initPickerView];
    
  //  [self initViews];
}
#pragma mark - UIScrollViewDelegate
//用户向上偏移到顶端取消输入,增强用户体验
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
}

#pragma mark 点击出大图方法
- (void)ClickImage:(UIButton *)sender{
    
}

#pragma mark 返回不同型号的机器的倍数值
- (float)BackTimeNUMX {
    float numX = 0.0;
    if (iphone4) {
        numX = 320 / 375.0;
        return numX;
    }
    if (iphone5) {
        numX = 320 / 375.0;
        return numX;
    }
    if (iphone6) {
        return 1.0;
    }
    if (iphone6plus) {
        numX = 414 / 375.0;
        return numX;
    }
    return numX;
}
- (float)BackTimeNUMY {
    float numY = 0.0;
    if (iphone4) {
        numY = 480 / 667.0;
        _FontSIZE = -2;
        return numY;
    }
    if (iphone5) {
        numY = 568 / 667.0;
        _FontSIZE = -2;
        return numY;
    }
    if (iphone6) {
        _FontSIZE = 0;
        return 1.0;
    }
    if (iphone6plus) {
        numY = 736 / 667.0;
        _FontSIZE = 2;
        return numY;
    }
    return numY;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 164;
    }else if(indexPath.row==1){
        return 335;
    }else{
        return 80;
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (indexPath.row==0) {
        UILabel *lab_dingdan=[[UILabel alloc] initWithFrame:CGRectMake(10, 0,Screen_Width, 22)];
        lab_dingdan.text=[NSString stringWithFormat:@"订单编号:%@",_Tid];
        lab_dingdan.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_dingdan];
        UILabel *lab_xiadan=[[UILabel alloc] initWithFrame:CGRectMake(10, 22,Screen_Width, 22)];
        lab_xiadan.text=[NSString stringWithFormat:@"下单时间:%@",_Ttime];
        lab_xiadan.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_xiadan];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(10, 44, Screen_Width-20, 1)];
        view.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:view];
        
        UILabel *lab_maiName=[[UILabel alloc] initWithFrame:CGRectMake(10, 44,Screen_Width, 22)];
        lab_maiName.text=[NSString stringWithFormat:@"买家名称:%@",_addr_trueName];
        lab_maiName.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_maiName];
        UILabel *lab_dianpu=[[UILabel alloc] initWithFrame:CGRectMake(10, 66,Screen_Width, 22)];
        lab_dianpu.text=[NSString stringWithFormat:@"卖家店铺:%@",_store_name];
        lab_dianpu.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lab_dianpu];
        
        UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(10, 88, Screen_Width-20, 1)];
        view1.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:view1];
        
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 96, 50, 50)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:_Timg] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        [cell.contentView addSubview:imgView];
        
        UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(80, 86,Screen_Width-90, 22)];
        name.text=[NSString stringWithFormat:@"%@",_Ttitle];
        name.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:name];
        
        UILabel *lcont=[[UILabel alloc] initWithFrame:CGRectMake(80, 108,Screen_Width, 22)];
        lcont.text=[NSString stringWithFormat:@"数量：%@",_Tshu];
        lcont.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lcont];
        
        UILabel *jiage=[[UILabel alloc] initWithFrame:CGRectMake(80, 130,Screen_Width, 22)];
        NSLog(@"%@",_Tjias);
        jiage.text=[NSString stringWithFormat:@"￥%@",_Tjias];
        jiage.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:jiage];
        
        UIView *diView=[[UIView alloc] initWithFrame:CGRectMake(0, 154, Screen_Width, 10)];
        diView.backgroundColor=RGBColor(234, 234, 234);
        cell.backgroundColor=[UIColor orangeColor];
        [cell.contentView addSubview:diView];
    }
    else if (indexPath.row==1)
    {
        cell.backgroundColor=[UIColor grayColor];
        UILabel *lab_xiadan=[[UILabel alloc] initWithFrame:CGRectMake(10, 5,Screen_Width, 30)];
        lab_xiadan.text=[NSString stringWithFormat:@"申请原因"];
        lab_xiadan.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab_xiadan];
        
        textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 35, Screen_Width-20, 60)];
        textView.delegate=self;
        [textView.layer setCornerRadius:5];
        
        lable1=[[UILabel alloc] initWithFrame:CGRectMake(3, 4, 136, 20)];
        lable1.text=@"请您再次描述问题";
        lable1.font=[UIFont systemFontOfSize:13];
        lable1.enabled=NO;
        [textView addSubview:lable1];
        
        textView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:textView];
        
        UILabel *lab_tuihui=[[UILabel alloc] initWithFrame:CGRectMake(10, 100,Screen_Width/2-20, 30)];
        lab_tuihui.text=[NSString stringWithFormat:@"投诉内容"];
        lab_tuihui.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab_tuihui];
        
        textView2=[[UITextView alloc] initWithFrame:CGRectMake(10, 135, Screen_Width-20, 90)];
        textView2.delegate=self;
        [textView2.layer setCornerRadius:5];
        
        lable2=[[UILabel alloc] initWithFrame:CGRectMake(3, 4, 136, 20)];
        lable2.text=@"请您再次描述问题";
        lable2.font=[UIFont systemFontOfSize:13];
        lable2.enabled=NO;
        [textView2 addSubview:lable2];
        
        textView2.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:textView2];
        
        
        [self createUI];
        UIView *diView=[[UIView alloc] initWithFrame:CGRectMake(0, 325, Screen_Width, 10)];
        diView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:diView];
    }
    else if(indexPath.row==2)
    {
        //cell.backgroundColor=[UIColor blueColor];
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake(Screen_Width/2-90, 30, 180, 30);
        denglu.backgroundColor = RGBColor(66, 142, 12);
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"提交" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        denglu.tag=202;
        [denglu addTarget:self action:@selector(BtnTijiao) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)BtnTijiao{
    NSLog(@"投诉提交");
    if (textView.text.length>0 && textView2.text.length>0)
    {
         [SVProgressHUD showWithStatus:@"加载中"];
        NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"MoNiLogin===%@",data);
            NSString *str=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"]];
            int aa=[str intValue];
            if (aa==200) {
                NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/complaint_save.htm?id=%@&goods_id=%@&to_user_id=%@&issue_description=%@&complaint_content=%@",DsURL,_TOId,_goodid,_userid,textView.text,textView2.text];
                NSString *encodedValue = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                for(NSInteger i = 0; i < self.photoArr.count; i++)
                {
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.requestSerializer.timeoutInterval = 20;
                    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
                    __block NSInteger blockI = i;
                    [manager POST:encodedValue parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        //取出单张图片二进制数据
                        id obj = self.photoArr[blockI];
                        UIImage *image = nil;
                        if ([obj isKindOfClass:[UIImage class]]) {
                            image = (UIImage *)obj;
                        }else{
                            image = [UIImage imageWithContentsOfFile:obj];
                        }
                        if (image) {
                            
                            UIImage *image = self.photoArr[i];
                            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                            // 要解决此问题，
                            // 可以在上传时使用当前的系统事件作为文件名
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            // 设置时间格式
                            [formatter setDateFormat:@"yyyyMMddHHmmss"];
                            NSString *dateString = [formatter stringFromDate:[NSDate date]];
                            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
                            /*
                             *该方法的参数
                             1. appendPartWithFileData：要上传的照片[二进制流]
                             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                             3. fileName：要保存在服务器上的文件名
                             4. mimeType：上传的文件的类型
                             */
                            [formData appendPartWithFileData:imageData name:@"mFile" fileName:fileName mimeType:@"image/jpeg"]; //
                        }
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                        
                        NSLog(@"progress is %@",uploadProgress);
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        //            success(responseObject);
                        NSLog(@"成功---%@",responseObject);
                        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        //            failure(error);
                        [SVProgressHUD showErrorWithStatus:@"提交失败"];
                        NSLog(@"失败---%@",error);
                    }];
                }
            }
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
        }];
        self.photoArr = [[NSMutableArray alloc] initWithArray:[self getBigImageArray]];
        NSLog(@"%@",self.photoArr);
    }

}
-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]==0) {
        [lable1 setHidden:NO];
    } else {
        [lable1 setHidden:YES];
    }
    if ([textView2.text length]==0) {
         [lable2 setHidden:NO];
    }else {
        [lable2 setHidden:YES];
    }
}
-(void)btnCkmore
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
