//
//  BaoXiuViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BaoXiuViewController.h"
#import "PchHeader.h"
#import "ButtonCollectionViewCell.h"

//#import "XiuViewController.h"
#import "LeiXingModel.h"
@interface BaoXiuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *classArray;
    UICollectionView *homec;
    NSMutableArray *tijiao;
    NSString *myStr;
    
    NSMutableDictionary *userinfo;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aaid;
}
@end

@implementation BaoXiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tijiao=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0]objectForKey:@"id"];
    
    self.navigationItem.title=@"故障报修";
    tijiao =[[NSMutableArray alloc] initWithCapacity:0];
    [self myCollect];
    [self ShuJu];
}
-(void)ShuJu
{
    NSLog(@"%@---%@",aatvinfo,aakey);
    [[WebClient sharedClient] LeiXin:aatvinfo Keys:aakey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@",resultObject);
        classArray=[[NSMutableArray alloc]initWithArray:[LeiXingModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        [homec reloadData];
    }];
}
-(void)myCollect{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.初始化collectionView
    homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-108) collectionViewLayout:layout];
    [self.view addSubview:homec];
    homec.backgroundColor = [UIColor clearColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [homec registerClass:[ButtonCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
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
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (classArray.count>0) {
        return classArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ButtonCollectionViewCell *cell = (ButtonCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    LeiXingModel *mode=[classArray objectAtIndex:indexPath.item];
    NSLog(@"%@",mode.type);
    if (mode.isCheck==NO) {
        [cell.duoButton setTitle:mode.type forState:UIControlStateNormal];
        [cell.duoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //cell.duoButton.enabled=NO;
        cell.duoButton.tintColor=[UIColor clearColor];
        [cell.duoButton.layer setMasksToBounds:YES];
        [cell.duoButton.layer setCornerRadius:15]; //设置矩形四个圆角半径
        cell.duoButton.hidden=YES;
        cell.titLable.text=mode.type;
        cell.titLable.textColor=[UIColor blackColor];
        cell.titImage.backgroundColor=[UIColor whiteColor];
        //cell.titImage.hidden=YES;
        //边框宽度
        [cell.duoButton.layer setBorderWidth:1.0];
        cell.duoButton.layer.borderColor=[UIColor blackColor].CGColor;
    }else if(mode.isCheck==YES){
        [cell.duoButton setTitle:mode.type forState:UIControlStateNormal];
        [cell.duoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //cell.duoButton.enabled=NO;
        cell.duoButton.tintColor=[UIColor clearColor];
        [cell.duoButton.layer setMasksToBounds:YES];
        [cell.duoButton.layer setCornerRadius:15]; //设置矩形四个圆角半径
        cell.duoButton.hidden=YES;
        cell.titLable.text=mode.type;
        cell.titLable.textColor=[UIColor whiteColor];
        cell.titImage.backgroundColor=[UIColor orangeColor];
        //cell.titImage.hidden=YES;
        //边框宽度
        [cell.duoButton.layer setBorderWidth:1.0];
        cell.duoButton.layer.borderColor=[UIColor orangeColor].CGColor;
    }
    return cell;
}
-(void)choose
{
    myStr=@"";
    for (int i=0; i<classArray.count; i++) {
        LeiXingModel *mode=[classArray objectAtIndex:i];
        if (mode.isCheck==YES) {
            NSString *ss=[NSString stringWithFormat:@"%@,",mode.id];
                myStr = [myStr stringByAppendingFormat:@"%@",ss];
        }
    }
    NSLog(@"str=%@",myStr);
      NSString *yong=[NSString stringWithFormat:@"lxid=%@",myStr];
   // NSLog(@"%@--%@--%@--%@",aatvinfo,aakey,aaid,yong);
    if (myStr.length>0) {
        [[WebClient sharedClient] TJyijian:aatvinfo Keys:aakey MyId:aaid Lxid:yong ResponseBlock:^(id resultObject, NSError *error) {
            NSLog(@"结果：%@",resultObject);
            NSString *ss=[resultObject objectForKey:@"Status"];
            int aa=[ss intValue];
            if (aa==1) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                [SVProgressHUD showErrorWithStatus:@"提交失败"];
            }
            
        }];
    }else
    {
        [SVProgressHUD showErrorWithStatus:@"请选择报修类型"];
    }
    
    NSLog(@"str=%@",yong);
    NSLog(@"一键提交报修");

}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float with = (self.view.bounds.size.width-90) / 2;

    return CGSizeMake(with, 40);
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    return CGSizeMake(Screen_Width, 80);
    
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上左下右
    return UIEdgeInsetsMake(5, 20, 5, 20);
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor grayColor];
        return headerView;
    }
    else
    {
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
        
        UIButton *TijiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        TijiaoButton.frame = CGRectMake((Screen_Width-80)/2, 20, 80, 80);
        [TijiaoButton setTitle:@"一键报修" forState:UIControlStateNormal];
        [TijiaoButton setFont:[UIFont systemFontOfSize:15.0f]];
        [TijiaoButton setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
        [TijiaoButton.layer setMasksToBounds:YES];
        [TijiaoButton.layer setCornerRadius:5.0];
        TijiaoButton.tag=120;
        [TijiaoButton addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:TijiaoButton];
        footerView.backgroundColor = [UIColor clearColor];
        return footerView;
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    LeiXingModel *mode=[classArray objectAtIndex:indexPath.item];
//    NSLog(@"type=%@----id=",mode.type,mode.id);
    LeiXingModel *modle=classArray[indexPath.item];
    if (modle.isCheck==YES) {
        modle.isCheck=NO;
    }else{
        modle.isCheck=YES;
    }
    [homec reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
