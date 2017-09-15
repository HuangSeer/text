//
//  GuideViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/8.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "GuideViewController.h"
#import "PchHeader.h"
#import "MyCollectionViewCell.h"
#import "NextGuideViewController.h" //办事只指南下一级
#import "zhiNanModel.h"
#import "SDWebImage/SDImageCache.h"
#import "UIImageView+WebCache.h"
@interface GuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *ClassArray;
    NSArray *classImageArray;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    
    NSMutableArray *_zhiNanArray;
    
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    UICollectionView *homec;
}

@end

@implementation GuideViewController
-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    //办事指南
    [super viewDidLoad];
    oneArray =[NSMutableArray arrayWithCapacity:0];
    twoArray =[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    
    [self daohangView];
    [self myCollect];
    [self getaf];
}
-(void)daohangView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title=@"办事指南";
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
-(void)getaf
{
    // 1 封装会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2 拼接请求参数DeptId=851&TVInfoId=19
    NSString *dict =[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=bszls&Tvinfoid=%@&Key=%@&DeptId=%@",URL, tvinfoId,key,deptid];
    NSLog(@"dict====%@",dict);
    [manager GET:dict parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"请求成功:%@", responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"请求成功:%@", responseJSON);
        _zhiNanArray = [[NSMutableArray alloc] initWithArray:[zhiNanModel mj_objectArrayWithKeyValuesArray:[responseJSON objectForKey:@"Data"]]];
        for (int i=0; i<_zhiNanArray.count; i++) {
            zhiNanModel *mode=[_zhiNanArray objectAtIndex:i];
            //NSLog(@"%@",[_zhiNanArray objectAtIndex:i]);
           // NSLog(@"diyi=%@",mode.pic);
            if ([mode.pid isEqualToString:@"1"]) {
              //  NSLog(@"111111111%@",mode.pic);
                [oneArray addObject:mode];
            }else if([mode.pid isEqualToString:@"2"])
            {
               // NSLog(@"2222222222%@",mode.pic);
                [twoArray addObject:mode];
            }
        }
        if (oneArray.count>0) {
            [homec reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error);
    }];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
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
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return oneArray.count;
    }
    else if(section==1)
    {
        return twoArray.count;
    }
    else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        zhiNanModel *mode=[oneArray objectAtIndex:indexPath.item];
        NSString *ss=[NSString stringWithFormat:@"%@%@",URL,mode.pic];
        
        NSLog(@"ss=%@",ss);
        NSURL *URLs = [NSURL URLWithString:ss];
        
        [cell.topImage sd_setImageWithURL:URLs placeholderImage:[UIImage imageNamed:@"navvar.png"]];
        cell.botlabel.text=mode.category;
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }
    else if (indexPath.section==1)
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        zhiNanModel *mode=[twoArray objectAtIndex:indexPath.item];
        NSString *ss=[NSString stringWithFormat:@"%@%@",URL,mode.pic];
        NSLog(@"ss=%@",ss);
        NSURL *URLs = [NSURL URLWithString:ss];
        
        [cell.topImage sd_setImageWithURL:URLs placeholderImage:[UIImage imageNamed:@"navvar.png"]];
        cell.botlabel.text=mode.category;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        
        cell.topImage.image=[UIImage imageNamed:[classImageArray objectAtIndex:indexPath.item]];
        cell.botlabel.text=[NSString stringWithFormat:@"%@",[ClassArray objectAtIndex:indexPath.item]];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
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
        return CGSizeMake(with, with+20);
    }
    else
    {
        return CGSizeMake(with, with+20);
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
        return CGSizeMake(Screen_Width, 10);
    }
    else
    {
        return CGSizeMake(Screen_Width, 10);
    }
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //if (section == 0) {
    return CGSizeMake(Screen_Width, 35);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 29)];
            zclable.textColor=[UIColor orangeColor];
            zclable.text=@"群众办事";
            [headerView addSubview:zclable];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor grayColor];
            return footerView;
        }
        
    }
    else// if (indexPath.section==1)
    {
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
            for (UIView *view in headerView.subviews) {
                [view removeFromSuperview];
            }
            UILabel *zclable=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 29)];
            zclable.textColor=[UIColor orangeColor];
            zclable.text=@"企业办事";
            [headerView addSubview:zclable];
            headerView.backgroundColor = [UIColor whiteColor];
            
            return headerView;
        }
        else
        {
            UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
            footerView.backgroundColor = [UIColor clearColor];
            return footerView;
        }
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        zhiNanModel *model=[oneArray objectAtIndex:indexPath.item];
        NSLog(@"item  id=%@",model.id);
        NextGuideViewController *next=[[NextGuideViewController alloc] initWithCoderNext:model.id Title:model.category];
        [self.navigationController pushViewController:next animated:NO];
    }
    else {
        zhiNanModel *model=[twoArray objectAtIndex:indexPath.item];
        NSLog(@"item  id=%@",model.id);
        NextGuideViewController *next=[[NextGuideViewController alloc] initWithCoderNext:model.id Title:model.category];
        [self.navigationController pushViewController:next animated:NO];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
