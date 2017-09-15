//
//  TPXiaoQingViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/23.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "TPXiaoQingViewController.h"
#import "PchHeader.h"
#import "TouPiaoModel.h"
#import "TouPiaoTableViewCell.h"
//#import "ZQLNetWork.h"
#import "ToupModel.h"
#import "ToupTableViewCell.h"
#import "XZTModel.h"
CGFloat heightCount;
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
@interface TPXiaoQingViewController ()<UITableViewDelegate, UITableViewDataSource>{
 UITableView *_tableView;
    TouPiaoTableViewCell *cell;
    ToupTableViewCell *cellb;
    NSMutableArray *_saveDataArray;
    UIButton *button;
    UIButton *button1;
    UILabel *lable2;
    NSString *aakey;
    NSString *aatvinfo;
    NSString *aadeptid;
    NSString *aaid;
    NSMutableDictionary *userinfo;
    NSString *imageurl;
     NSMutableArray *xzDataArray;
    NSString *labxb;
    NSArray *strsum;
}
@property(nonatomic,copy)NSString *strid;
@end

@implementation TPXiaoQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    aatvinfo=[userinfo objectForKey:@"TVInfoId"];
    aakey=[userinfo objectForKey:@"Key"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
  
    NSLog(@"aakey:%@  --%@--%@",aakey,aaid,aatvinfo);
    [self loddata];
    //[self initTableView];
    // Do any additional setup after loading the view.
    [self daohangView];
}
-(void)daohangView
{
    self.navigationController.title=@"评价调研详情";
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
-(void)loddata{
   
    [[WebClient sharedClient ] toupiao:aaid Keys:aakey TVinfo:aatvinfo id:_idi ResponseBlock:^(id resultObject, NSError *error) {
         NSLog(@"_idi_idi_idi_idi==%@",resultObject);
        _saveDataArray=[[NSMutableArray alloc]initWithArray:[ToupModel mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        imageurl=[[resultObject objectForKey:@"Data"] valueForKey:@"image"];
        labxb=[[resultObject objectForKey:@"Data"] valueForKey:@"content"];
       strsum=[[resultObject objectForKey:@"Data"] valueForKey:@"sum"];

        NSArray *array=[[resultObject objectForKey:@"Data"] valueForKey:@"Data"];

         xzDataArray=[[NSMutableArray alloc]initWithArray:[XZTModel mj_objectArrayWithKeyValuesArray:array[0]]];
       
        
        lable2=[[UILabel alloc] initWithFrame:CGRectMake(0, Screen_height/2.3,self.view.frame.size.width, 15)];
        //she z
        
        ToupModel *toup=[_saveDataArray objectAtIndex:0];
        
        lable2.font=[UIFont systemFontOfSize:13];
        //    NSTextAlignmentLeft
        lable2.textAlignment=NSTextAlignmentCenter;
        lable2.text=[NSString stringWithFormat:@"        %@",toup.content];
        NSLog(@"123contentcontent==%@",lable2.text);
        int WordCount=lable2.frame.size.width/15;
        //下面是使用字体的长度(就是字体的个数)/上面计算出的每行存放字体的个数，算出一共有多少行
        heightCount= lable2.text.length/WordCount+1;
        
        NSLog(@"ssdsa%f",heightCount);
        //heightCount*15  下面我们就是通过上一步计算出的 行数*字体的高度，计算出label最终的展示高度
        [lable2 setFrame:CGRectMake(0, Screen_height/2.3, self.view.frame.size.width,heightCount*15)];
        lable2.numberOfLines = 0;
       // [_tableView reloadData];
        [self initTableView];//表格
    }];
}
- (void)initTableView {
    if ([_vote containsString:@"1"]) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TouPiaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ToupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell2"];
  
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(110, self.view.frame.size.height-35,100, 30)];
    but.backgroundColor=RGBColor(59, 211, 91);
    [but setTitle:@"投上一票" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.layer.cornerRadius=5;
    but.layer.masksToBounds = YES;
    [but addTarget:self action:@selector(butsetviewrigh) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    [self.view addSubview:but];

    }else{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TouPiaoTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ToupTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *viewhead=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewhead.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
    //加载图片
    ToupModel *toupm=[_saveDataArray objectAtIndex:0];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[URL stringByAppendingString:toupm.image]]placeholderImage:[UIImage imageNamed:@"默认图片.png"]];
    [viewhead addSubview:imageView];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake((Screen_Width-60)/2,Screen_height/3.25, 60, 25)];
    lable.text=@"投 票";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.layer.borderColor = [[UIColor grayColor]CGColor];
    lable.layer.borderWidth = 1.0f;
    lable.layer.masksToBounds = YES;
    lable.font=[UIFont systemFontOfSize:15];
    [viewhead addSubview:lable];
    
    UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(10, Screen_height/3.05, (Screen_Width-60)/2-10, 0.5)];
    xian.backgroundColor=[UIColor grayColor];
    [viewhead addSubview: xian];
    UIView *xian1=[[UIView alloc] initWithFrame:CGRectMake((Screen_Width-60)/2+60, Screen_height/3.05, (Screen_Width-60)/2-10, 0.5)];
    xian1.backgroundColor=[UIColor grayColor];
    [viewhead addSubview: xian1];
    UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(0, Screen_height/2.9, Screen_Width, 44)];
    lable1.text=_titlevi;
    lable1.textAlignment=NSTextAlignmentCenter;
    [viewhead addSubview:lable1];
    lable1.font=[UIFont systemFontOfSize:22];
    UIView *xians=[[UIView alloc] initWithFrame:CGRectMake(10, Screen_height/2.4, Screen_Width-20, 0.5)];
    xians.backgroundColor=[UIColor grayColor];
    [viewhead addSubview: xians];
    
 
    [viewhead addSubview:lable2];
    UIView *xian2=[[UIView alloc] initWithFrame:CGRectMake(10, Screen_height/2.25+heightCount*15,self.view.frame.size.width-20 ,0.8)];
    xian2.backgroundColor=[UIColor grayColor];
    
    [viewhead addSubview: xian2];
    
    return viewhead;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
   return  Screen_height/2.25+heightCount*15;

}
#pragma mark -- UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // if (xzDataArray.count>0) {
        if ([_vote containsString:@"0"]) {
            return xzDataArray.count;
        }else{
            return xzDataArray.count;
        }
    //}
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_vote containsString:@"0"]) {
      return 68;
    }else{
      return 44;
    }
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_vote containsString:@"0"]) {
        cellb= [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cellb.xztt=xzDataArray[indexPath.row];
       XZTModel *xz2=xzDataArray[indexPath.row];
        
        NSString *strps=xz2.count;
       
        int ivalue = [strsum[0] intValue];
         int ivalue2 = [strps intValue];
        NSLog(@"%d======%d",ivalue,ivalue2);
        float c;
        if (ivalue!=0&&ivalue2!=0) {
        c=(float)ivalue2/(float)ivalue*50;
        }else{
            c=0;
        
        }

    
       cellb.view1.frame=CGRectMake(10, 42, c, 3);
       cellb.view1.backgroundColor=[UIColor blueColor];
        cellb.lab3.text=[NSString stringWithFormat:@"%.1f%%",c*2];
        [cellb addSubview:cellb.view1];
        cellb.selectionStyle=UITableViewCellSelectionStyleNone;
        return cellb;
    }else{
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.XZTm=xzDataArray[indexPath.row];
        
        return cell;
    
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XZTModel *xztm=xzDataArray[indexPath.row];
    _strid=xztm.id;

}
-(void)butsetviewrigh{
    [[WebClient sharedClient] toup:aaid Keys:aakey TVinfo:aatvinfo id:_strid ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"_idi_idi_idi_idi==%@",resultObject);
           }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
