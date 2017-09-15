//
//  FaTieViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FaTieViewController.h"
#import "PchHeader.h"
#import "BRPlaceholderTextView.h"
#import "UIImageView+WebCache.h"
#define MAXSTRINGLENGTH 500
#define iphone4 (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
#define iphone5 (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
#define iphone6 (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
#define iphone6plus (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))

@interface FaTieViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView *_tableView;
   
    UITextView *aaTextView;
    UILabel *textCountlabel;
    UITextField *biaoti;
    
    float _TimeNUMX;
    float _TimeNUMY;
    int _FontSIZE;
    NSMutableDictionary *userInfo;
    NSString *key;
    NSString *tvinfoId;
    NSString *deptid;
    NSString *aaid;
    UIButton *button;
    UILabel *biaoqian;
    UIButton *selectedBtn;
    NSString *tid;
    NSString *myurl;
    NSString *oid;
}
@property (nonatomic, strong)NSMutableArray *btnArray;
 @property (nonatomic, strong)NSMutableArray *saveArray;
 @property (nonatomic, strong)NSMutableArray *idArray;
@property (nonatomic, strong) UIScrollView *mianScrollView;
@property (nonatomic,strong) NSMutableArray * photoArr;
@end

@implementation FaTieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    key=[userDefaults objectForKey:Key];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    deptid=[userDefaults objectForKey:DeptId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    oid=[[arry objectAtIndex:0] objectForKey:@"oid"];
    _saveArray=[NSMutableArray arrayWithCapacity:0];
    _idArray=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title=@"发帖";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    UIButton * backFen = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 44, 18)];
    [backFen setTitle:@"发表" forState:UIControlStateNormal];
    [backFen addTarget:self action:@selector(fabiaoClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backFen];
    
    UIBarButtonItem *RigeItemBar = [[UIBarButtonItem alloc] initWithCustomView:backFen];
    [self.navigationItem setRightBarButtonItem:RigeItemBar];
    
    _TimeNUMX = [self BackTimeNUMX];
    _TimeNUMY = [self BackTimeNUMY];
    [self baike];
}
-(void)baike{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method=livingtypes&TVInfoId=&Key=
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=ModnewpostsType&TVInfoId=%@&Key=%@",URL,tvinfoId,key];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        NSArray *neiArray=[data objectForKey:@"Data"];
        for (int i=0; i<neiArray.count; i++) {
            //            NSLog(@"%@",);
            [_saveArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"type"]];
            [_idArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"id"]];
        }
//        NSLog(@"titleArray=%@",_saveArray);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
        _tableView.backgroundColor=RGBColor(234, 234, 234);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView setTableFooterView:[UIView new]];
//        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 210;
    }
    else if (indexPath.row==1){
        return 100;
    }
    else {
        return 120;
    }
    
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
    if (indexPath.row==0) {
        biaoti=[[UITextField alloc] initWithFrame:CGRectMake(5, 0, Screen_Width-10, 29)];
        biaoti.placeholder=@"标题";
        [cell.contentView addSubview:biaoti];
        
        UIView *xx=[[UIView alloc] initWithFrame:CGRectMake(5, 29, Screen_Width-10, 0.5)];
        xx.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:xx];
        
        aaTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 30, Screen_Width, 210)];
        aaTextView.scrollEnabled=NO;
        aaTextView.delegate=self;
        aaTextView.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:aaTextView];
        
        textCountlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, Screen_Width-10, 20)];
        textCountlabel.text=@"500/500";
        textCountlabel.textAlignment=NSTextAlignmentRight;
        [aaTextView addSubview:textCountlabel];
        
        UIView *xxlan=[[UIView alloc] initWithFrame:CGRectMake(5, 209, Screen_Width-10, 0.5)];
        xxlan.backgroundColor=[UIColor blueColor];
        [cell.contentView addSubview:xxlan];
//        cell.separatorInset = UIEdgeInsetsMake(0, Screen_Width, 0, 0); // ViewWidth  [宏] 指
    }else if (indexPath.row==1){
        [self createUI];
        UIView *xxlan=[[UIView alloc] initWithFrame:CGRectMake(0, 95, Screen_Width, 5)];
        xxlan.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:xxlan];
       
    }
    else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 40, Screen_Width, 80)];
        view.backgroundColor=RGBColor(234, 234, 234);
        [cell.contentView addSubview:view];
    
        biaoqian=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
        
        [cell.contentView addSubview:biaoqian];
        CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat h = 45;//用来控制button距离父视图的高
        NSLog(@"%@",_saveArray);
        for (int i = 0; i < _saveArray.count; i++) {
            button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag =i;
             button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
            //根据计算文字的大小
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGFloat length = [_saveArray[i] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
            //为button赋值
            [button setTitle:_saveArray[i] forState:UIControlStateNormal];
            //设置button的frame
            button.frame = CGRectMake(10 + w, h, length + 15 , 30);
            //当button的位置超出屏幕边缘时换行 320 只是button所在父视图的宽度
            if(10 + w + length + 15 > 320){
                w = 0; //换行时将w置为0
                h = h + button.frame.size.height + 10;//距离父视图也变化
                button.frame = CGRectMake(10 + w, h, length + 15, 30);//重设button的frame
            }
            w = button.frame.size.width + button.frame.origin.x;
            button.layer.cornerRadius=5;
            [_btnArray addObject:button];
            [cell.contentView addSubview:button];
        }
    }
     cell.separatorInset = UIEdgeInsetsMake(0, Screen_Width, 0, 0);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)handleClick:(UIButton *)sender
{
    biaoqian.text=sender.titleLabel.text;
    tid=[_idArray objectAtIndex:sender.tag];
    //选中变红色 其他按钮变为白色
    if (selectedBtn) {
        selectedBtn.backgroundColor = [UIColor whiteColor];
        [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    selectedBtn = sender;
    [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selectedBtn.backgroundColor = [UIColor orangeColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - text view delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
 if ([lang isEqualToString:@"zh-Hans"])
     {
             UITextRange *range = [textView markedTextRange];
             UITextPosition *start = range.start;
             UITextPosition*end = range.end;
             NSInteger selectLength = [textView offsetFromPosition:start toPosition:end];
             NSInteger contentLength = textView.text.length - selectLength;
    
             if (contentLength > MAXSTRINGLENGTH)
                 {
                         textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
                         [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制500个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                      }
             if (contentLength < MAXSTRINGLENGTH)
                 {
                        textCountlabel.text = [NSString stringWithFormat:@"%ld/500", MAXSTRINGLENGTH - contentLength];
                     }
             else
                 {
                         textCountlabel.text = @"0/500";
                     }
         }
 else
     {
             if (textView.text.length > MAXSTRINGLENGTH)
                 {
                         textView.text = [textView.text substringToIndex:MAXSTRINGLENGTH];
                         [[[UIAlertView alloc] initWithTitle:@"提示" message:@"最长限制500个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                     }
             textCountlabel.text = [NSString stringWithFormat:@"%ld/500", MAXSTRINGLENGTH-textView.text.length];
         }
}
- (void)createUI{
    _mianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210, Screen_Width, 90)];
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

-(void)fabiaoClick
{
    NSLog(@"发表");
    self.photoArr = [[NSMutableArray alloc] initWithArray:[self getBigImageArray]];
    NSLog(@"%@",self.photoArr);
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=tp&TVInfoId=%@&Key=%@",URL,tvinfoId,key];
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
            NSLog(@"%@",[responseObject objectForKey:@"URL"]);
            myurl=[NSString stringWithFormat:@"%@%@",URL,[responseObject objectForKey:@"URL"]];
            [self fafa];
//            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            failure(error);
            [SVProgressHUD showErrorWithStatus:@"提交失败"];
            NSLog(@"失败---%@",error);
        }];
    }

}
-(void)fafa
{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=ModnewpostsAdd&TVInfoId=%@&Key=%@&Tid=%@&Title=%@&Content=%@&Uid=%@&qid=%@&imgPath=%@",URL,tvinfoId,key,tid,biaoti.text,aaTextView.text,aaid,oid,myurl];
    NSString *encodedValue = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:encodedValue success:^(id data) {
        NSLog(@"fafa===----%@",data);
        NSString *stat=[data objectForKey:@"Status"];
        int aa=[stat intValue];
        if (aa==1) {
            NSLog(@"成功");
            [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            
        }else{
            [SVProgressHUD showErrorWithStatus:@"发表失败"];
        }
        
//        NSArray *neiArray=[data objectForKey:@"Data"];
//        for (int i=0; i<neiArray.count; i++) {
//            //            NSLog(@"%@",);
//            [titleArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"type"]];
//        }
//        NSLog(@"titleArray=%@",titleArray);
//        [titleArray insertObject:@"全部" atIndex:0];
//        if (titleArray.count>0) {
//            [self daohang];
//            [self SheQuShengHuo:@""];
//        }
//        
//        //        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
@end
