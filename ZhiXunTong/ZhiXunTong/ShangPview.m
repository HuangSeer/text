//
//  ShangPview.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/7.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "ShangPview.h"
#import "PchHeader.h"
#import "SpXqViewController.h"
#import "ViewCollectionViewCell.h"
#import "ViewModel.h"
#import "PPNumberButton.h"
@interface ShangPview()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PPNumberButtonDelegate>{
    UICollectionView *homec;
    NSArray *cellArray;
    NSArray *cellArray2;
    NSArray *cellArray3;
  
   
    
    //声明一个全局变量判断选中的按钮
    UIButton *selectedBtn;
    //声明一个全局变量判断选中的按钮
    UIButton *selectedBtn2;
    //声明一个全局变量判断选中的按钮
    UIButton *selectedBtn3;
}
@end
@implementation ShangPview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *viwqz=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
        viwqz.backgroundColor=[UIColor orangeColor];
        UILabel *labbt=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40 )];
        labbt.text=@"请选择规格";
        labbt.textAlignment = UITextAlignmentCenter;
        labbt.textColor=[UIColor whiteColor];
        [viwqz addSubview:labbt];
        _butsure=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/3, self.frame.size.height-40, Screen_Width/3, 35)];
        _butsure.backgroundColor=[UIColor orangeColor];
        [_butsure.layer setMasksToBounds:YES];
        [_butsure.layer setCornerRadius:5]; //设置矩圆角半径
        [_butsure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_butsure setTitle:@"确定" forState:UIControlStateNormal];

       
        [self addSubview:_butsure];
    
        [self addSubview:viwqz];
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //2.初始化collectionView
        homec = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-80) collectionViewLayout:layout];
        [self addSubview:homec];
        homec.backgroundColor = [UIColor clearColor];
          [homec registerNib:[UINib nibWithNibName:NSStringFromClass([ViewCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellId"];
//         [homec registerClass:[ViewCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 20);
        [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        //设置footView的尺寸大小
        [homec registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview"];
        layout.footerReferenceSize=CGSizeMake(Screen_Width,0.001);
        
        //4.设置代理
        homec.delegate = self;
        homec.dataSource = self;
    
        
    }
  
    return self;
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    if (_moarray.count==1) {
        cellArray=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[0] valueForKey:@"aproperty"]];
      
    }else if(_moarray.count==2){
        cellArray=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[0] valueForKey:@"aproperty"]];
        cellArray2=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[1] valueForKey:@"aproperty"]];
    
    }else{
    
        cellArray=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[0] valueForKey:@"aproperty"]];
        cellArray2=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[1] valueForKey:@"aproperty"]];
          cellArray3=[ViewModel mj_objectArrayWithKeyValuesArray:[_moarray[2] valueForKey:@"aproperty"]];
    }

    return _moarray.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
         NSLog(@"bababab===================%ld",cellArray.count);
        return cellArray.count;
    }
    else  if(section==1){
       return cellArray2.count;
    }else{
      return cellArray3.count;
    
    }

}
//collectionView itme内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        ViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        NSLog(@"bababab===================%@",cellArray);
          cell.ViewMo = cellArray[indexPath.row];
         cell.butlab.tag=indexPath.row;
        
        if (cell.butlab.tag==0) {
             [cell.butlab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           [cell.butlab setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
            selectedBtn=cell.butlab;
             _stridone=[NSString stringWithFormat:@"%@",cell.ViewMo.property_id];
             _strid1=[NSString stringWithFormat:@"%@",cell.ViewMo.property_value];
            NSLog(@"bababab===================%@",_stridone);
        }else{
          
            [cell.butlab setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
           
        }
//         __weak typeof(self) weakSelf = self;
        cell.addToBlock = ^(ViewCollectionViewCell *cell) {
            [self myFavoriteCellAddTo:cell];
        };
        return cell;
    }else  if(indexPath.section==1){
    
          ViewCollectionViewCell *cellb= [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cellb.ViewMo = cellArray2[indexPath.row];
        cellb.butlab.tag=indexPath.row;
        if (cellb.butlab.tag==0) {
            [cellb.butlab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cellb.butlab setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
            selectedBtn2=cellb.butlab;
            _stridtwo=[NSString stringWithFormat:@"%@",cellb.ViewMo.property_id];
             _strid2=[NSString stringWithFormat:@"%@",cellb.ViewMo.property_value];
            NSLog(@"bababab===================%@",_stridtwo);
        }else{
           
            [cellb.butlab setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
        }
        cellb.addToBlock = ^(ViewCollectionViewCell *cellb) {
            [self myFavoriteCellAddToacdddsad:cellb];
        };
     
        return cellb;
    }else{
        ViewCollectionViewCell *cellc = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

        cellc.addToBlock = ^(ViewCollectionViewCell *cellc) {
            [self myFavoriteCellAddToacbababa:cellc];
        };
        cellc.ViewMo = cellArray3[indexPath.row];
         cellc.butlab.tag=indexPath.row;
        if (cellc.butlab.tag==0) {
            [cellc.butlab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cellc.butlab setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
            selectedBtn3=cellc.butlab;
            _stridthree=[NSString stringWithFormat:@"%@",cellc.ViewMo.property_id];
             _strid3=[NSString stringWithFormat:@"%@",cellc.ViewMo.property_value];
            NSLog(@"bababab===================%@",_stridthree);
        }else{

            [cellc.butlab setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
        }
        return cellc;
    
    }
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section==0)
    {
        return CGSizeMake(100,30);
    }
    else if(indexPath.section==1)
    {
       return CGSizeMake(100,30);
    }else{
      return CGSizeMake(100,30);
    }
}
//footer的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 0.001);
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(Screen_Width, 20);
    }

    else {
        return CGSizeMake(Screen_Width, 20);
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // 上 左 下 右
    if (section==0) {
        return UIEdgeInsetsMake(10, 30, 10, 30);
    }
    else
    {
         return UIEdgeInsetsMake(10, 30, 10, 30);
    }
    
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    #pragma mark ----- 重用的问题
    NSArray *array=[_moarray valueForKey:@"spec_name"];
    NSLog(@"===========%@",array);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]==YES)
    {
         UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
        if (indexPath.section ==0) {
            UILabel *labelOne=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.frame.size.width, headerView.frame.size.height)];
            labelOne.text =[NSString stringWithFormat:@"%@",array[0]];
            labelOne.font = [UIFont systemFontOfSize:14.0f];
            labelOne.textColor =[UIColor blackColor];
            [headerView addSubview:labelOne];
        }else if (indexPath.section ==1){
        UILabel *labelTwo=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.frame.size.width, headerView.frame.size.height)];
            labelTwo.text =[NSString stringWithFormat:@"%@",array[1]];
            labelTwo.font = [UIFont systemFontOfSize:14.0f];
            labelTwo.textColor =[UIColor blackColor];
            [headerView addSubview:labelTwo];
        }else{
        
            UILabel *labelThree=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.frame.size.width, headerView.frame.size.height)];
            labelThree.text =[NSString stringWithFormat:@"%@",array[2]];
            labelThree.font = [UIFont systemFontOfSize:14.0f];
            labelThree.textColor =[UIColor blackColor];
            [headerView addSubview:labelThree];
        }
        
        return headerView;
    }
    else
    {
          UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"defautleFootview" forIndexPath:indexPath];
        
        return footerView;
    }
}
- (void)myFavoriteCellAddTo:(ViewCollectionViewCell *)cell{
      NSLog(@"%@",cell.ViewMo.property_id);
    _stridone=[NSString stringWithFormat:@"%@",cell.ViewMo.property_id];
     _strid1=[NSString stringWithFormat:@"%@",cell.ViewMo.property_value];

    //选中变红色 其他按钮变为白色
    if (selectedBtn) {
        [selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    selectedBtn = cell.butlab;
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
    [selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
}
- (void)myFavoriteCellAddToacdddsad:(ViewCollectionViewCell *)cellb{
    NSLog(@"%@",cellb.ViewMo.property_id);
 _stridtwo=[NSString stringWithFormat:@"%@",cellb.ViewMo.property_id];
    _strid2=[NSString stringWithFormat:@"%@",cellb.ViewMo.property_value];
    //选中变红色 其他按钮变为白色
    if (selectedBtn2) {
        [selectedBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectedBtn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    selectedBtn2 = cellb.butlab;
    [selectedBtn2 setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
   [selectedBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
}
- (void)myFavoriteCellAddToacbababa:(ViewCollectionViewCell *)cellc{
    NSLog(@"%@",cellc.ViewMo.property_id);
    _stridthree=[NSString stringWithFormat:@"%@",cellc.ViewMo.property_id];
    _strid3=[NSString stringWithFormat:@"%@",cellc.ViewMo.property_value];
    //选中变红色 其他按钮变为白色
    if (selectedBtn3) {
        [selectedBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectedBtn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    }
    selectedBtn3 = cellc.butlab;
    [selectedBtn3 setBackgroundImage:[UIImage imageNamed:@"but"] forState:UIControlStateNormal];
    [selectedBtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
