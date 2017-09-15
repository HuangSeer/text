//
//  TreatViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/27.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TreatViewController.h"
#import "PchHeader.h"
#import "TrendCollectionViewCell.h"
#import "WuYeCollectionViewCell.h"
#import "ReMenModel.h"
#import "YiCollectionReusableView.h"
#import "XQTreatViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
@interface TreatViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_saveArray;
 
    YiCollectionReusableView *headerView;
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSString *aadeid;
    
    UITextField *textName;
    UITextField *textIphone;
    UICollectionView *homec;
}
@property (nonatomic, assign) NSInteger currentPage;  //当前页

@end

@implementation TreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _saveArray=[NSMutableArray arrayWithCapacity:0];
 
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    aadeid=[[arry objectAtIndex:0] objectForKey:@"Deptid"];
    [self initView];
    [self SearchView];
}
-(void)SearchView
{
    UIView *sView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 80)];
    sView.backgroundColor=[UIColor blueColor];
    [self.view addSubview:sView];
    textName=[[UITextField alloc] initWithFrame:CGRectMake(10, 8, Screen_Width-100, 30)];
    textName.placeholder=@" 请输入姓名";
    textName.layer.cornerRadius=2;
    textName.font=[UIFont systemFontOfSize:14.0f];
    textName.backgroundColor=[UIColor whiteColor];
    [sView addSubview:textName];
    
    textIphone=[[UITextField alloc] initWithFrame:CGRectMake(10, 42, Screen_Width-100, 30)];
    textIphone.placeholder=@" 请输入手机号";
    textIphone.font=[UIFont systemFontOfSize:14.0f];
    textIphone.layer.cornerRadius=2;
    textIphone.backgroundColor=[UIColor whiteColor];
    [sView addSubview:textIphone];
    

    UIButton *SearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SearchBtn.frame = CGRectMake(Screen_Width-80, 22, 70, 35);
    [SearchBtn setImage:[UIImage imageNamed:@"serch.png"] forState:UIControlStateNormal];
    [SearchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [SearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SearchBtn.backgroundColor = [UIColor orangeColor];
    [SearchBtn addTarget:self action:@selector(SearchClick) forControlEvents:UIControlEventTouchUpInside];
    SearchBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    SearchBtn.layer.cornerRadius=3;
    [sView addSubview:SearchBtn];
    [self setupRefresh];
}
-(void)SearchClick
{
//    [_saveArray removeAllObjects];
    NSString *str=[NSString stringWithFormat:@"%@",textIphone.text];
      NSString *str2=[NSString stringWithFormat:@"%@",textName.text];
    
        NSString *strpage=[NSString stringWithFormat:@"%ld",self.currentPage];
    [[WebClient sharedClient] Gongshi:aatvinfo Keys:aakey DptId:aadeid MobileNo:str UserName:str2 pages:@"10" Page:strpage ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        NSArray *tempArray=[ReMenModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]];
        if (self.currentPage==1) {
            [_saveArray removeAllObjects];
        }
        [_saveArray addObjectsFromArray:tempArray];
        [homec reloadData];
    }];
    
}
-(void)initView
{
    self.navigationItem.title=@"物业公示";
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, Screen_Width, self.view.bounds.size.height-80) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[WuYeCollectionViewCell class] forCellWithReuseIdentifier:@"wuyeId"];

    [homec registerClass:[YiCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
    //设置footView的尺寸大小
    layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
    
    //4.设置代理
    homec.delegate = self;
    homec.dataSource = self;

}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _saveArray.count;
}
//item 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WuYeCollectionViewCell *cell=(WuYeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"wuyeId" forIndexPath:indexPath];
    ReMenModel *mode=[_saveArray objectAtIndex:indexPath.item];
   cell.imagtix.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",mode.OpinionClassName]];
  
    cell.alable.text = [NSString stringWithFormat:@"%@",mode.title];
    if ([mode.AuditName containsString:@"已办理"]) {
        cell.blable.backgroundColor=RGBColor(77, 196, 165);
    }else{
    
     cell.blable.backgroundColor=[UIColor redColor];
    }
    cell.blable.text=[NSString stringWithFormat:@"%@",mode.AuditName ];
    cell.clable.text=[NSString stringWithFormat:@"受理编号:%@",mode.OpinionId];
    cell.dlable.text=[NSString stringWithFormat:@"诉求时间:%@",mode.EditDate];
    cell.elable.text=[NSString stringWithFormat:@"办结时间:%@",mode.ReDate];
    cell.backgroundColor=RGBColor(236, 236, 236);
    return cell;
    
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(Screen_Width, 120);
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    return CGSizeMake(Screen_Width, 0.0001);
    
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 0.0001);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]==YES)
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"diyiView" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor redColor];
        headerView.yiLable.hidden=YES;
        headerView.yiButton.hidden=YES;
        headerView.xianView.hidden=YES;
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
    else
    {
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor grayColor];
        return footerView;
    }
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WuYeCollectionViewCell *cell=(WuYeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.alable.text);
    ReMenModel *mode=[_saveArray objectAtIndex:indexPath.item];
    NSString *xqId=[NSString stringWithFormat:@"%@",mode.OpinionId];
    XQTreatViewController *xqt=[[XQTreatViewController alloc] initWithId:xqId];
[self.navigationController pushViewController:xqt animated:NO];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.currentPage=1;
    // 1.数据操作
    [self SearchClick];
    
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
    [self SearchClick];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [homec reloadData];
        //
        //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [homec.mj_footer endRefreshing];
    });
}



/**
 *  集成刷新控件
 */
-(void)setupRefresh{
    homec.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
         homec.mj_footer.hidden = YES;
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
