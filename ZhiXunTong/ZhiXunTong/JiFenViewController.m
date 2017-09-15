
//
//  JiFenViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JiFenViewController.h"
#import "PchHeader.h"
#import "JYScrollView.h"
#import "JeFenCollectionReusableView.h"
#import "JfDSchengCollectionViewCell.h"
#import "LoginViewController.h"
#import "JfXqViewController.h"
#import "DhJlViewController.h"
#import "LoginViewController.h"
#import "LunWebViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
@interface JiFenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *homec;
    UIButton *button;
    UIView *view;
    NSMutableArray *_viewArray;
    UIPageControl *_pageControl;
    NSArray *titleArray;
    NSMutableArray *_buttonArray;
    UIView *viewas;
    NSString *beginstr;
    NSString *endstr;
    NSString *strqf;
    NSString *phone;
     NSMutableDictionary *userinfo;
    NSString *cookiestr;
    NSUserDefaults *userDefaults;
     NSMutableArray *LunurlArray;
    NSString *integral;
JeFenCollectionReusableView *headerView;

}
@property(assign,nonatomic) NSInteger currentPage;
@property (nonatomic, strong) JYScrollView * jyScrollView;
@property (strong,nonatomic) NSMutableArray *imageUrlArray;
@property (strong,nonatomic) NSMutableArray *titleUrlArray;
@property (strong,nonatomic) NSMutableArray *ModelArray;
@end

@implementation JiFenViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"积分商城";
    userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    cookiestr=[userDefaults objectForKey:Cookiestr];
    _ModelArray=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    
    [self myCollect];
    strqf=@"0";
    beginstr=@"";
    endstr=@"";
    [self loadlunbo];
    [self setupRefresh];
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
-(void)loadlunbo{
//轮播图数据请求
  NSString *strurlima=[NSString stringWithFormat:@"%@advert_invoke.htm?advertType=2",URLds];
  [ZQLNetWork getWithUrlString:strurlima success:^(id data) {
    _imageUrlArray=[data valueForKey:@"ad_path"];
    _titleUrlArray=[data valueForKey:@"ad_title"];
     LunurlArray=[data valueForKey:@"ad_url"];
  } failure:^(NSError *error) {
       NSLog(@"---------------%@",error);
    [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
//cell数据请求
-(void)lodadatesss{
//    [homec reloadData];

    NSString *strurl=[NSString stringWithFormat:@"%@integral.htm?begin=%@&end=%@&currentPage=%ld&pageSize=6",URLds,beginstr,endstr,_currentPage];
    NSLog(@"%@",strurl);
    
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
         NSLog(@"%@",data);
        NSArray *array=[JfModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        if (_currentPage==1) {
            [_ModelArray removeAllObjects];
        }
        
        
        [_ModelArray addObjectsFromArray:array];
        if (_ModelArray.count==0) {
             [SVProgressHUD showErrorWithStatus:@"暂无数据!"];
        }
      [homec reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        _ModelArray=nil;
         [homec reloadData];
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
        [homec registerNib:[UINib nibWithNibName:NSStringFromClass([JfDSchengCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
   layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_height/2.2);
   [homec registerClass:[JeFenCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
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
            if (_imageUrlArray.count!=0) {
          
            if (!_jyScrollView) {
                _jyScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_Width/2)];
                [_jyScrollView bannerWithArray:_imageUrlArray titleArr:_titleUrlArray imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                    LunWebViewController *LunWebV=[[LunWebViewController alloc] init];
                    LunWebV.panduanstr=LunurlArray[index];
                    
                    [self.navigationController pushViewController:LunWebV animated:NO];
                    self.navigationController.navigationBarHidden=NO;
                    self.tabBarController.tabBar.hidden=YES;
                    
                    NSLog(@"%@",LunurlArray[index]);
                    NSLog(@"点击了轮播图click   NO.%ld",index);
                }];
                _jyScrollView.timeInterval = 4;
                [headerView addSubview:_jyScrollView];
            }else{
                [_jyScrollView bannerWithArray:_imageUrlArray titleArr:_titleUrlArray imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                    LunWebViewController *LunWebV=[[LunWebViewController alloc] init];
                    LunWebV.panduanstr=LunurlArray[index];
                    
                    [self.navigationController pushViewController:LunWebV animated:NO];
                    self.navigationController.navigationBarHidden=NO;
                    self.tabBarController.tabBar.hidden=YES;
                    
                    NSLog(@"%@",LunurlArray[index]);
                    NSLog(@"点击了轮播图click   NO.%ld",index);
                }];
                _jyScrollView.timeInterval = 4;
                [headerView addSubview:_jyScrollView];
            }
            }
           [headerView.butdh addTarget:self action:@selector(butdhClick) forControlEvents:UIControlEventTouchUpInside];
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"我的积分:%@",_integral]];
            NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@",_integral]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"%@",_integral]].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRangeTwo];
            [headerView.yiLable setAttributedText:noteStr];
            [headerView.yiLable sizeToFit];

            viewas=[[UIView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height-40, Screen_Width, 39)];
            viewas.backgroundColor=[UIColor whiteColor];
            titleArray=@[@"推荐",@"小于2000",@"2000~4000",@"4000~6000",@"6000~10000"];
            for (int i = 0 ; i < titleArray.count; i++) {
                button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(viewas.frame.size.width/titleArray.count*i, 5, viewas.frame.size.width/titleArray.count-5, 39);
                [button setFont:[UIFont systemFontOfSize:9.0f]];
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
        return CGSizeMake(Screen_Width, Screen_height/2);
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
    return UIEdgeInsetsMake(10, 5, 10, 5);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(150, 140);
}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JfDSchengCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.JfM = _ModelArray[indexPath.row];
        __weak typeof(self) weakSelf = self;
    cell.addToCartsBlock = ^(JfDSchengCollectionViewCell *cell) {
        [weakSelf myFavoriteCellAddToShoppingCart:cell];
    };
    
    return cell;
}
- (void)buttonClick:(UIButton *)buttonClick{

        if (buttonClick.tag == 0) {
            beginstr=@"";
            endstr=@"";
            strqf=@"0";
            _currentPage=1;
            view.hidden = NO;
            view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*0, 37, viewas.frame.size.width/titleArray.count,2);
           
            if (buttonClick.tag == 0) {
                buttonClick.tintColor =RGBColor(93, 225, 30);
            }else{
                
                button.tintColor =[UIColor grayColor];
            }
             [self lodadatesss];
        }
        else if (buttonClick.tag == 1) {
            beginstr=@"0";
            endstr=@"2000";
            strqf=@"1";
              _currentPage=1;
            view.hidden = NO;
            view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*1,37, viewas.frame.size.width/titleArray.count,2);
            
            if (buttonClick.tag == 1) {
                buttonClick.tintColor =RGBColor(93, 225, 30);
            }else{
                
                button.tintColor =[UIColor grayColor];
            }
            [self lodadatesss];
        }
        else if (buttonClick.tag == 2) {
            beginstr=@"2000";
            endstr=@"4000";
            strqf=@"2";
              _currentPage=1;
            view.hidden = NO;
           
            view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*2, 37, viewas.frame.size.width/titleArray.count,2);
            
            if (buttonClick.tag == 2) {
                buttonClick.tintColor =RGBColor(93, 225, 30);
            }
            else{
                
                button.tintColor =[UIColor grayColor];
            }
             [self lodadatesss];
        }else if(buttonClick.tag == 3){
            beginstr=@"4000";
            endstr=@"6000";
            strqf=@"3";
              _currentPage=1;
         
            view.hidden = NO;
            view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*3, 37, viewas.frame.size.width/titleArray.count,2);
        
            if (buttonClick.tag == 3) {
                buttonClick.tintColor =RGBColor(93, 225, 30);
            }
            else{
                
                button.tintColor =[UIColor grayColor];
            }
               [self lodadatesss];
        }else if(buttonClick.tag == 4){
            beginstr=@"6000";
            endstr=@"10000";
            strqf=@"4";
             _currentPage=1;
            view.hidden = NO;
            view.frame=CGRectMake(viewas.frame.size.width/titleArray.count*4, 37, viewas.frame.size.width/titleArray.count,2);
            if (buttonClick.tag== 4) {
                buttonClick.tintColor =RGBColor(93, 225, 30);
            }
            else{
                
                button.tintColor =[UIColor grayColor];
            }
             [self lodadatesss];
            
        }else{
            
            view.hidden = YES;
            button.tintColor = [UIColor grayColor];
        }
        
//    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JfModel *model=_ModelArray[indexPath.row];
    JfXqViewController *JfXqVi=[[JfXqViewController alloc] init];
    JfXqVi.intid=model.igs_id;
    [self.navigationController pushViewController:JfXqVi animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;

}
- (void)myFavoriteCellAddToShoppingCart:(JfDSchengCollectionViewCell *)cell{
    JfXqViewController *JfXqVi=[[JfXqViewController alloc] init];
    JfXqVi.intid=cell.JfM.igs_id;
    [self.navigationController pushViewController:JfXqVi animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
}
//兑换记录
-(void)butdhClick{
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
            
            DhJlViewController *DhJlVi=[[DhJlViewController alloc] init];
            [self.navigationController pushViewController:DhJlVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
        
    }else{
//        [SVProgressHUD showErrorWithStatus:@"还没有登录"];
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
    }
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    self.currentPage=1;
    // 1.数据操作
    [self lodadatesss];
    
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
    [self lodadatesss];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
