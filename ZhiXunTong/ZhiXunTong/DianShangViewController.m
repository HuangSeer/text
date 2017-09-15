//
//  DianShangViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/7/28.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DianShangViewController.h"
#import "DianShangHeader.h"
#import "PchHeader.h"
#import "CBHeaderChooseViewScrollView.h"
#import "SDCycleScrollView.h"
#import "DianShangTableViewCell.h"
#import "DianShangModel.h"
#import "FuCell.h"
#import "FujinViewController.h"//附近店铺
#import "JiFenViewController.h"//积分商城
#import "TGViewController.h"//实惠团购
#import "PinPViewController.h"
#import "TieJViewController.h"
#import "TuiJieModel.h"
#import "LZCartViewController.h"
#import "SpXqViewController.h"
#import "LunWebViewController.h"
#import "SearchViewController.h"
@interface DianShangViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>{
    DianShangHeader *meView;
    UITableView *_tableView;
    
    NSArray *classImageArray;
    NSArray *ClassArray;
    UITextField *TextSearch;
    NSArray *LeiXingArray;
    NSMutableArray *TMArray;
    NSMutableArray *myarray;
    NSMutableArray *myIdArray;
    NSMutableArray *LunArray;
    NSMutableArray *LunTitleArray;
    NSMutableArray *LunurlArray;
    CBHeaderChooseViewScrollView *headerView;
    NSInteger y;
    NSMutableDictionary *userinfo;
    NSString *phone;
    NSString *cookiestr;
    NSString *integral;
    NSMutableArray *TJArray;
    NSString *cartGoodsCount;
    UIButton *BtnShu;
}
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;
@end

@implementation DianShangViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBarHidden=YES;//隐藏导航栏
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            integral=[[data objectForKey:@"data"] valueForKey:@"integral"];
            cartGoodsCount=[[data objectForKey:@"data"] objectForKey:@"cartGoodsCount"];
            [BtnShu setTitle:[NSString stringWithFormat:@"%@",cartGoodsCount] forState:UIControlStateNormal];
            NSLog(@"%@==bb==",cartGoodsCount);
            NSString *xstr=[NSString stringWithFormat:@"http://192.168.1.223:8080/shopping/api/thirdPartyLogin.htm?mobileNum=%@",phone];
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
            for (NSHTTPCookie *tempCookie in cookies)
            {
                cookiestr=tempCookie.value;
            }
            [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
            
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }
    if (TMArray.count==0&&LeiXingArray.count==0&&LunArray.count==0) {
        [self CNLove];
        [self PostJson];//菜单数据
        [self LunBoTu];//轮播图数据
           }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    classImageArray=[NSMutableArray arrayWithCapacity:0];
    ClassArray=[NSMutableArray arrayWithCapacity:0];
    myarray=[NSMutableArray arrayWithCapacity:0];
    myIdArray=[NSMutableArray arrayWithCapacity:0];
    LunArray=[NSMutableArray arrayWithCapacity:0];
    LunTitleArray=[NSMutableArray arrayWithCapacity:0];
    
    [self HeaderView];//视图

}
-(void)PostJson
{
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/goods_class_list.htm",DsURL];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
       NSLog(@"%@",data);
        LeiXingArray=[DianShangModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        for (int i=0; i<LeiXingArray.count; i++) {
            DianShangModel *ds=[LeiXingArray objectAtIndex:i];
            NSString *bb=ds.goods_class_name;
            NSString *cc=ds.goods_class_id;
           NSLog(@"bb=%@",cc);
            [myarray addObject:bb];
            [myIdArray addObject:cc];
        }
        if (myIdArray.count>0) {
            [self PostNeiRong:[myIdArray objectAtIndex:0]];
            [headerView setUpTitleArray:myarray titleColor:[UIColor blackColor] titleSelectedColor:RGBColor(65, 140, 12) titleFontSize:0];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)PostNeiRong:(NSString*)notid
{
//    [SVProgressHUD showWithStatus:@"加载中"];
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/index_goods_detail.htm?goodsClassId=%@&pageCurrent=1&pageSize=2",DsURL,notid];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"PostNeiRong===%@",data);
        TMArray=[DianShangModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        NSLog(@"%@",TMArray);
//        if (TMArray.count>0) {
//            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"没有此类商品"];
//        }
        
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)CNLove
{
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/store_reommend_goods.htm?pageSize=10&pageCurrent=1&field=推荐",DsURL];
    NSString *string2 = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZQLNetWork getWithUrlString:string2 success:^(id data) {
        NSLog(@"CNLove=%@",data);
        TJArray=[TuiJieModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"list"]];
        [_tableView reloadData];
    } failure:^(NSError *error)
     {
         NSLog(@"---------------%@",error);
         [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
     }];

}
-(void)LunBoTu{
    NSString *strurl=[NSString stringWithFormat:@"%@/shopping/api/advert_invoke.htm?advertType=1",DsURL];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"LunBoTu=%@",data);
        LunArray =[data valueForKey:@"ad_path"];
        LunTitleArray=[data valueForKey:@"ad_title"];
        LunurlArray=[data valueForKey:@"ad_url"];
        if (LunArray.count>0) {
            [meView addSubview:self.topPhotoBoworr];
            _topPhotoBoworr.imageURLStringsGroup =LunArray ;
            _topPhotoBoworr.titlesGroup = LunTitleArray;
        }else{
            NSLog(@"轮播图没有数据 请求失败");
            _topPhotoBoworr.imageURLStringsGroup =@[@"默认图片"];
            _topPhotoBoworr.titlesGroup = @[@"默认图片"];
        }
        
        [_tableView reloadData];
    } failure:^(NSError *error)
    {
        
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)HeaderView
{
    NSInteger imgWid=(Screen_Width-30)/2;
    NSInteger imgHid=70;
    meView=[DianShangHeader init];
    meView.frame=CGRectMake(0, 0, Screen_Width, Screen_Width / 2+40+imgHid*3+40);
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    meView.GunDongView.frame=CGRectMake(0, 0, Screen_Width, Screen_Width / 2);
    
    meView.ImgView01.frame=CGRectMake(10, Screen_Width / 2+10,imgWid,imgHid);
    meView.ImgView02.frame=CGRectMake(imgWid+20, Screen_Width / 2+10,imgWid,imgHid);
    meView.ImgView03.frame=CGRectMake(10, Screen_Width / 2+20+imgHid,imgWid,imgHid);
    meView.ImgView04.frame=CGRectMake(10, Screen_Width / 2+30+imgHid*2,imgWid,imgHid);
    meView.ImgView05.frame=CGRectMake(imgWid+20, Screen_Width /  2+20+imgHid,imgWid,imgHid*2+10);
    meView.ImgView01.userInteractionEnabled=YES;
    meView.ImgView02.userInteractionEnabled=YES;
    meView.ImgView03.userInteractionEnabled=YES;
    meView.ImgView04.userInteractionEnabled=YES;
    meView.ImgView05.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [meView.ImgView01 addGestureRecognizer:singleTap1];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [meView.ImgView02 addGestureRecognizer:singleTap2];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [meView.ImgView03 addGestureRecognizer:singleTap3];
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [meView.ImgView04 addGestureRecognizer:singleTap4];
    UITapGestureRecognizer *singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [meView.ImgView05 addGestureRecognizer:singleTap5];
    headerView=[[CBHeaderChooseViewScrollView alloc]initWithFrame:CGRectMake(0,Screen_Width / 2+40+imgHid*3, Screen_Width, 40)];
    headerView.btnChooseClickReturn = ^(NSInteger x) {
        NSLog(@"%ld",(long)x);
        y=x;
        //NSLog(@"y=%ld",y);
        NSLog(@"myarray=%@",[myIdArray objectAtIndex:x]);
        [self PostNeiRong:[myIdArray objectAtIndex:x]];
    };
    [meView addSubview:headerView];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
//    UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(40, 10, Screen_Width-100, 30)];
//    aa.backgroundColor=[UIColor clearColor];
//    
//    //设置aa的圆角
//    aa.layer.cornerRadius = 12;
//    aa.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
//    aa.layer.borderWidth = 1;
//    aa.layer.borderColor = [[UIColor whiteColor] CGColor];
//    
//    [self.topPhotoBoworr addSubview:aa];
    
    UIButton *BtnGouWu=[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-50, 8, 36, 32)];
    [BtnGouWu setImage:[UIImage imageNamed:@"gouwuche.png"] forState:UIControlStateNormal];
    [BtnGouWu addTarget:self action:@selector(BtnGouWuChe) forControlEvents:UIControlEventTouchUpInside];
    [self.topPhotoBoworr addSubview:BtnGouWu];
    
     BtnShu=[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-22, 8, 16, 16)];
    [BtnShu setBackgroundImage:[UIImage imageNamed:@"shuliang.png"] forState:UIControlStateNormal];
 
    BtnShu.titleLabel.font=[UIFont systemFontOfSize:11];
    [BtnShu addTarget:self action:@selector(BtnGouWuChe) forControlEvents:UIControlEventTouchUpInside];
    [self.topPhotoBoworr addSubview:BtnShu];
//    
//    TextSearch=[[UITextField alloc] initWithFrame:CGRectMake(10, 2, Screen_Width-140, 26)];
//    TextSearch.placeholder=@"12345678";
//    [aa addSubview:TextSearch];
    UIButton *BtnSearch=[[UIButton alloc] initWithFrame:CGRectMake(5, 8, 30, 27)];
    [BtnSearch setBackgroundImage:[UIImage imageNamed:@"serch.png"] forState:UIControlStateNormal];
    [BtnSearch addTarget:self action:@selector(BtnChaXun) forControlEvents:UIControlEventTouchUpInside];
    [self.topPhotoBoworr addSubview:BtnSearch];
    
    
    [_tableView setTableHeaderView:meView];
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (y==0) {
       return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (y==0) {
        if (section==0) {
            return TJArray.count;
        }
        else if(section==1)
        {
            return TMArray.count;
        }
    }
    else{
         return TMArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (y==0)
    {
        if (indexPath.section==0) {
            if (indexPath.row==0)
            {
                return 290;
            }
            else{
                return 250;
            }
        }
        else if (indexPath.section==1)
        {
            if (indexPath.row==0)
            {
                return 140;
            }
            else{
                return 100;
            }
        }
    }
    return 100;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DianShangTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"DianShangTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    NSLog(@"%ld",TMArray.count);
    
    
    if (y==0)
    {
        if (indexPath.section==0)
        {
            TuiJieModel *tj=[TJArray objectAtIndex:indexPath.row];
            if (indexPath.row==0) {
                UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
                [cell.contentView addSubview:aa];
                UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2-100, 20, 50, 1)];
                xian.backgroundColor=[UIColor grayColor];
                [aa addSubview:xian];
                UIView *xian1=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2+50, 20, 50, 1)];
                xian1.backgroundColor=[UIColor grayColor];
                [aa addSubview:xian1];
                UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
                nameLabel.text=@"推荐特卖";
                nameLabel.font=[UIFont systemFontOfSize:13];
                nameLabel.textColor=RGBColor(65, 141, 42);
                nameLabel.textAlignment=NSTextAlignmentCenter;
                [aa addSubview:nameLabel];
                //cell.backgroundColor=[UIColor whiteColor];
                cell.ds_Bakguder.frame=CGRectMake(0, 40,Screen_Width, 250);
                cell.ds_img.frame=CGRectMake(10, 0, Screen_Width-20, 200);
                cell.ds_title.frame=CGRectMake(10, 200, Screen_Width-100, 25);
                cell.ds_shijia.frame=CGRectMake(10, 225, 60, 25);
                cell.ds_yuanjia.frame=CGRectMake(70, 225, 200, 25);
                [cell.contentView addSubview:cell.ds_Bakguder];
                cell.ds_shijia.text=[NSString stringWithFormat:@"￥%@",tj.store_price];
                cell.ds_yuanjia.text=[NSString stringWithFormat:@"原价 :￥%@",tj.goods_price];
                cell.ds_title.text=[NSString stringWithFormat:@"%@",tj.goods_name];
                
                NSString *str=tj.goods_img;
                [cell.ds_img sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片"]];
                UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(0, 249, Screen_Width, 1)];
                xian2.backgroundColor=[UIColor grayColor];
                [cell.ds_Bakguder addSubview:xian2];
            }
            else
            {
                cell.ds_Bakguder.frame=CGRectMake(0, 0,Screen_Width, 250);
                cell.ds_img.frame=CGRectMake(10, 0, Screen_Width-20, 200);
                cell.ds_shijia.text=[NSString stringWithFormat:@"￥%@",tj.store_price];
                cell.ds_yuanjia.text=[NSString stringWithFormat:@"原价 :￥%@",tj.goods_price];
                cell.ds_title.text=[NSString stringWithFormat:@"%@",tj.goods_name];
                UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, Screen_Width, 1)];
                NSString *str=tj.goods_img;
                [cell.ds_img sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片"]];
                xian2.backgroundColor=[UIColor grayColor];
                [cell.contentView addSubview:xian2];
            }
        }
        else if(indexPath.section==1)
        {
            DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
            if (indexPath.row==0) {
                UIView *aa=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
                [cell.contentView addSubview:aa];
                UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2-100, 20, 50, 1)];
                xian.backgroundColor=[UIColor grayColor];
                [aa addSubview:xian];
                UIView *xian1=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/2+50, 20, 50, 1)];
                xian1.backgroundColor=[UIColor grayColor];
                [aa addSubview:xian1];
                UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
                nameLabel.text=@"猜你喜欢";
                nameLabel.font=[UIFont systemFontOfSize:13];
                nameLabel.textColor=RGBColor(65, 141, 42);
                nameLabel.textAlignment=NSTextAlignmentCenter;
                [aa addSubview:nameLabel];
                //cell.backgroundColor=[UIColor whiteColor];
                DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
                cell.ds_Bakguder.frame=CGRectMake(0, 40,Screen_Width, 100);
                cell.ds_img.frame=CGRectMake(10, 10,80, 80);
                cell.ds_title.frame=CGRectMake(100, 10,Screen_Width-80, 22);
                cell.ds_shijia.frame=CGRectMake(100,60, 60, 22);
                cell.ds_shijia.text=[NSString stringWithFormat:@"￥%@",ds.currentPrice];
                cell.ds_yuanjia.hidden=YES;
                //        cell.ds_yuanjia.text=[NSString stringWithFormat:@"原价 :￥%@",ds.goodsInventory];
                cell.ds_title.text=[NSString stringWithFormat:@"%@",ds.goodsName];
                UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(0, 140-1, Screen_Width, 1)];
                NSString *str=ds.image;
                [cell.ds_img sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片"]];
                xian2.backgroundColor=[UIColor grayColor];
                [cell.contentView addSubview:xian2];
            }
            else
            {
                DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
                cell.ds_Bakguder.frame=CGRectMake(0, 0,Screen_Width, 100);
                cell.ds_img.frame=CGRectMake(10, 10,80, 80);
                cell.ds_title.frame=CGRectMake(100, 10,Screen_Width-80, 22);
                cell.ds_shijia.frame=CGRectMake(100,60, 60, 22);
                cell.ds_shijia.text=[NSString stringWithFormat:@"￥%@",ds.currentPrice];
                cell.ds_yuanjia.hidden=YES;
                //        cell.ds_yuanjia.text=[NSString stringWithFormat:@"原价 :￥%@",ds.goodsInventory];
                cell.ds_title.text=[NSString stringWithFormat:@"%@",ds.goodsName];
                UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(0, 99, Screen_Width, 1)];
                NSString *str=ds.image;
                [cell.ds_img sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片"]];
                xian2.backgroundColor=[UIColor grayColor];
                [cell.contentView addSubview:xian2];
            }
        }
        
    }
    else
    {
        DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
        cell.ds_Bakguder.frame=CGRectMake(0, 0,Screen_Width, 100);
        cell.ds_img.frame=CGRectMake(10, 10,80, 80);
        cell.ds_title.frame=CGRectMake(100, 10,Screen_Width-80, 22);
        cell.ds_shijia.frame=CGRectMake(100,60, 60, 22);
        cell.ds_shijia.text=[NSString stringWithFormat:@"￥%@",ds.currentPrice];
        cell.ds_yuanjia.hidden=YES;
//        cell.ds_yuanjia.text=[NSString stringWithFormat:@"原价 :￥%@",ds.goodsInventory];
        cell.ds_title.text=[NSString stringWithFormat:@"%@",ds.goodsName];
        UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, Screen_Width, 1)];
        NSString *str=ds.image;
        [cell.ds_img sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        xian2.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:xian2];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    return cell;
}
//表格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      SpXqViewController *SpXqVi=[[SpXqViewController alloc] init];
    if (y==0) {
        if (indexPath.section==0)
        {
         TuiJieModel *tj=[TJArray objectAtIndex:indexPath.row];
         SpXqVi.intasid=tj.goods_id;
        }else{
        DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
         SpXqVi.intasid=ds.goodsId;
        
        }
        NSLog(@"oooooooooooö ");
    }else{
        DianShangModel *ds=[TMArray objectAtIndex:indexPath.row];
      
        SpXqVi.intasid=ds.goodsId;
    
    
    }
    [self.navigationController pushViewController:SpXqVi animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  五大分类
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    UIView *viewClicked=[gestureRecognizer view];
    if (viewClicked==meView.ImgView01) {
        NSLog(@"积分商城");
//        if (userinfo.count>0) {
//            NSString *strurlphone=[NSString stringWithFormat:@"%@/shopping/api/thirdPartyLogin.htm?mobileNum=%@",DsURL,phone];
//            NSLog(@"%@",strurlphone);
//            [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
//                NSLog(@"%@==bb==",data);
//                integral=[[data objectForKey:@"data"] valueForKey:@"integral"];
//                NSString *xstr=[NSString stringWithFormat:@"http://192.168.1.223:8080/shopping/api/thirdPartyLogin.htm?mobileNum=%@",phone];
//                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:xstr]];
//                for (NSHTTPCookie *tempCookie in cookies)
//                {
//                    cookiestr=tempCookie.value;
//                }
//                [[NSUserDefaults standardUserDefaults] setObject:cookiestr forKey:Cookiestr];
                JiFenViewController *JiFenVi=[[JiFenViewController alloc] init];
                JiFenVi.integral=integral;
                [self.navigationController pushViewController:JiFenVi animated:NO];
                self.tabBarController.tabBar.hidden=YES;
                //                [SVProgressHUD showSuccessWithStatus:@"数据请求成功!"];
//            } failure:^(NSError *error) {
//                NSLog(@"---------------%@",error);
//                //                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
//            }];
//        }
    }
    else if(viewClicked==meView.ImgView02)
    {
        NSLog(@"品牌专题");
        PinPViewController *PinPVi=[[PinPViewController alloc] init];
        [self.navigationController pushViewController:PinPVi animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }
    else if(viewClicked==meView.ImgView03)
    {
        NSLog(@"实惠团购");
        TGViewController *tg=[[TGViewController alloc] init];
        [self.navigationController pushViewController:tg animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else if(viewClicked==meView.ImgView04)
    {
        NSLog(@"附近店铺");
        FujinViewController *fujin=[[FujinViewController alloc] init];
        fujin.integral=integral;
        [self.navigationController pushViewController:fujin animated:NO];
        self.tabBarController.tabBar.hidden=YES;
    }
    else if(viewClicked==meView.ImgView05)
    {
        NSLog(@"特色商品");
        TieJViewController *TieJVie=[[TieJViewController alloc] init];
        [self.navigationController pushViewController:TieJVie animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
    }
}

- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width/2) delegate:self placeholderImage:[UIImage imageNamed:@"默认图片"]];
        _topPhotoBoworr.boworrWidth = Screen_Width - 30;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 30;
        //        self.view.userInteractionEnabled
        //        _topPhotoBoworr.autoScroll = NO;
       // NSLog(@"%ld",_imageUrlArray.count);
        _topPhotoBoworr.imageURLStringsGroup =LunArray ;
        _topPhotoBoworr.titlesGroup = LunTitleArray;
    }
    return _topPhotoBoworr;
}
//点击事件
#pragma 轮播的点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    LunWebViewController *LunWebV=[[LunWebViewController alloc] init];
    LunWebV.panduanstr=LunurlArray[index];
    
    [self.navigationController pushViewController:LunWebV animated:NO];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=YES;
    
    NSLog(@"%@",LunurlArray[index]);
    
}
-(void)BtnChaXun
{
        SearchViewController *SearchV=[[SearchViewController alloc]init];
        [self.navigationController pushViewController:SearchV animated:NO];

}
-(void)BtnGouWuChe
{
    LZCartViewController *LZCartVi=[[LZCartViewController alloc]init];
    [self.navigationController pushViewController:LZCartVi animated:NO];
    
}


@end
