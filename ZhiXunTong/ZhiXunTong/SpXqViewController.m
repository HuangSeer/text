//
//  JfXqViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SpXqViewController.h"
#import "PchHeader.h"
#import "OneSpXqTableViewCell.h"
#import "TwoSpXqTableViewCell.h"
#import "ThreeJfScTableViewCell.h"
#import "FourSpXqTableViewCell.h"
#import "JYScrollView.h"
#import "SpPlModel.h"
#import "DiZhiViewController.h"
#import "DiZhiModel.h"
#import "ShangPview.h"
#import "PPNumberButton.h"
#import "PingJViewController.h"
#import "LoginViewController.h"
#import "TgXqTableViewCell.h"
#import "ImageScrollView.h"
#import "LZCartViewController.h"
@interface SpXqViewController ()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate,PPNumberButtonDelegate>{
    UITableView *tableViewd;
    UIButton *button;
    UIButton *butjiaru;
    UIView *viewshang;
    NSArray *imgaray;
    NSArray *store_price;NSArray *goods_price;NSArray *name;NSArray *area_name;NSArray *goods_salenum;NSArray *idarray;NSArray *group_good_count; NSArray *arrayspid;
    UIView *headerview;
    
    NSString *strqf;
    NSArray *titarr;
    UIView *view;
    UIView * views;
    NSMutableArray *_viewArray;
    NSMutableArray *_buttonArray;
    CGFloat height;
     NSString *phone;
    NSMutableDictionary *userinfo;
    NSString *cookiestr;
    NSUserDefaults *userDefaults;
     NSMutableArray *_dataArray;
    int xintager;
    UIImageView *xingimgview;
     NSString *strurlfl;
    NSMutableArray *imageUrlArray;
    NSString *strguige;
    NSArray *imgarrsday;
    NSString *gwcstrpd;
 NSTimer *countDownTimer;
      NSInteger CountDown;
    UILabel *labsfm;
    NSArray *timearray;
    NSString *timeString;
    NSArray *gg_for_goods_id;
    NSDate *d;
    UIView *viewtou;
//    NSString    *addrestr;
}
@property (nonatomic, strong)ImageScrollView *imgScrollView;
@property(strong,nonatomic)NSString *strnum;
@property (nonatomic,strong)UIView * myView;
@property (nonatomic,strong)ShangPview * allview;
@property (strong, nonatomic) UIWebView *Webhome;
@property (strong,nonatomic) NSMutableArray *plArray;
@end
@implementation SpXqViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
    self.navigationItem.title=@"商品详情";

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self lodalogin];
    
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
 
    NSString *strurlphone=[NSString stringWithFormat:@"%@groupTime.htm",URLds];
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        timearray=[[data objectForKey:@"data"] valueForKey:@"groupTime"] ;
        long long time=[timearray[0] longLongValue];
        
        d= [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
     
    //启动倒计时后会每秒钟调用一次方法
     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMe) userInfo:nil repeats:YES];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"获取失败!!"];
    }];

    [self lodadate2];
    [self lodadate];
    
     [self initUI];
   
    _guigearray=[NSMutableArray arrayWithCapacity:0];
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
-(void)lodalogin{
    NSString *strurlphone=[NSString stringWithFormat:@"http://192.168.1.194:8080/shopping/api/thirdPartyLogin.htm?mobileNum=%@",phone];
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
        NSLog(@"wosadnbabab=============================%@",data);
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:strurlphone]];
        for (NSHTTPCookie *tempCookie in cookies)
        {
            
            
            cookiestr=tempCookie.value;
        }
        [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
     
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
   
    
}
-(void)lodadate2{
    NSString *strurlpl=[NSString stringWithFormat:@"%@getAddressList.htm?currentPage=1&Cookie=%@",URLds,cookiestr];
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
           NSLog(@"sad===222222222222222222==2=2=2========%@",data);
        _dataArray=[data objectForKey:@"list"];
        if (_dataArray != nil && ![_dataArray isKindOfClass:[NSNull class]] && _dataArray.count != 0) {
        _addrestr=[NSString stringWithFormat:@"%@%@",[_dataArray[0] valueForKey:@"areaName"],[_dataArray[0] valueForKey:@"area_info"]];
        }else{
        _addrestr=@"请去选择收货地址";
        
        }
      
     
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
    }];
    
    
}
-(void)timeFireMe{
    NSDate * date = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval timebab = [d timeIntervalSinceDate:date];
    int d = ((int)timebab)/60/60/24;
    int h = ((int)timebab)/60/60%24;
    int  m = ((int)timebab)/60%60;
    int  s = ((int)timebab)%60;
    NSString *format_time2 = [NSString stringWithFormat:@"%d天%d时%d分%d秒",d,h,m,s];
   labsfm.text=[NSString stringWithFormat:@"%@",format_time2];

}
-(void)lodadate{
    if ([_strpdz containsString:@"1"]) {
     strurlfl=[NSString stringWithFormat:@"%@groupGoodsDetail.htm?gg_id=%@",URLds,_intasid];
        [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
            
            
            NSLog(@"%@",data);
            idarray=[[data objectForKey:@"data"] valueForKey:@"boughtPepleCount"];
              arrayspid=[[data objectForKey:@"data"] valueForKey:@"gg_for_goods_id"];
            _Webhome = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
            _Webhome.delegate=self;
            _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            _Webhome.scrollView.scrollEnabled = NO;
            
            NSString *urlString=[NSString stringWithFormat:@"%@goods_detail_content.htm?goods_id=%@",URLds,arrayspid[0]];
            NSLog(@"%@",urlString);
            [_Webhome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            area_name=[[data objectForKey:@"data"] valueForKey:@"group_good_name"];
            goods_salenum=[[data objectForKey:@"data"] valueForKey:@"boughtPepleCount"];
            imgaray=[[data objectForKey:@"data"] valueForKey:@"image"];
            store_price=[[data objectForKey:@"data"] valueForKey:@"old_price"];
            goods_price=[[data objectForKey:@"data"] valueForKey:@"group_good_price"];
            group_good_count=[[data objectForKey:@"data"] valueForKey:@"group_good_count"];
             _guigearray=[[data objectForKey:@"data"] valueForKey:@"guige"];
            gg_for_goods_id=[[data objectForKey:@"data"] valueForKey:@"gg_for_goods_id"];
            _intasid=[NSString stringWithFormat:@"%@",gg_for_goods_id[0]];
            NSString *strurlpl=[NSString stringWithFormat:@"%@goodsEvaluate.htm?goods_id=%@&currentPage=1&pageSize=1",URLds,_intasid];
            NSLog(@"%@",strurlpl);
            [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                NSLog(@"sad==3333333333333333==2=2=2========%@",data);
                _plArray=[SpPlModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"] ];
                NSLog(@"===%lu",_plArray.count);
                NSArray *tagerarray=[[data objectForKey:@"data"] valueForKey:@"evaluate_value"] ;
                xintager=[tagerarray[0] intValue];
                NSLog(@"%d",xintager);
                //        [tableViewd reloadData];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
            }];
             [self initTableView];
           
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
        }];
    }else{
    
    strurlfl =[NSString stringWithFormat:@"%@goodsDetail.htm?goodsId=%@",URLds,_intasid];
        [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
            NSLog(@"爸爸爸爸===11111111==2=2=2========%@",data);
             imageUrlArray=[NSMutableArray arrayWithCapacity:0];
            idarray=[[data objectForKey:@"data"] valueForKey:@"id"];
            _Webhome = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
            _Webhome.delegate=self;
            _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
            _Webhome.scrollView.scrollEnabled = NO;
            NSString *urlString=[NSString stringWithFormat:@"%@goods_detail_content.htm?goods_id=%@&id=%@",URLds,_intasid,idarray[0]];
            [_Webhome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
            area_name=[[data objectForKey:@"data"] valueForKey:@"area_name"];
            goods_salenum=[[data objectForKey:@"data"] valueForKey:@"goods_salenum"];
            imgarrsday=[[[data objectForKey:@"data"] valueForKey:@"image"] objectAtIndex:0];
            store_price=[[data objectForKey:@"data"] valueForKey:@"store_price"];
            goods_price=[[data objectForKey:@"data"] valueForKey:@"goods_price"];
            name=[[data objectForKey:@"data"] valueForKey:@"name"];
            _guigearray=[[data objectForKey:@"data"] valueForKey:@"guige"];
            NSString *strurlpl=[NSString stringWithFormat:@"%@goodsEvaluate.htm?goods_id=%@&currentPage=1&pageSize=1",URLds,_intasid];
            [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
                NSLog(@"sad==3333333333333333==2=2=2========%@",data);
                _plArray=[SpPlModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"] ];
                NSLog(@"===%lu",_plArray.count);
                NSArray *tagerarray=[[data objectForKey:@"data"] valueForKey:@"evaluate_value"] ;
                xintager=[tagerarray[0] intValue];
                NSLog(@"%d",xintager);
                //        [tableViewd reloadData];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
            }];
             [self initTableView];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"加载数据失败!!"];
        }];
    }
   
    
   

    
}
-(void)initUI{
    UIView *viewdibu=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-110, Screen_Width/1.5, 46)];
    viewdibu.layer.borderWidth =1;
    viewdibu.layer.borderColor = RGBColor(219, 219, 219).CGColor;
    [self.view addSubview:viewdibu];
    
    butjiaru= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    butjiaru.frame = CGRectMake(Screen_Width/1.5, self.view.frame.size.height-110,Screen_Width/3, 46);
    [butjiaru setBackgroundImage:[UIImage imageNamed:@"加入购物车"] forState:UIControlStateNormal];
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
        [button addTarget:self action:@selector(buttonClickbabab:) forControlEvents:UIControlEventTouchUpInside];
        [viewdibu addSubview:button];
    }
}
- (void)initTableView {
    
    tableViewd = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-110) style:UITableViewStyleGrouped];
    tableViewd.delegate = self;
    tableViewd.dataSource = self;
    //组册cell
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([OneSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Onecell"];
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([TwoSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Twocell"];
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([ThreeJfScTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Threecell"];
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([FourSpXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Fourcell"];
    [tableViewd registerNib:[UINib nibWithNibName:NSStringFromClass([TgXqTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"TgXqcell"];
    [self.view addSubview:tableViewd];

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
      _imgScrollView=[[ImageScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height/3)];
             if ([_strpdz containsString:@"1"]) {
                 NSLog(@"%@",imgaray);
                 UIView *viewai=[[UIView alloc]initWithFrame:CGRectMake(0, _imgScrollView.frame.size.height-40, Screen_Width-120, 40)];
                 UIColor *color = [UIColor greenColor];
                 viewai.backgroundColor = [color colorWithAlphaComponent:0.5];

                 UILabel *labxj=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, viewai.frame.size.width-10,  viewai.frame.size.height/2)];
                 labxj.text=@"¥2000";
                 labxj.textColor=[UIColor whiteColor];
                 UILabel *labsh=[[UILabel alloc]initWithFrame:CGRectMake(10,  viewai.frame.size.height/2, viewai.frame.size.width/2.4,  viewai.frame.size.height/2)];
                 labsh.text=@"实惠团购";
                 labsh.font=[UIFont systemFontOfSize:19.0f];
                 labsh.textColor=[UIColor whiteColor];
                 UILabel *labyj=[[UILabel alloc]initWithFrame:CGRectMake(10+viewai.frame.size.width/2.4,  viewai.frame.size.height/2, viewai.frame.size.width/2.7,  viewai.frame.size.height/2)];
                 labyj.text=@"原价¥4000";
                 labyj.font=[UIFont systemFontOfSize:12.0f];
                 labyj.textColor=[UIColor whiteColor];
                 [viewai addSubview:labyj];
                 [viewai addSubview:labsh];
                 [viewai addSubview:labxj];
                   UIView *viewdjs=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width-120, _imgScrollView.frame.size.height-40,120, 40)];
                 viewdjs.backgroundColor=RGBColor(178, 255, 187);
                 UILabel *labdj=[[UILabel alloc]initWithFrame:CGRectMake(10,0, viewai.frame.size.width,  viewai.frame.size.height/2)];
                 labdj.text=@"距离结束还有";
                 labdj.font=[UIFont systemFontOfSize:11.0f];
                 labdj.textColor=RGBColor(0, 176, 55);
                 labdj.textAlignment = UITextAlignmentLeft;
                 [viewdjs addSubview:labdj];
                labsfm=[[UILabel alloc]initWithFrame:CGRectMake(5,viewai.frame.size.height/2, viewai.frame.size.width-20,  viewai.frame.size.height/2)];
                 labsfm.font=[UIFont systemFontOfSize:11.0f];
                 labsfm.textColor=RGBColor(0, 176, 55);
                  [viewdjs addSubview:labsfm];
                 [viewdjs addSubview:labdj];
                  [_imgScrollView addSubview:viewdjs];
                 [_imgScrollView addSubview:viewai];
                 
                _imgScrollView.pics=imgaray;
                 NSLog(@"%@",imgaray);
                 [_imgScrollView reloadView];
                
             }else{
                 _imgScrollView.pics=imgarrsday;
                 [_imgScrollView reloadView];
        }
        return _imgScrollView;
    }
    
  else  if (section==3) {
        
        viewtou=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
        viewshang=[[UIView alloc]initWithFrame:CGRectMake(Screen_Width/3, 0, Screen_Width/3, 40)];
        viewtou.backgroundColor=[UIColor whiteColor];
        viewshang.backgroundColor=[UIColor whiteColor];
      if ([strqf containsString:@"1"]) {
          UILabel *labxz=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, Screen_Width/3, 35)];
          labxz.text=@"评价";
          
          labxz.textColor=RGBColor(64, 64, 64);
          labxz.font=[UIFont systemFontOfSize:14.0f];
          [viewtou addSubview:labxz];
      }
      else{
        titarr=@[@"评价",@"详情"];
        for (int i = 0 ; i < titarr.count; i++) {
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(viewshang.frame.size.width/titarr.count*i, 5, viewshang.frame.size.width/titarr.count-5, 38);
            [button setFont:[UIFont systemFontOfSize:14.0f]];
            [button setTitle:titarr[i] forState:UIControlStateNormal];
            button.tintColor = [UIColor grayColor];
            if (i == [strqf intValue]) {
                button.tintColor =[UIColor redColor];
            }
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewshang addSubview:button];
            
            view = [[UIView alloc] initWithFrame:CGRectMake(viewshang.frame.size.width/titarr.count*i, 37, viewshang.frame.size.width/titarr.count-5,2)];
            view.backgroundColor =[UIColor redColor];
            if (i == [strqf intValue]) {
                view.hidden = NO;
            }else{
                view.hidden = YES;
            }
            [viewshang addSubview:view];
            [viewshang addSubview:button];
            [_viewArray addObject:view];
            [_buttonArray addObject:button];
        }

        UIView *viewxian=[[UIView alloc]initWithFrame:CGRectMake(0,39, Screen_Width, 1)];
        viewxian.backgroundColor=RGBColor(231, 231, 231);
        [viewtou addSubview:viewxian];
        [viewtou addSubview:viewshang];
      [self butviewquanbu];
      }
        return viewtou;
      
      
    }else{
        return nil;
    
    }


}

-(void)butviewquanbu{
    UIButton *butchakan=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-105, 5, 100, 37)];
    [butchakan setTitle:[NSString stringWithFormat:@"全部评价(%lu)" ,_plArray.count] forState:UIControlStateNormal];
    [butchakan setFont:[UIFont systemFontOfSize:14.0f]];
    butchakan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [butchakan setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     [butchakan addTarget:self action:@selector(butchakanClick) forControlEvents:UIControlEventTouchUpInside];
    [viewtou addSubview:butchakan];


}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return   Screen_height/3;
    }
   
   else if (section==3) {
       return 40;
    }else{

        return 0.00001;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
      return 4;
      

}
//每组cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if (section==0) {
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
        
    }
    else if (section==3){
        if ([strqf containsString:@"1"]) {
            return 1;
            
        }else{
            if (_plArray.count==0) {
                
                return 0;
            }else{
                
                return 1;
            }
        }
        
 
    }else{
        return 0;
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    if (indexPath.section==0) {
        return 110;
    }else if (indexPath.section==1){
    
        return 44;
        
    }else if (indexPath.section==2){
        return 35;
        
    }else if (indexPath.section==3){
        if ([strqf containsString:@"1"]) {
            return height;
        }else{
            return 75;
        }
    }else{
        return 0;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {
        
        if ([_strpdz containsString:@"1"]) {
            
            NSLog(@"%@====%@====%@",area_name,goods_salenum,group_good_count);
            //实现某段字符串显示不一样的颜色
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人已参团",goods_salenum[0]]];
            NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@",goods_salenum[0]]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@",goods_salenum[0]]].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo];
            //实现某段字符串显示不一样的颜色
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本次抢购还剩%@件",group_good_count[0]]];
            NSRange redRangeTwo2 = NSMakeRange([[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",group_good_count[0]]].location, [[noteStr2 string] rangeOfString:[NSString stringWithFormat:@"%@",group_good_count[0]]].length);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo2];
            
            TgXqTableViewCell *celltg = [tableViewd dequeueReusableCellWithIdentifier:@"TgXqcell"];
            tableViewd.separatorStyle = NO;
            celltg.lab1.text=[NSString stringWithFormat:@"%@", area_name[0]];
//            celltg.lab2.text=[NSString stringWithFormat:@"¥%@", store_price[0]];
            [celltg.lab3 setAttributedText:noteStr];
            [celltg.lab4 setAttributedText:noteStr2];
            celltg.selectionStyle = UITableViewCellSelectionStyleNone;
            return celltg;
        }else{
        OneSpXqTableViewCell *cell = [tableViewd dequeueReusableCellWithIdentifier:@"Onecell"];
        tableViewd.separatorStyle = NO;
                cell.labyj.text=[NSString stringWithFormat:@"原价¥%@", goods_price[0]];
        cell.labyh.text=[NSString stringWithFormat:@"现价¥%@", store_price[0]];
        cell.labbt.text=[NSString stringWithFormat:@"%@", name[0]];
        cell.labthree.text=[NSString stringWithFormat:@"快递:0.00                月销%@            %@", goods_salenum[0],area_name[0]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    } else if (indexPath.section==1){
      
        
            TwoSpXqTableViewCell *cella = [tableViewd dequeueReusableCellWithIdentifier:@"Twocell"];
            tableViewd.separatorStyle = NO;
        NSString *strgg=[NSString stringWithFormat:@"选择规格:%@  %@  %@",_allview.strid1,_allview.strid2,_allview.strid3];
          NSString *str2 = [strgg stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        cella.labsl.text=str2;
            cella.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cella;
    
        
  
    }else if (indexPath.section==2){
        
      
        
        _strnum=@"1";
         gwcstrpd=@"1";
        static NSString *CellIdenti =@"Cellh";
        //定义cell的复用性当处理大量数据时减少内存开销
        UITableViewCell *cellsw = [tableView  dequeueReusableCellWithIdentifier:CellIdenti];
        
        if (cellsw ==nil)
        {
            cellsw = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdenti];
        }
        [cellsw setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *labxz=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, Screen_Width/3, 35)];
        labxz.text=@"购买数量";
        
        labxz.textColor=RGBColor(64, 64, 64);
        labxz.font=[UIFont systemFontOfSize:14.0f];
        [cellsw addSubview:labxz];
          if ([_strpdz containsString:@"1"]) {
              UILabel *labxg=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/1.3, 0, Screen_Width/4, 35)];
              labxg.text=@"限购买1件";
              labxg.textColor=[UIColor grayColor];
              labxg.font=[UIFont systemFontOfSize:14.0f];
              [cellsw addSubview:labxg];
          }else{
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
          }
       
        return cellsw;
       
    }else if (indexPath.section==3){
              if ([strqf containsString:@"1"]) {
                  [xingimgview removeFromSuperview];
                  //定义个静态字符串为了防止与其他类的tableivew重复
                  static NSString *CellIdentifier =@"Cell";
                  //定义cell的复用性当处理大量数据时减少内存开销
                  UITableViewCell *cellq = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
                  
                  if (cellq ==nil)
                  {
                      cellq = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
                  }
                  if (indexPath.section == 3){
                      
                      [cellq.contentView addSubview:_Webhome];
                      return cellq;
                  }else{
                      
                      return nil;
                  }
              }else{
                
                  FourSpXqTableViewCell *cellc= [tableViewd dequeueReusableCellWithIdentifier:@"Fourcell"];
                  cellc.SpPlM=_plArray[indexPath.row];
                  cellc.selectionStyle = UITableViewCellSelectionStyleNone;
                  for (int i = 0 ; i < xintager; i++) {
                     xingimgview=[[UIImageView alloc]initWithFrame:CGRectMake(20*i, 7, 15, 15)];
                      xingimgview.image=[UIImage imageNamed:@"星星"];
                      [cellc.viewpf addSubview:xingimgview];
                      
                  }
                  return cellc;
              }

         }else{
        return nil;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section==1) {
          NSMutableArray *pandarray=[_guigearray objectAtIndex:0];
            NSLog(@"2=============%@",_guigearray) ;
        if (pandarray != nil && ![pandarray isKindOfClass:[NSNull class]] && pandarray.count != 0) {
            views= [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_height)];
            views.backgroundColor = [UIColor blackColor];
            
            views.alpha=0.5;
            self.myView = views;
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            [window addSubview:views];
            UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
            [views addGestureRecognizer:singleTap];
            
            _allview= [[ShangPview alloc]initWithFrame:CGRectMake(0, Screen_height/2.7, Screen_Width,Screen_height/1.6)];
            _allview.alpha=1;
            [_allview.butsure addTarget:self action:@selector(butsureClic) forControlEvents:UIControlEventTouchUpInside];
        _allview.backgroundColor=[UIColor whiteColor];
            NSLog(@"2=============%@",[_guigearray objectAtIndex:0]) ;
        _allview.moarray=[_guigearray objectAtIndex:0];
        [window addSubview:_allview];
        }else{
            // 准备初始化配置参数
            
            NSString *title = @"请注意";
            
            NSString *message = @"这件商品不需要选择规格";
            
            NSString *okButtonTitle = @"确定";
            // 初始化
            UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            // 创建操作
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            // 添加操作
            
            [alertDialog addAction:okAction];
            
            // 呈现警告视图
            
            [self presentViewController:alertDialog animated:YES completion:nil];
        
        }
    }
    
}
- (void)buttonClick:(UIButton *)buttonClick{
    
    if (buttonClick.tag == 0) {
        strqf=@"0";
        view.hidden = NO;
        view.frame=CGRectMake(viewshang.frame.size.width/titarr.count*0, 37, viewshang.frame.size.width/titarr.count,2);
        
        if (buttonClick.tag == 0) {
            buttonClick.tintColor =[UIColor redColor];
        }else{
            
            button.tintColor =[UIColor grayColor];
        }
        [self lodadate];
    }
    else if (buttonClick.tag == 1) {
        strqf=@"1";
        view.hidden = NO;
        view.frame=CGRectMake(viewshang.frame.size.width/titarr.count*1,37, viewshang.frame.size.width/titarr.count,2);
    
        if (buttonClick.tag == 1) {
            buttonClick.tintColor =[UIColor redColor];
        }else{
            
            button.tintColor =[UIColor grayColor];
        }
        [tableViewd  reloadData];
    }else{
        
        view.hidden = YES;
        button.tintColor = [UIColor grayColor];
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
    [tableViewd reloadData];
}
-(void)handleSingleTap{
    _allview.stridone=@"";
    _allview.stridtwo=@"";
    _allview.stridthree=@"";
    _allview.strid1=@"";
    _allview.strid2=@"";
    _allview.strid3=@"";
//    _allview.strnum=@"";
    [views removeFromSuperview];
    [_allview removeFromSuperview];

}
-(void)butsureClic{
    strguige=[NSString stringWithFormat:@"%@,%@,%@",_allview.strid1,_allview.strid2,_allview.strid3];
    
    NSLog(@"%@",strguige);
    [views removeFromSuperview];
    [_allview removeFromSuperview];

  
   
    [tableViewd reloadData];
    NSLog(@"babba==w==2=2=2=2=2==2=2=2=2=2=2==2=2");

}
//购物车和客服的点击方法
- (void)buttonClickbabab:(UIButton *)buttonClick{
    if (buttonClick.tag == 0) {
      
    }
    else if (buttonClick.tag == 1) {
        LZCartViewController *LZCartVi=[[LZCartViewController alloc]init];
        [self.navigationController pushViewController:LZCartVi animated:NO];
    }
    

}
-(void)butjiaruClick{
    if ([gwcstrpd containsString:@"1"]) {
    
    NSMutableArray *pandarray=[_guigearray objectAtIndex:0];
    if (pandarray != nil && ![pandarray isKindOfClass:[NSNull class]] && pandarray.count != 0) {
        if (_allview.stridone.length==0&&_allview.stridtwo.length==0 &&_allview.stridthree.length==0) {
            [SVProgressHUD showErrorWithStatus:@"请选择规格!"];
        }else{
            NSString *strurlphone;
            NSString *strleix=[NSString stringWithFormat:@"%@,%@,%@",_allview.stridone,_allview.stridtwo,_allview.stridthree];
            NSLog(@"%@",strleix);
            NSString *strUrl = [strleix stringByReplacingOccurrencesOfString:@",(null)" withString:@""];
        if ([_strpdz containsString:@"1"]) {
            strurlphone =[NSString stringWithFormat:@"%@add_goods_cart.htm?id=%@&count=%@&gsp=%@",URLds,arrayspid[0],_strnum,strUrl];
            NSLog(@"%@",strurlphone);
            [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
                
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
        }else{
            strurlphone =[NSString stringWithFormat:@"%@add_goods_cart.htm?id=%@&count=%@&gsp=%@",URLds,_intasid,_strnum,strUrl];
            NSLog(@"%@",strurlphone);
            [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
                
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];

        }
         
        }
    }else{
            NSString *strurlphon;
        
            NSString *strleixsad=[NSString stringWithFormat:@"%@,%@,%@",_allview.stridone,_allview.stridtwo,_allview.stridthree];
        if ([_strpdz containsString:@"1"]) {
            strurlphon =[NSString stringWithFormat:@"%@add_goods_cart.htm?id=%@&count=%@&gsp=%@",URLds,arrayspid[0],_strnum,strleixsad];
            NSLog(@"%@",strurlphon);
            [ZQLNetWork getWithUrlString:strurlphon success:^(id data) {
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
        }else{
    
        strurlphon=[NSString stringWithFormat:@"%@add_goods_cart.htm?id=%@&count=%@&gsp=%@",URLds,_intasid,_strnum,strleixsad];
            NSLog(@"%@",strurlphon);
            [ZQLNetWork getWithUrlString:strurlphon success:^(id data) {
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
        }
  
    
    }
    }else{
        
    }
}
-(void)butchakanClick{
    PingJViewController *PingJVi=[[PingJViewController alloc] init];
    NSLog(@"%@",_intasid);
    PingJVi.intspid=_intasid;
    [self.navigationController pushViewController:PingJVi animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
