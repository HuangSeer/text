//
//  PropertyViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/2.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PropertyViewController.h"
#import "PchHeader.h"
#import "MyCollectionViewCell.h"
#import "PublicCell.h"
#import "WuYeCollectionViewCell.h"
#import "YiCollectionReusableView.h"
#import "TrendCollectionViewCell.h"
#import "OpenViewController.h"
//车位开锁
#import "CheWeiViewController.h"
#import "ReMenViewController.h"
#import "GonggaoViewController.h"
#import "KuaiDiWebViewController.h"
#import "WuYeQuectViewController.h"
#import "HengCollectionViewCell.h"
#import "wuyetuijieTableViewCell.h"
#import "ErCollectionReusableView.h"
#import "ReMenModel.h"
#import "TreatViewController.h"
#import "XQTreatViewController.h"
#import "WuYewebViewController.h"
#import "LiuYanViewController.h"
#import "TrusteeshipViewController.h"
#import "TPXiaoQingViewController.h"
#import "wyTuiJieViewController.h"
#import "LoginViewController.h"
#import "ZhiNengViewController.h"

#import "SGAdvertScrollView.h"
#import "SGHelperTool.h"
#import "JiaJuViewController.h"
#import "LiHuDongCollectionViewCell.h"//互动CELL
#import "HuDongCollectionViewCell.h"//
#import "WeiBaCollectionViewCell.h"
#import "SheQuCollectionViewCell.h"//社区活动
#import "shbkCollectionViewCell.h"//生活百科cell
#import "SDCycleScrollView.h"
#import "CBHeaderChooseViewScrollView.h"
#import "SHBKModel.h"
#import "BaiKeXqViewController.h"//百科详情
#import "BaiKeViewController.h"//生活百科
#import "FaTieViewController.h"//发帖
@interface PropertyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,FDAlertViewDelegate,SDCycleScrollViewDelegate>
{
    NSArray *classArray;
    NSArray *classArrayImage;
    UICollectionView *homec;
    YiCollectionReusableView *headerView;
    ErCollectionReusableView *headerView1;
    
    UITableView *_MyTableView;
    
    NSMutableArray *_saveDataArray;
    NSMutableArray *_oneDataArray;
    NSMutableArray *_twoDataArray;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aadeid;
    
    NSString *name;
    NSString *iphone;
    NSString *phone;
    NSString *eid;
    NSString *touUrl;
    int sh;
    id<AnjubaoSDK> sdk;
    NSMutableArray *_lunBoArray;//第一次请求用
    CBHeaderChooseViewScrollView *cbhead;
    NSMutableArray *_saveArray;
    NSInteger ax;
}
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;

@property (nonatomic,strong)NSMutableArray *imageUrlArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end

@implementation PropertyViewController
//物业
static PropertyViewController* instance;
@synthesize  serverAddress, appType, appTypeValue, areaTypeValue, isVersion2;
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSString *ss=[userDefaults objectForKey:shzts];
    sh=[ss intValue];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadeid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
     phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    if (userinfo.count>0) {
        [self panduandenglu];
      
    }else{
        NSLog(@"=22==2=2=2=2=2=2=2==2=2=2=2=2");
    }
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
   
    _imageUrlArray=[NSMutableArray arrayWithCapacity:0];
    _titleArray=[NSMutableArray arrayWithCapacity:0];
    instance = self;
    isVersion2 = NO;
    sdk = [AnjubaoSDK instance];
    
    [sdk setDebug:YES];
    [sdk setOfflineDelegate:self];
    //    NSString* areaType = [self.areaTypePicker text];
    areaTypeValue = 1;
    appTypeValue = 2;
    //    serverAddress = [self.serverAddressPicker text];
    [self connectService];
    
    classArray =@[@"一键开门",@"车位开锁",@"物业托管",@"快递查询",@"可视对讲",@"物业查询",@"物业公告",@"热门话题"];
    classArrayImage=@[@"yjkm03.png",@"wy11.png",@"wytg03.png",@"kdcx03.png",@"znjj03.png",@"wyjf03.png",@"gkgs03.png",@"wytp03.png",];
    self.tabBarController.tabBar.hidden=NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadeid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
  
     [self baike];
    [self myCollect];
}
-(void)panduandenglu{

    NSString *pages=@"3";
    //NSLog(@"aakey:%@  --%@--%@",aakey,aaid,aatvinfo);
    [[WebClient sharedClient] Userid:aaid Keys:aakey Tvinfo:aatvinfo pages:pages page:@"1"ResponseBlock:^(id resultObject, NSError *error) {
        // NSLog(@"成功：%@",resultObject);
        _saveDataArray=[[NSMutableArray alloc]initWithArray:[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1)
        {
            [[WebClient sharedClient] TuiJie:aatvinfo Keys:aakey UserId:aaid pagesize:@"10" page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                //NSLog(@"物业推荐：%@",resultObject);
                _oneDataArray=[[NSMutableArray alloc]initWithArray:[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
                
                [[WebClient sharedClient] Gongshi:aatvinfo Keys:aakey DptId:aadeid MobileNo:@"" UserName:@"" pages:@"3" Page:@"1" ResponseBlock:^(id resultObject, NSError *error) {
                    NSLog(@"%@-%@-%@",aatvinfo,aakey,aadeid);
                    //NSLog(@"公示：%@",resultObject);
                    _twoDataArray=[[NSMutableArray alloc]initWithArray:[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
                    [self touWuYe];
                    //                    [homec reloadData];
                }];
            }];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }];
}
//获取头请求
-(void)touWuYe
{
    [[WebClient sharedClient] touWu:aaid ResponseBlock:^(id resultObject, NSError *error){
//        NSLog(@"%@",resultObject);
//        NSLog(@"%@",[resultObject objectForKey:@"Url"]);
        touUrl=[resultObject objectForKey:@"Url"];
        NSMutableArray *array=[resultObject objectForKey:@"Data"];
        NSMutableDictionary *dic=[array objectAtIndex:0];
        name=[dic objectForKey:@"Ecompany"];
        iphone=[dic objectForKey:@"Phone"];
        eid=[dic objectForKey:@"Eid"];
        [homec reloadData];
    }];
}
//#pragma mark tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _oneDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Screen_Width/2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     wuyetuijieTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"wuyetuijieTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    ReMenModel *mode=[_oneDataArray objectAtIndex:indexPath.row];
    //对Cell要做的设置
    cell.lable_title.text=[NSString stringWithFormat:@"%@",mode.title];
    NSURL *ur=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.imgurl]];
    NSLog(@"ur=%@",ur);
    cell.lable_title.frame=CGRectMake(10, 70, Screen_Width/2-30, 30);
    cell.img_bakeg.frame=CGRectMake(10, 10, Screen_Width/2-30, 90);
    cell.lable_title.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4f];
    [cell.img_bakeg sd_setImageWithURL:ur placeholderImage:[UIImage imageNamed:@"003.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
//    ReMenModel *mode=[_oneDataArray objectAtIndex:indexPath.row];
//    NSString *ss=[NSString stringWithFormat:@"%@",mode.url];
//    NSLog(@"%@",ss);
//    WuYewebViewController *web=[[WuYewebViewController alloc] initWithCoders:ss Title:mode.title];
//    [self.navigationController pushViewController:web animated:NO];
//    self.tabBarController.tabBar.hidden=YES;
}
-(void)myCollect{
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"物业服务";
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height-64) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [homec registerClass:[WuYeCollectionViewCell class] forCellWithReuseIdentifier:@"wuyeId"];
    [homec registerClass:[TrendCollectionViewCell class] forCellWithReuseIdentifier:@"trendView"];
    [homec registerClass:[LiHuDongCollectionViewCell class] forCellWithReuseIdentifier:@"LiHuDong"];
    [homec registerClass:[HuDongCollectionViewCell class] forCellWithReuseIdentifier:@"HuDong"];
    [homec registerClass:[SheQuCollectionViewCell class] forCellWithReuseIdentifier:@"SheQu"];
    [homec registerClass:[shbkCollectionViewCell class] forCellWithReuseIdentifier:@"shbk"];
    
    [homec registerClass:[HengCollectionViewCell class] forCellWithReuseIdentifier:@"hengView"];
    [homec registerNib:[UINib nibWithNibName:NSStringFromClass([WuYeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    //[homec registerClass:[NoitceCell class] forCellWithReuseIdentifier:@"notiId"];
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
     [homec registerClass:[YiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"diyiView"];
    [homec registerClass:[ErCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView"];
    //[homec registerClass:[HengCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hengView"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[WeiBaCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"weiba"];
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    //设置footView的尺寸大小
    layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;
    
    
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 8;
    }
    else if (section==1)
    {
        return 3;
    }
    else if (section==2)
    {
        return 1;
    }
    else if (section==3)
    {
        return _saveArray.count;
    }
    else
    {
        return 0;
    }
    
}
//item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classArrayImage objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[classArray objectAtIndex:indexPath.item]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section==1)
    {
        if (indexPath.item==0) {
            LiHuDongCollectionViewCell *cell=(LiHuDongCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LiHuDong" forIndexPath:indexPath];
            _MyTableView=[[UITableView alloc] init];
            _MyTableView.dataSource=self;
            _MyTableView.delegate=self;
            _MyTableView.separatorStyle = NO;
            //对TableView要做的设置
            _MyTableView.transform=CGAffineTransformMakeRotation(-M_PI / 2);
            _MyTableView.showsVerticalScrollIndicator=NO;
            _MyTableView.frame=CGRectMake(0, 0, Screen_Width, 90);
            [cell.contentView addSubview:_MyTableView];
            return cell;
        }else{
            HuDongCollectionViewCell *cell=(HuDongCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HuDong" forIndexPath:indexPath];
            cell.Hname.text = [NSString stringWithFormat:@"用户1"];
            cell.HleiX.text = [NSString stringWithFormat:@"四个字啊"];
            cell.Hleirong.text = [NSString stringWithFormat:@"四个字啊四个字啊四个字啊四个字啊四个字啊"];
            cell.Htime.text=[NSString stringWithFormat:@"1014/21/12"];
            return cell;
        }
        
        
    }
    else if (indexPath.section==2)
    {
        //社区活动
        SheQuCollectionViewCell *cell=(SheQuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SheQu" forIndexPath:indexPath];
        cell.Hname.text = [NSString stringWithFormat:@"四个字啊四个字啊四个字啊四个字啊四个字啊"];
        cell.HleiX.text = [NSString stringWithFormat:@"四个字啊"];
        cell.Hleirong.text = [NSString stringWithFormat:@"123456789123456789"];
       // hengTableView=[UITableView alloc];
        return cell;
    }
    else if (indexPath.section==3)
    {
        //生活百科
        shbkCollectionViewCell *cell=(shbkCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"shbk" forIndexPath:indexPath];
        SHBKModel *mode=[_saveArray objectAtIndex:indexPath.row];
        cell.bklabel.text=mode.title;
        cell.bklabelTit.text=mode.type;
        [cell.bkImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,mode.url]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        
//        cell.bklabelTit.text=@"12434";
//        cell.bklabel.text=@"123456";
//        [cell.bkImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@333",URL]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        return cell;
    }
    else{
        return nil;
    }

}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float with = (self.view.bounds.size.width-100) / 4;
    if (indexPath.section==0)
    {
        return CGSizeMake(with, with+20);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(Screen_Width, 90);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(Screen_Width, 100);
    }
    else if (indexPath.section==3)
    {
        return CGSizeMake(Screen_Width, 156);
    }
    else
    {
        return CGSizeMake(Screen_Width, 10);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 10);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 60);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 90);
    }
    else if (section==3)
    {
        return CGSizeMake(Screen_Width, 10);
    }
    else
    {
        return CGSizeMake(Screen_Width, 0);
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, Screen_Width / 2+10);
    }
    else if (section==1)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else if (section==2)
    {
        return CGSizeMake(Screen_Width, 30);
    }
    else if (section==3)
    {
        return CGSizeMake(Screen_Width, 0);
    }
    else
    {
        return CGSizeMake(0, 0);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else if (section==1)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else if (section==3)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
#pragma mark ----- 重用的问题
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]==YES)
    {
        if (indexPath.section==0)
        {
         UICollectionReusableView *YiheaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            if (_lunBoArray.count>0) {
                [headerView addSubview:self.topPhotoBoworr];
            }
            return YiheaderView;
        }
        else if (indexPath.section==1)
        {
            headerView1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            headerView1.erLable.text=@"邻里互动";
            headerView1.erLable.frame=CGRectMake(20, 3, 100, 29);
            headerView1.erLable.textColor=RGBColor(65, 140, 12);
            headerView1.erLable.textAlignment=NSTextAlignmentLeft;
            [headerView1.erButton setTitle:@"更多>>" forState:UIControlStateNormal];
            headerView1.erButton.frame=CGRectMake(Screen_Width-80, 0, 80, 30);
            headerView1.erButton.backgroundColor=[UIColor clearColor];
            headerView1.erButton.tag=1002;
            headerView1.xianView2.frame=CGRectMake(10, 29, Screen_Width-20, 0.5);
            [headerView1.erButton addTarget:self action:@selector(wyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 10, 5, 15)];
            aa.backgroundColor=RGBColor(65, 140, 12);
            [headerView1 addSubview:aa];
            return headerView1;
            
        }
        else if (indexPath.section==2)
        {
            headerView1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"dierView" forIndexPath:indexPath];
            
            headerView1.erLable.text=@"社区活动";
            headerView1.erLable.frame=CGRectMake(20, 3, 100, 29);
            headerView1.erLable.textColor=RGBColor(65, 140, 12);
            headerView1.erLable.textAlignment=NSTextAlignmentLeft;
            [headerView1.erButton setTitle:@"更多>>" forState:UIControlStateNormal];
            headerView1.erButton.frame=CGRectMake(Screen_Width-80, 0, 80, 30);
            headerView1.erButton.tag=1001;
            [headerView1.erButton addTarget:self action:@selector(wyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            headerView1.xianView2.frame=CGRectMake(10, 29, Screen_Width-20, 0.5);
            headerView1.backgroundColor = [UIColor clearColor];
            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 10, 5, 15)];
            aa.backgroundColor=RGBColor(65, 140, 12);
            [headerView1 addSubview:aa];
            return headerView1;
        }
        else if (indexPath.section==3)
        {
            for (UIView *view in cbhead.subviews) {
                [view removeFromSuperview];
            }
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
            
//            headerView.yiLable.text=@"生活百科";
//            headerView.yiLable.frame=CGRectMake(20, 3, 100, 29);
//            headerView.yiLable.textColor=RGBColor(65, 140, 12);
//            headerView.yiLable.textAlignment=NSTextAlignmentLeft;
//            [headerView.yiButton setTitle:@"更多>>" forState:UIControlStateNormal];
//            headerView.yiButton.frame=CGRectMake(Screen_Width-80, 0, 80, 30);
//            headerView.yiButton.tag=1000;
//            [headerView.yiButton addTarget:self action:@selector(wyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            headerView.xianView.frame=CGRectMake(10, 29, Screen_Width-20, 0);
//            headerView.backgroundColor = [UIColor clearColor];
//            
//            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 10, 5, 15)];
//            aa.backgroundColor=RGBColor(65, 140, 12);
//            [headerView addSubview:aa];
//            
//            UIView *aa1=[[UIView alloc] initWithFrame:CGRectMake(0, 30, 10, 40)];
//            aa1.backgroundColor=[UIColor whiteColor];
//            [headerView addSubview:aa1];
//            
//            UIView *aa2=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width-10, 30, 10, 40)];
//            aa2.backgroundColor=[UIColor whiteColor];
//            [headerView addSubview:aa2];
            return headerView;
        }
        else
        {
            headerView1 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"dierView" forIndexPath:indexPath];
//            for (UIView *view in headerView.subviews) {
//                [view removeFromSuperview];
//            }
            headerView1.backgroundColor=[UIColor redColor];
            return headerView1;
        }
    }
    else
    {
        if (indexPath.section==1) {
            WeiBaCollectionViewCell *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"weiba" forIndexPath:indexPath];
            footerView.backgroundColor = RGBColor(236, 236, 236);
            UIView *baise=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
            baise.backgroundColor=[UIColor whiteColor];
            [footerView addSubview:baise];
            
            UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
            denglu.frame = CGRectMake(Screen_Width/2-90, 10, 180, 30);
            denglu.backgroundColor = RGBColor(240, 168, 54);
            [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            denglu.titleLabel.font=[UIFont systemFontOfSize:13];
            [denglu setTitle:@"我要发帖" forState:UIControlStateNormal];
            denglu.layer.cornerRadius=10;
            denglu.tag=202;
            [denglu addTarget:self action:@selector(wyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [footerView addSubview:denglu];
            
            return footerView;
        }else if (indexPath.section==2)
        {
            for (UIView *view in cbhead.subviews) {
                [view removeFromSuperview];
            }
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
            UIView *bb=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10)];
            bb.backgroundColor=RGBColor(234, 234, 234);
            [headerView addSubview:bb];
            
            headerView.yiLable.text=@"生活百科";
            headerView.yiLable.frame=CGRectMake(20, 13, 100, 29);
            headerView.yiLable.textColor=RGBColor(65, 140, 12);
            headerView.yiLable.textAlignment=NSTextAlignmentLeft;
            [headerView.yiButton setTitle:@"更多>>" forState:UIControlStateNormal];
            headerView.yiButton.frame=CGRectMake(Screen_Width-80, 10, 80, 30);
            headerView.yiButton.tag=1000;
            [headerView.yiButton addTarget:self action:@selector(wyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            headerView.xianView.frame=CGRectMake(10, 29, Screen_Width-20, 0);
            headerView.backgroundColor = [UIColor clearColor];
            
            
            if (_titleArray.count!=0) {
           
            cbhead=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0,40, Screen_Width, 40)];
            [cbhead setUpTitleArray:_titleArray titleColor:[UIColor blackColor] titleSelectedColor:RGBColor(65, 140, 12) titleFontSize:0];
            cbhead.btnChooseClickReturn = ^(NSInteger x) {
                NSLog(@"aaaaaa%ld",(long)x);
                ax=x;
                [self shbaike:[NSString stringWithFormat:@"%ld",(long)x]];
            };
            [headerView addSubview:cbhead];
            }
            UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 20, 5, 15)];
            aa.backgroundColor=RGBColor(65, 140, 12);
            [headerView addSubview:aa];
            
            UIView *aa1=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 10, 40)];
            aa1.backgroundColor=[UIColor whiteColor];
            [headerView addSubview:aa1];
            
            UIView *aa2=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width-10, 40, 10, 40)];
            aa2.backgroundColor=[UIColor whiteColor];
            [headerView addSubview:aa2];
            return headerView;
        }
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
        footerView.backgroundColor = RGBColor(236, 236, 236);
        return footerView;
    }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (sh==1)
    {
        if (indexPath.section==0) {
            MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            NSString *msg = cell.botlabel.text;
            if (indexPath.item==1) {
                CheWeiViewController *CheWei=[[CheWeiViewController alloc] init];
                [self.navigationController pushViewController:CheWei animated:NO];
                NSLog(@"车位开锁");
                self.tabBarController.tabBar.hidden=YES;
            }
            else if (indexPath.item==0)
            {
              //  [SVProgressHUD showErrorWithStatus:@"该小区暂未开通"];
                 OpenViewController *open=[[OpenViewController alloc] init];
                 [self.navigationController pushViewController:open animated:NO];
                  self.tabBarController.tabBar.hidden=YES;
            }
            else if(indexPath.item==2)
            {
                TrusteeshipViewController *trus=[[TrusteeshipViewController alloc] init];
                [self.navigationController pushViewController:trus animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }
            else if (indexPath.item==3)
            {
                NSString *aa=@"http://www.skyky.cn";
                NSString *bb=@"快递查询";
                WuYewebViewController *kuaidi=[[WuYewebViewController alloc]initWithCoders:aa Title:bb];
                [self.navigationController pushViewController:kuaidi animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }
            else if (indexPath.item==4)
            {
                if (userinfo.count>0)
                {
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
                }
            }
            else if (indexPath.item==5)
            {
                //物业查询
                WuYeQuectViewController *quect=[[WuYeQuectViewController alloc] init];
                [self.navigationController pushViewController:quect animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }
            else if (indexPath.item==6)
            {
                //物业公告
                GonggaoViewController *gonggao=[[GonggaoViewController alloc] init];
                [self.navigationController pushViewController:gonggao animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }
            else if (indexPath.item==7)
            {
                //热门话题
                ReMenViewController *remen=[[ReMenViewController alloc] init];
                [self.navigationController pushViewController:remen animated:NO];
                self.tabBarController.tabBar.hidden=YES;
            }
            else
            {
                NSLog(@"%@",msg);
                
            }
        }
        else if (indexPath.section==1)
        {
            //互动
        }
        else if (indexPath.section==2)
        {
            //社区活动
        }
        else if (indexPath.section==3)
        {
            SHBKModel *mode=[_saveArray objectAtIndex:indexPath.item];
            //百科
            BaiKeXqViewController *BaiKeXq=[[BaiKeXqViewController alloc] init];
            [self.navigationController pushViewController:BaiKeXq animated:NO];
            BaiKeXq.mid=mode.id;
            self.tabBarController.tabBar.hidden=YES;//隐藏tabbar
        }

    } else {
        NSLog(@"00000");
        [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
    }
    
   //
}
#pragma 三个更多按钮
-(void)wyBtnClick:(UIButton *)btn
{
    if (sh==1)
    {
        if (btn.tag==1000) {
            NSLog(@"1000");
            
            BaiKeViewController *BaiKeXq=[[BaiKeViewController alloc] init];
            [self.navigationController pushViewController:BaiKeXq animated:NO];
            self.tabBarController.tabBar.hidden=YES;//隐藏tabbar
        }
        else if (btn.tag==1001)
        {
//            wyTuiJieViewController *wytj=[[wyTuiJieViewController alloc] init];
//            [self.navigationController pushViewController:wytj animated:NO];
        }
        else if (btn.tag==1002)
        {
            //物业处理公示
//            TreatViewController *treat=[[TreatViewController alloc] init];
//            [self.navigationController pushViewController:treat animated:NO];
//            self.tabBarController.tabBar.hidden=YES;//隐藏tabbar
        }else if (btn.tag==202)
        {
            NSLog(@"发帖");
            FaTieViewController *FaTie=[[FaTieViewController alloc] init];
            [self.navigationController pushViewController:FaTie animated:NO];
            self.tabBarController.tabBar.hidden=YES;//隐藏tabbar
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"您没有绑定小区"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//第一个滚动视图
- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/2) delegate:self placeholderImage:[UIImage imageNamed:@"默认图片"]];
        _topPhotoBoworr.boworrWidth = Screen_Width - 30;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 30;
        _topPhotoBoworr.imageURLStringsGroup = _imageUrlArray;
        _topPhotoBoworr.titlesGroup =_titleArray;
    }
    return _topPhotoBoworr;
}
-(void)baike{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=ModnewpostsType&TVInfoId=%@&Key=%@",URL,aatvinfo,aakey];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
//        NSLog(@"data==%@",data);
        NSArray *neiArray=[data objectForKey:@"Data"];
        for (int i=0; i<neiArray.count; i++) {
            //            NSLog(@"%@",);
            [_titleArray addObject:[[neiArray objectAtIndex:i] valueForKey:@"type"]];
        }
        NSLog(@"titleArray=%@",_titleArray);
        if (_titleArray.count>0) {
            [self shbaike:@"0"];
            [cbhead setUpTitleArray:_titleArray titleColor:[UIColor blackColor] titleSelectedColor:RGBColor(65, 140, 12) titleFontSize:0];
//            [cbhead setUpTitleArray:_titleArray titleColor:[UIColor blackColor] titleSelectedColor:RGBColor(65, 140, 12) titleFontSize:0];
//            [homec reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
//生活百科
-(void)shbaike:(NSString *)sender
{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=alllist&TVInfoId=%@&Key=%@&DeptId=%@&Page=1&PageSize=10&typeid=%@",URL,aatvinfo,aakey,aadeptid,sender];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"%@",data);
        _saveArray=[SHBKModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"Data"]];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:3];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:3];
        [homec reloadSections:indexSet];
//        [homec reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//        [homec reloadItemsAtIndexPaths:indexSet];
//        [homec reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
@end
