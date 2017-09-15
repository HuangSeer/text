//
//  TGViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/1.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TGViewController.h"
#import "PinPCollectionViewCell.h"
#import "PchHeader.h"
#import "TGCollectionReusableView.h"
#import "JYScrollView.h"
#import "SpXqViewController.h"
#import "LoginViewController.h"
#import "LunWebViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
@interface TGViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *homec;
    NSMutableArray *_viewArray;
    UIPageControl *_pageControl;
    NSArray *titleArray;
    NSArray *idArray;
    UIView *viewas;
    UIView *view;
    UIButton *button;
    NSString *strqf;
    NSString *strid;
    NSString *strtime;
    NSMutableArray *_buttonArray;
    NSString *phone;
    NSString *cookiestr;
     NSMutableArray *LunurlArray;
    UIView *views;
    int xsd;
    NSMutableDictionary *userinfo;
    NSDate *d;

TGCollectionReusableView *headerView;
}
@property(assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) NSMutableArray *ModelArray;
@property (strong,nonatomic) NSMutableArray *imageUrlArray;
@property (nonatomic, strong) JYScrollView * jyScrollView;
@end

@implementation TGViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
    self.navigationItem.title=@"超值团购";

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    
      [self myCollect];
    
    NSString *strurlphone=[NSString stringWithFormat:@"%@groupTime.htm",URLds];
    NSLog(@"%@",strurlphone);
    [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
         NSLog(@"==2==2=2=2========%@",data);
           NSArray *timearray =[[data objectForKey:@"data"] valueForKey:@"groupTime"] ;
        if (timearray.count!=0) {
            long long time=[timearray[0] longLongValue];
            
            d= [[NSDate alloc]initWithTimeIntervalSince1970:time/1000];
            
            //启动倒计时后会每秒钟调用一次方法
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodsa) userInfo:nil repeats:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
     
     
    }];
    NSString *strurlfl=[NSString stringWithFormat:@"%@groupClass.htm",URLds];
    [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
//        NSLog(@"sad===2==2=2=2========%@",data);
        titleArray =[[data objectForKey:@"data"] valueForKey:@"groupClassName"];
        idArray =[[data objectForKey:@"data"] valueForKey:@"groupClassId"];
        [homec reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
    strid=@"1";
    [self setupRefresh];
    [self LunBoTu];
  

}
-(void)LunBoTu{
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/advert_invoke.htm?advertType=1",DsURL];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
//        NSLog(@"LunBoTu=%@",data);
        _imageUrlArray =[data valueForKey:@"ad_path"];
        LunurlArray=[data valueForKey:@"ad_url"];
        [homec reloadData];
    } failure:^(NSError *error)
     {
         
         NSLog(@"---------------%@",error);
         [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
     }];
}

-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)timeFireMethodsa{
//倒计时-1
    NSDate * date = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval timebab = [d timeIntervalSinceDate:date];
    int d = ((int)timebab)/60/60/24;
    int h = ((int)timebab)/60/60%24;
    int  m = ((int)timebab)/60%60;
    int  s = ((int)timebab)%60;
    NSString *format_time2 = [NSString stringWithFormat:@"%d天%d时%d分%d秒",d,h,m,s];
  
    headerView.Labtime.text=[NSString stringWithFormat:@"剩余 %@",format_time2];
}
-(void)lodadate{
    [homec reloadData];
    NSString *strurlfl=[NSString stringWithFormat:@"%@groupGoodsList.htm?groupClassId=%@&currentPage=%ld&pageSize=6&groupId",URLds,strid,_currentPage];
    NSLog(@"%@",strurlfl);
    [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {

        NSArray *array=[TgModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        if (_currentPage==1) {
            [_ModelArray removeAllObjects];
        }
        [_ModelArray addObjectsFromArray:array];
        if (_ModelArray.count==0) {
            [SVProgressHUD showErrorWithStatus:@"暂无团购信息!"];
        }
        [homec reloadData];
       
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"获取品牌失败!!"];
    }];

    



}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height-10) collectionViewLayout:layout];
    NSLog(@"%@",layout);
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerNib:[UINib nibWithNibName:NSStringFromClass([PinPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_height/2.5);
    
    [homec registerClass:[TGCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    
   
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    [headerView removeFromSuperview];
    
#pragma mark ----- 重用的问题
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]==YES)
    {
        if(indexPath.section==0)
        {
            _viewArray = [NSMutableArray array];
            _buttonArray = [[NSMutableArray alloc] init];
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
            //轮播图
            if (!_jyScrollView) {
                _jyScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_Width/2 )];
                [_jyScrollView bannerWithArray:_imageUrlArray titleArr:nil imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                    LunWebViewController *LunWebV=[[LunWebViewController alloc] init];
                    LunWebV.panduanstr=LunurlArray[index];
                    
                    [self.navigationController pushViewController:LunWebV animated:NO];
                    self.navigationController.navigationBarHidden=NO;
                    self.tabBarController.tabBar.hidden=YES;
                    
                    NSLog(@"%@",LunurlArray[index]);
                }];
                _jyScrollView.timeInterval = 4;
                [headerView addSubview:_jyScrollView];
            }else{
                [_jyScrollView bannerWithArray:_imageUrlArray titleArr:nil imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                    LunWebViewController *LunWebV=[[LunWebViewController alloc] init];
                    LunWebV.panduanstr=LunurlArray[index];
                    
                    [self.navigationController pushViewController:LunWebV animated:NO];
                    self.navigationController.navigationBarHidden=NO;
                    self.tabBarController.tabBar.hidden=YES;
                    
                    NSLog(@"%@",LunurlArray[index]);
                }];
                _jyScrollView.timeInterval = 4;
                [headerView addSubview:_jyScrollView];
            }
            viewas=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-40, Screen_Width, 39)];
            viewas.backgroundColor=[UIColor whiteColor];
                for (int i = 0 ; i < titleArray.count; i++) {
                button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(viewas.frame.size.width/titleArray.count*i, 5, viewas.frame.size.width/titleArray.count-5, 39);
                [button setFont:[UIFont systemFontOfSize:13.0f]];
                [button setTitle:titleArray[i] forState:UIControlStateNormal];
                button.tintColor = [UIColor grayColor];
                if (i == [strqf intValue]) {
                    button.tintColor =RGBColor(93, 225, 30);
                }
                button.tag = i;
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [viewas addSubview:button];
                
                view = [[UIView alloc] initWithFrame:CGRectMake(viewas.frame.size.width/titleArray.count*i, 37, viewas.frame.size.width/titleArray.count-5,2)];
                view.backgroundColor = RGBColor(93, 225, 30);
                if (i == [strqf intValue]) {
                    view.hidden = NO;
                }else{
                    view.hidden = YES;
                }
                [viewas addSubview:view];
                [viewas addSubview:button];
                [_viewArray addObject:view];
                [_buttonArray addObject:button];
            }
            [headerView addSubview:viewas];
            
            return headerView;
        }else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, Screen_height/2.2);
    }
    else {
        return CGSizeMake(0, 0);
    }
}
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _ModelArray.count;
    
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 200);
}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PinPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.TgMo = _ModelArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.addToCartsBlock = ^(PinPCollectionViewCell *cell) {
        [weakSelf myFavoriteCellAddToShoppingCart:cell];
    };
  

    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     TgModel *TgMo = _ModelArray[indexPath.row];
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            
            NSString *xstr=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
            SpXqVi.intasid=TgMo.group_goods_id;
            SpXqVi.strpdz=@"1";
            [self.navigationController pushViewController:SpXqVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            //                [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }
}
- (void)buttonClick:(UIButton *)buttonClick{
    if (buttonClick.tag == 0) {
        strid=idArray[0];
        strqf=@"0";
        self.currentPage=1;
        view.hidden = NO;
        view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*0, 37, viewas.frame.size.width/titleArray.count,2);
        if (buttonClick.tag == 0) {
            buttonClick.tintColor =RGBColor(93, 225, 30);
        }else{
            button.tintColor =[UIColor grayColor];
        }
        [self lodadate];
    }
    else if (buttonClick.tag == 1) {
        strqf=@"1";
        strid=idArray[1];
        self.currentPage=1;
        view.hidden = NO;
        view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*1,37, viewas.frame.size.width/titleArray.count,2);
        if (buttonClick.tag == 1) {
            buttonClick.tintColor =RGBColor(93, 225, 30);
        }else{
            button.tintColor =[UIColor grayColor];
        }
        [self lodadate];
    }
    else if (buttonClick.tag == 2) {
        strid=idArray[2];
        strqf=@"2";
        self.currentPage=1;
        view.hidden = NO;
        
        view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*2, 37, viewas.frame.size.width/titleArray.count,2);
        
        if (buttonClick.tag == 2) {
            buttonClick.tintColor =RGBColor(93, 225, 30);
        }
        else{
            
            button.tintColor =[UIColor grayColor];
        }
        [self lodadate];
    }else if(buttonClick.tag == 3){
        strid=idArray[3];
        strqf=@"3";
        self.currentPage=1;
        view.hidden = NO;
        view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*3, 37, viewas.frame.size.width/titleArray.count,2);
        
        if (buttonClick.tag == 3) {
            buttonClick.tintColor =RGBColor(93, 225, 30);
        }
        else{
            
            button.tintColor =[UIColor grayColor];
        }
        [self lodadate];
    }else{
        
        view.hidden = YES;
        button.tintColor = [UIColor grayColor];
    }
    
    //    }
    
    
}
- (void)myFavoriteCellAddToShoppingCart:(PinPCollectionViewCell *)cell{
    
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
        
            NSString *xstr=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
            SpXqVi.intasid=cell.TgMo.group_goods_id;
            SpXqVi.strpdz=@"1";
            [self.navigationController pushViewController:SpXqVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            //                [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }else{
        
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }


}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self lodadate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [homec reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [homec.mj_header endRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.数据操作
    self.currentPage++;
    [self lodadate];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [homec reloadData];
        [homec.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    
    homec.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRereshing];
        
    }];
    
#warning 自动刷新(一进入程序就下拉刷新)
    
    [homec.mj_header beginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    
    homec.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
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
