//
//  JfXqViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JfXqViewController.h"
#import "PchHeader.h"
#import "OneSpXqTableViewCell.h"
#import "TwoSpXqTableViewCell.h"
#import "ThreeJfScTableViewCell.h"
#import "FourSpXqTableViewCell.h"
#import "JYScrollView.h"
#import "ShangPview.h"
#import "DiZhiViewController.h"
#import "PPNumberButton.h"
#import "LZCartViewController.h"
#import "JfXDViewController.h"

@interface JfXqViewController ()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate,PPNumberButtonDelegate>{
    UITableView *tableView;
    UIButton *button;
     UIButton *butjiaru;
    NSArray *imgaray;
    NSString *store_price;NSArray *goods_price;NSString *name;NSArray *area_name;NSArray *goods_salenum;NSString *imgstr;NSArray *evaluate_value;
    UIView *headerview;
    UIView *viewshang;
    UIView *view;    
    NSString *strqf;
    NSArray *titarr;
    NSMutableArray *_viewArray;
    NSMutableArray *_buttonArray;
    UIImageView *xingimgview;
     int xintager;
      CGFloat height;
    UIView * views;
     NSString *strguige;
    NSMutableDictionary *userinfo;
    NSString *phone;
    NSString *cookiestr;
    NSString *integral;
}
@property(strong,nonatomic)NSString *strnum;
@property (nonatomic,strong)UIView * myView;
@property (nonatomic,strong)ShangPview * allview;
@property (strong,nonatomic) NSMutableArray *guigearray;
@property (strong,nonatomic) NSMutableArray *plArray;
@property (strong, nonatomic) UIWebView *Webhome;
@property (strong,nonatomic) NSMutableArray *imageUrlArray;
@property (nonatomic, strong) JYScrollView * jyScrollView;
@end

@implementation JfXqViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    [self lodadate];
    [self initTableView];
    [self initUI];
    self.navigationItem.title=@"商品详情";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)lodadate{
   
    NSString *strurl=[NSString stringWithFormat:@"%@integralGoodsDetail.htm?ig_id=%@",URLds,_intid];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
         _imageUrlArray=[NSMutableArray arrayWithCapacity:0];
        NSLog(@"shepi===2==2=2=2========%@",data);
       name=[[data objectForKey:@"data"] objectForKey:@"ig_name"];
        evaluate_value=[[data objectForKey:@"data"] objectForKey:@"evaluate_value"];
        
        _Webhome = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
        _Webhome.delegate=self;
        _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        _Webhome.scrollView.scrollEnabled = NO;
        
        NSString *urlString=[NSString stringWithFormat:@"%@/goods_detail_content.htm?goods_id=%@",URLds,evaluate_value[0]];
        NSLog(@"%@",urlString);
        [_Webhome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        
        imgstr=[[data objectForKey:@"data"] objectForKey:@"image"];
        
        [_imageUrlArray addObject:imgstr];
        if (!_jyScrollView) {
            _jyScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height/2.5)];
            [tableView.tableHeaderView addSubview:_jyScrollView];
            NSLog(@"%@",_imageUrlArray);
            [_jyScrollView bannerWithArray:_imageUrlArray titleArr:nil imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                NSLog(@"点击了轮播图click   NO.%ld",index);
            }];
            _jyScrollView.timeInterval =4;
            [headerview addSubview:_jyScrollView];
        }else{
            [_jyScrollView bannerWithArray:_imageUrlArray titleArr:nil imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                NSLog(@"点击了轮播图click   NO.%ld",index);
            }];
            _jyScrollView.timeInterval = 4;
            
        }
        store_price=[[data objectForKey:@"data"] objectForKey:@"ig_goods_integral"];
        [tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
    
    NSString *strurlfl=[NSString stringWithFormat:@"%@goodsDetail.htm?goodsId=%@",URLds,_intid];
    [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
        NSLog(@"sasad222222d===2==2=2=2========%@",data);
        area_name=[[data objectForKey:@"data"] valueForKey:@"area_name"];
        goods_salenum=[[data objectForKey:@"data"] valueForKey:@"goods_salenum"];
         _guigearray=[[data objectForKey:@"data"] valueForKey:@"guige"];
        [tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
  
    NSString *strurlpl=[NSString stringWithFormat:@"%@goodsEvaluate.htm?goods_id=98464&currentPage=1&pageSize=1",URLds];
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSLog(@"sad===2==2=2=2========%@",data);
        _plArray=[SpPlModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"] ];
        NSArray *tagerarray=[[data objectForKey:@"data"] valueForKey:@"evaluate_value"] ;
        xintager=[tagerarray[0] intValue];
        NSLog(@"%d",xintager);
        //        [tableViewd reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];

    
}
-(void)initUI{
    UIView *viewdibu=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-110, Screen_Width/1.5, 46)];
    viewdibu.layer.borderWidth =1;
    viewdibu.layer.borderColor = RGBColor(219, 219, 219).CGColor;
    [self.view addSubview:viewdibu];
    
    butjiaru= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    butjiaru.frame = CGRectMake(Screen_Width/1.5, self.view.frame.size.height-110,Screen_Width/3, 46);
    butjiaru.backgroundColor=[UIColor orangeColor];
    [butjiaru setTitle:@"去兑换" forState:UIControlStateNormal];
    [butjiaru setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butjiaru addTarget:self action:@selector(butjiaruClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butjiaru];
    NSArray *titleArray = @[@"客服",@"购物车"];
    for (int i = 0 ; i < 2; i++) {
         button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(viewdibu.frame.size.width/2*i, 0, viewdibu.frame.size.width/2, 46);
        button.layer.borderWidth =0.5;
        button.layer.borderColor = RGBColor(219, 219, 219).CGColor;
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:titleArray[i]] forState:UIControlStateNormal];
        button.tintColor = [UIColor grayColor];
        button.tag = i;
        [button addTarget:self action:@selector(buttonC:) forControlEvents:UIControlEventTouchUpInside];
        [viewdibu addSubview:button];
    }
}
- (void)initTableView {
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-110) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height/2.5)];
    [tableView setTableHeaderView:headerview];
 
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OneSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Onecell"];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TwoSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Twocell"];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThreeJfScTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Threecell"];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FourSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Fourcell"];
    [self.view addSubview:tableView];
    
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    
    }
   else{
        return 0;
    
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 110;
    }else if (indexPath.section==1){
        return 44;
        
    }else{
        return 0;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        OneSpXqTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Onecell"];
        tableView.separatorStyle = NO;
//        cell.labyj.text=[NSString stringWithFormat:@"原价¥%@", goods_price[0]];
        cell.labyh.text=[NSString stringWithFormat:@"所需积分:%@", store_price];
        cell.labbt.text=[NSString stringWithFormat:@"%@", name];
        cell.labthree.text=[NSString stringWithFormat:@"快递:0.00                月销%@            %@", goods_salenum[0],area_name[0]];
        return cell;
    }else if (indexPath.section==1){
        _strnum=@"1";
        static NSString *CellIdenti =@"Cellh";
        //定义cell的复用性当处理大量数据时减少内存开销
        UITableViewCell *cellsw = [tableView  dequeueReusableCellWithIdentifier:CellIdenti];
        
        if (cellsw ==nil)
        {
            cellsw = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdenti];
        }
        [cellsw setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *labxz=[[UILabel alloc]initWithFrame:CGRectMake(8
                                                                , 0, Screen_Width/3, 35)];
        labxz.text=@"购买数量";
        
        labxz.textColor=RGBColor(64, 64, 64);
        labxz.font=[UIFont systemFontOfSize:13.0f];
        [cellsw addSubview:labxz];
        
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Screen_Width/1.45, 2, Screen_Width/3.5, 31)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        // 设置最小值
        numberButton.minValue = 1;
        // 设置最大值
        numberButton.maxValue = 100;
        // 设置输入框中的字体大小
        numberButton.inputFieldFont = 16;
        numberButton.increaseTitle = @"＋";
        numberButton.decreaseTitle = @"－";
        numberButton.delegate = self;
        numberButton.backgroundColor=RGBColor(231, 231, 231) ;
        numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            
            NSLog(@"213213===%ld",num);
            _strnum=[NSString stringWithFormat:@"%ld",num];
        };
        [cellsw.contentView addSubview:numberButton];
        return cellsw;
        
    }else{
        return nil;
    }
}

//购物车和客服的点击方法
- (void)buttonClickbabab:(UIButton *)buttonClick{
    if (buttonClick.tag == 0) {
        
    }
    else if (buttonClick.tag == 1) {
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShopPlatform" bundle:nil];
//        ShopPlatformViewController *shopControl = [story instantiateInitialViewController];
//        [self.navigationController pushViewController:shopControl animated:NO];
//        self.navigationController.navigationBarHidden=NO;
//        self.tabBarController.tabBar.hidden=YES;
        
    }
 
}

- (void)buttonC:(UIButton *)buttonClick{
    
    if (buttonClick.tag == 0) {
        NSLog(@"客服");
    }
    else if (buttonClick.tag == 1) {
        LZCartViewController *LZCartVi=[[LZCartViewController alloc]init];
        [self.navigationController pushViewController:LZCartVi animated:NO];
    }else{
        
        view.hidden = YES;
        button.tintColor = [UIColor grayColor];
    }
}

-(void)butjiaruClick{
    //integralExchange.htm?id=4&count=1
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            integral=[[data objectForKey:@"data"] valueForKey:@"integral"];
            NSString *xstr=[NSString stringWithFormat:@"http://192.168.1.223:8080/shopping/api/thirdPartyLogin.htm?mobileNum=%@",phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            
             
             NSString  *strurlphone =[NSString stringWithFormat:@"%@integralExchange.htm?id=%@&count=%@",URLds,_intid,_strnum];
             [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
             
             NSLog(@"%@",data);
             //  NSString *msg=[data objectForKey:@"msg"];
             NSArray *array=[[data objectForKey:@"data"] objectForKey:@"igc"];
             NSLog(@"==--%@",array);
             JfXDViewController *JfXDV=[[JfXDViewController alloc]init];
             JfXDV.Cmodelarry=array;
             JfXDV.strcook=[data objectForKey:@"integral_order_session"];
             [self.navigationController pushViewController:JfXDV animated:NO];
             self.navigationController.navigationBarHidden=NO;
             self.tabBarController.tabBar.hidden=YES;
             
             } failure:^(NSError *error) {
             NSLog(@"---------------%@",error);
             [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
             }];

        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"还没有登录"];
    }
}
#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat  jj= [[_Webhome stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    
    height=jj/3;
    _Webhome.frame = CGRectMake(0,0, Screen_Width, height);
    _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [tableView reloadData];
}


@end
