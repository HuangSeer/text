//
//  DangXiaoViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/3.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DangXiaoViewController.h"
#import "PchHeader.h"
#import "SDCycleScrollView.h"
#import "MyCollectionViewCell.h"
#import "HomeTypeCell.h"
#import "PublicCell.h"
#import "lunBoModel.h"
#import "JYScrollView.h"
#import "ShiPingViewController.h"
#import "webViewController.h"
#import "ZSDangXiaoViewController.h"
#import "DangXiaoMode.h"
@interface DangXiaoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>{
    UICollectionView *homec;
    NSMutableArray *_saveArray;
    UIView *meView;
    
    NSArray *ClassArray;
    NSArray *classImageArray;
    UIButton *button;
    
    NSMutableArray *imgUrlArray;
    NSMutableArray *titleUrlArray;
    NSMutableArray *_LunBoArray;
    NSString *akey;
    NSString *apeid;
    NSString *atvinfo;
    
    NSMutableArray *zxArray;
    NSMutableArray *zsArray;
    NSMutableArray *xxArray;
    NSMutableArray *dtArray;
}
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworrd;
@property (nonatomic, strong) JYScrollView * jyScrollView;

@end

@implementation DangXiaoViewController

-(id)initDangQun:(NSMutableArray *)imgArray Serve:(NSMutableArray *)titleArray
{
    if ((self=[super self])) {
//        imgUrlArray=imgArray;
//        titleUrlArray=titleArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",imgUrlArray);
    ClassArray = @[@"党校动态",@"理论学习",@"基础知识",@"共产党员网"];
    classImageArray=@[@"zsdx_dxdt.png",@"zsdx_llxx.png",@"zsdx_jczs.png",@"zsdx_zggcdw.png"];
    imgUrlArray=[NSMutableArray arrayWithCapacity:0];
    titleUrlArray=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    akey=[userDefaults objectForKey:Key];
    apeid=[userDefaults objectForKey:DeptId];
    atvinfo=[userDefaults objectForKey:TVInfoId];
    [self DaoHang];
    //[self myCollect];
    zxArray=[NSMutableArray arrayWithCapacity:0];
    [self getLunBo];

}
-(void)getLunBo
{
    [[WebClient sharedClient] DangXiao:atvinfo Keys:akey Deptid:apeid ResponseBlock:^(id resultObject, NSError *error) {
        _LunBoArray=[[NSMutableArray alloc]initWithArray:[lunBoModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        for (int i=0; i<_LunBoArray.count; i++) {
            lunBoModel *model=[_LunBoArray objectAtIndex:i];
            NSLog(@"%@-%@",model.ImageIndex,model.Title);
            NSString *as=[NSString stringWithFormat:@"%@%@",URL,model.ImageIndex];
            [imgUrlArray addObject:as];
            [titleUrlArray addObject:model.Title];
        }
        NSLog(@"%ld",_LunBoArray.count);
        if (imgUrlArray.count>0 && titleUrlArray.count>0) {
            //[homec reloadData];
            
        }
        [self getShuju:@"2" qubie:@"zhongxing"];
        
    }];
}
-(void)getShuju:(NSString *)sid qubie:(NSString *)qb
{
   // NSString *sid=@"2";
    [[WebClient sharedClient] ZSDangXiao:atvinfo Keys:akey Deptid:apeid Sid:sid ResponseBlock:^(id resultObject, NSError *error) {
        
        
        if ([qb isEqualToString:@"zhongxing"]) {//第一次的默认数据
            zxArray = [[NSMutableArray alloc] initWithArray:[DangXiaoMode mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
            NSLog(@"zxArray=%@",zxArray);
           // if (zxArray.count>0) {
             //   [homec reloadData];
                [self myCollect];
            //}
        }
        else if ([qb isEqualToString:@"xuexi"])
        {//理论学习
            xxArray = [[NSMutableArray alloc] initWithArray:[DangXiaoMode mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
            if (xxArray.count>0) {
                ZSDangXiaoViewController *zsdx=[[ZSDangXiaoViewController alloc] initWithZS:xxArray Title:@"理论学习"];
                [self.navigationController pushViewController:zsdx animated:NO];
                NSLog(@"xuexi");
                NSLog(@"%@",resultObject);
            }else{
                [SVProgressHUD showErrorWithStatus:@"没有数据"];
            }
        }
        else if ([qb isEqualToString:@"dongtai"])
        {
            dtArray = [[NSMutableArray alloc] initWithArray:[DangXiaoMode mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
            NSLog(@"dtarrat=%@",dtArray);
            if (dtArray.count>0) {
                
                ZSDangXiaoViewController *zsdx=[[ZSDangXiaoViewController alloc] initWithZS:dtArray Title:@"党校动态"];
                [self.navigationController pushViewController:zsdx animated:NO];
                NSLog(@"dongtai");
                NSLog(@"dongtai=%@",resultObject);
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"没有数据"];
            }
        }
        else if ([qb isEqualToString:@"zhishi"])
        {
            zsArray = [[NSMutableArray alloc] initWithArray:[DangXiaoMode mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
            if (zsArray.count>0) {
                ZSDangXiaoViewController *zsdx=[[ZSDangXiaoViewController alloc] initWithZS:zsArray Title:@"基础知识"];
                [self.navigationController pushViewController:zsdx animated:NO];
                NSLog(@"zhishi");
                NSLog(@"zhishi=%@",resultObject);
            }else{
                [SVProgressHUD showErrorWithStatus:@"没有数据"];
            }
        }
    }];
}
-(void)DaoHang
{
    self.navigationItem.title=@"掌上党校";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
-(void)btnCkmore{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.bounds.size.height+50) collectionViewLayout:layout];
    NSLog(@"%@",layout);
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellIds"];
    [homec registerClass:[PublicCell class] forCellWithReuseIdentifier:@"syIds"];
    [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, Screen_Width/2);
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
    return  2;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    else if(section==1)
    {
        return zxArray.count;
    }
    else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIds" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[ClassArray objectAtIndex:indexPath.item]];
        cell.botlabel.frame=CGRectMake(-5, cell.topImage.frame.size.height, (Screen_Width-100) / 4+10, 25);
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else if(indexPath.section==1)
    {
        PublicCell *cell=(PublicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"syIds" forIndexPath:indexPath];
        NSLog(@"zxArray=%@",zxArray);
        DangXiaoMode *model=[zxArray objectAtIndex:indexPath.item];
        
        cell.publicName.text=[NSString stringWithFormat:@"%@",model.title];
        cell.publicName.frame=CGRectMake(110, 20, Screen_Width-120, 30);
        cell.publicName.numberOfLines=3;
        cell.publicImage.frame=CGRectMake(5, 0, 100, 90);
      [cell.publicImage setImage:[UIImage imageNamed:@"默认图片"]];
        return cell;
    }
    PublicCell *cell=(PublicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"syIds" forIndexPath:indexPath];
    return cell;
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
    else
    {
        return CGSizeMake(Screen_Width, 0);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0)
    {
        return CGSizeMake(Screen_Width, 10);
    }else if (section==1)
    {
        return CGSizeMake(Screen_Width, 0.01);
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
        return CGSizeMake(Screen_Width, 28);
    }
    else {
        return CGSizeMake(0, 0);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return UIEdgeInsetsMake(8, 10, 10, 10);
    }
    else if (section==1)
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            if (!_jyScrollView) {
                _jyScrollView = [[JYScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,Screen_Width / 2+10 )];
                [_jyScrollView bannerWithArray:imgUrlArray titleArr:titleUrlArray imageType:JYImageURLType placeHolder:@"默认图片" tapAction:^(NSInteger index) {
                    NSLog(@"点击了轮播图click   NO.%ld",index);
                }];
                _jyScrollView.timeInterval = 4;
                [headerView addSubview:_jyScrollView];
            }
            
            headerView.backgroundColor = [UIColor greenColor];
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor=RGBColor(236, 236, 236);
            return footerView;
        }
    }
    else if (indexPath.section==1)
    {
        
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 29)];
            zclable.textColor=[UIColor orangeColor];
            zclable.text=@"课程中心";
            zclable.font=[UIFont systemFontOfSize:15];
            [headerView addSubview:zclable];
            
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            for (UIView *view in footerView.subviews) {
                [view removeFromSuperview];
            }
            footerView.backgroundColor = RGBColor(236, 236, 236);
            
            return footerView;
        }
    }
    else
    {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            headerView.backgroundColor = RGBColor(236, 236, 236);
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = RGBColor(236, 236, 236);
            return footerView;
        }
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            NSLog(@"党校动态");
           [self getShuju:@"1" qubie:@"dongtai"];
        }
        else if (indexPath.item==1)
        {
            NSLog(@"理论学习");
            [self getShuju:@"3" qubie:@"xuexi"];
        }
        else if (indexPath.item==2)
        {
            NSLog(@"基础知识");
            [self getShuju:@"4" qubie:@"zhishi"];
        }
        else if (indexPath.item==3)
        {
             NSLog(@"共产党员网");
            //NSString *weburl=[NSString stringWithFormat:@"%@/api/Html/pion.html?method=home&Tvinfoid=%@&Key=%@&DeptId=%@&sid=1",URL,atvinfo,akey,apeid];
            NSString *weburl=@"http://xuexi.12371.cn/";
            NSLog(@"weburl=%@",weburl);
            NSString *aa=@"共产党员网";
            // NSString *aa=[NSString stringWithFormat:@"%@",mode.Title];
            webViewController *web=[[webViewController alloc] initWithCoderZW:weburl Title:aa];
            [self.navigationController pushViewController:web animated:NO];
        }
    }else if (indexPath.section==1)
    {
//        ShiPingViewController *ship=[[ShiPingViewController alloc] init];
//        [self.navigationController pushViewController:ship animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
