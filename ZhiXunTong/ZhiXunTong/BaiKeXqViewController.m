//
//  BaiKeXqViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/25.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "BaiKeXqViewController.h"
#import "PchHeader.h"
#import "BaiKeXqModel.h"
@interface BaiKeXqViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_saveArray;
    NSMutableArray *_timeArray;
    UILabel *label;
    UITextField *textFaBiao;
    NSString *strqf;
    NSString *aaid;
    NSMutableDictionary *userInfo;
    NSString *key;
    NSString *deptid;
    NSString *tvinfoId;
    CGFloat height;
    NSString *lable_name;
    NSString *name;
    NSString *atime;
    NSString *webUrls;
    NSString *comments;
    NSString *likeCount;
}
@property (strong, nonatomic) UIWebView *Webhome;
@end

@implementation BaiKeXqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userInfo=[userDefaults objectForKey:UserInfo];
    key=[userDefaults objectForKey:Key];
    deptid=[userDefaults objectForKey:DeptId];
    tvinfoId=[userDefaults objectForKey:TVInfoId];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userInfo objectForKey:@"Data"];
    aaid=[[arry objectAtIndex:0] objectForKey:@"id"];
    _timeArray=[NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title=_mTitle;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    [self initTableView];
    [self shuju];
    [self shujuTwo];
}
-(void)shuju{
    //http://192.168.1.222:8099/api/APP1.0.aspx?method=Article&TVInfoId=&Key=&Eid=&Uid
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=PostDetails&TVInfoId=%@&Key=%@&Mid=%@&Uid=%@",URL,tvinfoId,key,_mid,aaid];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data==%@",data);
        NSLog(@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"type"]);
        lable_name=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"type"]];
        name=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"Name"]];
        atime=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"time"]];
        comments=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"comments"]];
        likeCount=[NSString stringWithFormat:@"%@",[[[data objectForKey:@"Data"] objectAtIndex:0] objectForKey:@"likeCount"]];
        webUrls=[NSString stringWithFormat:@"%@%@?method=PostDetails&id=%@",URL,[data objectForKey:@"pioneerUrl"],_mid];
        _Webhome = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
        _Webhome.delegate=self;
        _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        _Webhome.scrollView.scrollEnabled = NO;
        
   
        [_Webhome loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrls]]];
        NSLog(@"webUrls====%@",webUrls);
        NSLog(@"%@---%@",comments,likeCount);
        
        UIView *aaView=[[UIView alloc] initWithFrame:CGRectMake(0,Screen_height-144, Screen_Width, 80)];
        aaView.backgroundColor=RGBColor(234, 234, 234);
        [self.view addSubview:aaView];
        
        for (int i=0; i<2; i++) {
           UIButton *Btn_shuang = [UIButton buttonWithType:UIButtonTypeCustom];
            Btn_shuang.frame = CGRectMake(0+(Screen_Width/2+2)*i, 40, Screen_Width/2-1, 40);
            Btn_shuang.backgroundColor = [UIColor whiteColor];
            Btn_shuang.tag=i+50;
            [Btn_shuang setImage:[UIImage imageNamed:@"unchecked_checkbox@2x.png"] forState:UIControlStateNormal];
            //文字
            if (Btn_shuang.tag==50) {
                [Btn_shuang setImage:[UIImage imageNamed:@"thumb_not.png"] forState:UIControlStateNormal];
                [Btn_shuang setTitle:comments forState:UIControlStateNormal];
            }else if(Btn_shuang.tag==51){
                [Btn_shuang setImage:[UIImage imageNamed:@"img_message.png"] forState:UIControlStateNormal];
                [Btn_shuang setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
                [Btn_shuang setTitle:likeCount forState:UIControlStateNormal];
            }
            [Btn_shuang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            Btn_shuang.titleLabel.font=[UIFont systemFontOfSize:20];
            [Btn_shuang addTarget:self action:@selector(BtnsClick:) forControlEvents:UIControlEventTouchUpInside];
            [aaView addSubview:Btn_shuang];
        }
        textFaBiao =[[UITextField alloc] initWithFrame:CGRectMake(10, 3, Screen_Width-100, 34)];
        textFaBiao.layer.cornerRadius=5;
        textFaBiao.backgroundColor=[UIColor whiteColor];
        [aaView addSubview:textFaBiao];
        
        UIButton *Btn_fa = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn_fa.frame = CGRectMake(Screen_Width-80,3,70,34);
        [Btn_fa setTitle:@"发表" forState:UIControlStateNormal];
        Btn_fa.tag=52;
        Btn_fa.layer.cornerRadius=5;
        Btn_fa.backgroundColor=[UIColor greenColor];
        [Btn_fa addTarget:self action:@selector(BtnsClick:) forControlEvents:UIControlEventTouchUpInside];
        [aaView addSubview:Btn_fa];
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];
}
-(void)shujuTwo{
    NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=atom&TVInfoId=%@&Key=%@&Mid=%@&Uid=%@",URL,tvinfoId,key,_mid,aaid];
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data==%@",data);
        _saveArray=[BaiKeXqModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"Data"]];
        for (int i=0; i<_saveArray.count; i++) {
            NSData *btime=[[[data objectForKey:@"Data"] objectAtIndex:i] objectForKey:@"time"];
            [_timeArray addObject:btime];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];

}
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height-97) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView setTableFooterView:[UIView new]];
    
    
}
-(void)BtnsClick:(UIButton *)sender
{
    if (sender.tag==50) {
        NSLog(@"111111");
    }
    else if (sender.tag==51){
        NSLog(@"2222222");
    }
    else if(sender.tag==52){
        NSLog(@"发表");
        NSString *strurl=[NSString stringWithFormat:@"%@/api/APP1.0.aspx?method=PostComments&TVInfoId=%@&Key=%@&mid=%@&Uid=%@&Content=%@",URL,tvinfoId,key,_mid,aaid,textFaBiao.text];
        NSLog(@"%@",strurl);
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"data==%@",data);
            NSString *ss=[data objectForKey:@"Status"];
            int s;
            s=[ss intValue];
            if (s==1) {
                [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"发表失败"];
            }
            
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return 100;
    }
    else if (section==1)
    {
        return 30;
    }
    else
    {
        return 5;
    }
    
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return _saveArray.count;
        
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0){
     
            return height;
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==label.tag) {
            CGFloat aa=label.frame.size.height+30;
            return aa;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0,0,Screen_Width, 100)];
        
        headView.backgroundColor=RGBColor(234, 234, 234);
        UIImageView *touImag=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        touImag.image=[UIImage imageNamed:@"001.png"];
        touImag.layer.masksToBounds=YES;
        touImag.layer.cornerRadius=touImag.bounds.size.width*0.5;
        [headView addSubview:touImag];
        
        UILabel *lable_names=[[UILabel alloc] initWithFrame:CGRectMake(0, 75, 80, 23)];
        lable_names.text=lable_name;
        lable_names.textAlignment=NSTextAlignmentCenter;
        [headView addSubview:lable_names];
        
        UILabel *names=[[UILabel alloc] initWithFrame:CGRectMake(80, 30, 80, 21)];
        names.text=name;
        [headView addSubview:names];
        
        UILabel *atimes=[[UILabel alloc] initWithFrame:CGRectMake(80, 50
                                                                 , 80, 21)];
        NSArray *array = [atime componentsSeparatedByString:@" "];
        NSLog(@"%@",[array objectAtIndex:0]);
        atimes.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        atimes.font=[UIFont systemFontOfSize:13];
        [headView addSubview:atimes];
        return headView;
    }else if (section==1)
    {
        UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(0,0,Screen_Width, 30)];
        headView.backgroundColor=[UIColor whiteColor];
        UILabel *lable_name1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        lable_name1.text=@"评论";
        lable_name1.textColor=RGBColor(69, 149, 19);
        lable_name1.textAlignment=NSTextAlignmentCenter;
        [headView addSubview:lable_name1];
        
        UILabel *lable_namebg=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        lable_namebg.backgroundColor=RGBColor(69, 149, 19);
        
        [headView addSubview:lable_namebg];
        return headView;
    }
    else {
        UIView *separateLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0,0,Screen_Width, 5)];
        [separateLineBottom setBackgroundColor:RGBColor(236, 236, 236)];
        [tableView.tableHeaderView addSubview:separateLineBottom];
        return separateLineBottom;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if (indexPath.section==0) {
        //定义个静态字符串为了防止与其他类的tableivew重复
        static NSString *CellIdentifier =@"Cell";
        //定义cell的复用性当处理大量数据时减少内存开销
        UITableViewCell *cellq = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cellq ==nil)
        {
            cellq = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        }
            [cellq.contentView addSubview:_Webhome];
            return cellq;

    }
    else if (indexPath.section==1)
    {//评论
        BaiKeXqModel *model=[_saveArray objectAtIndex:indexPath.row];
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(15, 2, 25, 25)];
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,model.Head_portrait]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        img.layer.masksToBounds=YES;
        img.layer.cornerRadius=img.bounds.size.width*0.5;
        [cell.contentView addSubview:img];
        UILabel *lable_names=[[UILabel alloc] initWithFrame:CGRectMake(42, 0, 130, 13)];
        lable_names.text=[NSString stringWithFormat:@"%@",model.Name];
        lable_names.textColor=[UIColor blueColor];
        lable_names.textAlignment=NSTextAlignmentCenter;
        lable_names.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable_names];
        UILabel *lable_times=[[UILabel alloc] initWithFrame:CGRectMake(42, 13.5, 130, 13)];
        NSArray *array = [[_timeArray objectAtIndex:indexPath.row] componentsSeparatedByString:@" "];
        lable_times.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        lable_times.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable_times];

        UIButton * Btn_dian =[[UIButton alloc] initWithFrame:CGRectMake(Screen_Width-60, 2, 50, 30)];
        Btn_dian.backgroundColor =[UIColor clearColor];
        //图片
        int ab=[model.Islike intValue];
        if (ab==0) {
            [Btn_dian setImage:[UIImage imageNamed:@"thumb_not.png"] forState:UIControlStateNormal];
        }else{
            [Btn_dian setImage:[UIImage imageNamed:@"thumb_ok.png"] forState:UIControlStateNormal];
        }
        
        //文字
        [Btn_dian setTitle:[NSString stringWithFormat:@"%@",model.likeCount] forState:UIControlStateNormal];
        [Btn_dian setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Btn_dian.titleLabel.font =[UIFont boldSystemFontOfSize:17];
        Btn_dian.tag=indexPath.row;
        [Btn_dian addTarget:self action:@selector(btn_dianZ:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:Btn_dian];

        label=[[UILabel alloc] initWithFrame:CGRectMake(42, 27, Screen_Width-52, 70)];
        label.text=[NSString stringWithFormat:@"%@",model.content];
//        content
        //清空背景颜色
        label.backgroundColor = [UIColor clearColor];
        //文字居中显示
        label.textAlignment = NSTextAlignmentLeft;
        label.font=[UIFont systemFontOfSize:13];
        //自动折行设置
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.numberOfLines = 5;
        label.tag=indexPath.row;
        //自适应高度
        CGRect txtFrame = label.frame;
        label.frame = CGRectMake(40, 3, Screen_Width-60,
                                 txtFrame.size.height =[label.text boundingRectWithSize:
                                                        CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                             attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
        label.frame = CGRectMake(40, 27, Screen_Width-60, txtFrame.size.height);
        [cell.contentView addSubview:label];
        
        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(40, 50, Screen_Width-60, 25)];
        lable1.numberOfLines=2;
        lable1.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:lable1];
        return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat  jj= [[_Webhome stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    
    
    height=jj/3;
    _Webhome.frame = CGRectMake(0,0, Screen_Width, height);
    _Webhome.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [_tableView reloadData];
}
//点赞
-(void)btn_dianZ:(UIButton *)sender{
//    OrderModel *modle=ModelArray[sender.tag];
//    ZFordid=modle.order_id;
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
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
