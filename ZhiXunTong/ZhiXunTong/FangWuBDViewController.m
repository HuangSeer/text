//
//  FangWuBDViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/19.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "FangWuBDViewController.h"
#import "PchHeader.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "BangDingViewController.h"
#import "XiaoQuModele.h"
@interface FangWuBDViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UITextField *textAddres;
    UITextField *textId;
    UITextField *textName;
    UITextField *textIphone;
    NSMutableArray *titles;
    UILabel *textLalbe1;
    UILabel *textLalbe;
    
    NSString *myid;
    NSMutableDictionary *userinfo;
    NSString *ddtvinfo;
    NSString *ddkey;
    NSMutableArray *shengfenArray;
    
    NSString *ddLid;
    
    NSString *ddid;
}

@end

@implementation FangWuBDViewController

- (void)viewDidLoad {
    [super viewDidLoad];//房屋绑定
    [self daohangView];
    [self initTableView];
    shengfenArray=[NSMutableArray arrayWithCapacity:0];
    titles=[NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    ddkey=[userinfo objectForKey:@"Key"];
    ddtvinfo=[userinfo objectForKey:@"TVInfoId"];
    ddid=[[arry objectAtIndex:0] objectForKey:@"id"];
}
-(void)daohangView
{
    // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hongse.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.title=@"绑定小区";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
-(void)initTableView
{
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height)];
    //隐藏表格滚动条
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.rowHeight = 150;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark - Table view data source
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //定义个静态字符串为了防止与其他类的tableivew重复
    static NSString *CellIdentifier =@"Cell";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row==0)
    {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 22)];
        lable.text=@"房屋信息";
        lable.font=[UIFont systemFontOfSize:13];
        lable.textColor=[UIColor orangeColor];
        [cell.contentView addSubview:lable];
        
        UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(10, 40, Screen_Width-20, 0.5)];
        xian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:xian];
        
        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(0, 50, 70, 30)];
        lable1.text=@"小区信息";
        lable1.font=[UIFont systemFontOfSize:13];
        lable1.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable1];
        
        UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 70, 30)];;
        lable2.text=@"身份";
        lable2.font=[UIFont systemFontOfSize:13];
        lable2.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable2];
        //小区
        textLalbe=[[UILabel alloc] initWithFrame:CGRectMake(90, 45, Screen_Width-100, 40)];
        UITapGestureRecognizer *tapRecognizerWeibo=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableBtn)];
        textLalbe.userInteractionEnabled=YES;
        [textLalbe addGestureRecognizer:tapRecognizerWeibo];
        textLalbe.text=@"";
        textLalbe.layer.borderColor = [[UIColor grayColor]CGColor];
        textLalbe.layer.borderWidth = 0.5f;
        textLalbe.layer.masksToBounds = YES;
        textLalbe.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:textLalbe];
        UIImageView *aa=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-120, 10, 20, 20)];
        UIImage *img=[UIImage imageNamed:@"1.png"];
        aa.image =img;
        [textLalbe addSubview:aa];
        //业主
        textLalbe1=[[UILabel alloc] initWithFrame:CGRectMake(90, 95, Screen_Width-100, 40)];
        UITapGestureRecognizer *tapRecognizerWeibo1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ylableBtn)];
        textLalbe1.userInteractionEnabled=YES;
        [textLalbe1 addGestureRecognizer:tapRecognizerWeibo1];
        textLalbe1.text=@"";
        textLalbe1.layer.borderColor = [[UIColor grayColor]CGColor];
        textLalbe1.layer.borderWidth = 0.5f;
        textLalbe1.layer.masksToBounds = YES;
        textLalbe1.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:textLalbe1];
        UIImageView *aa1=[[UIImageView alloc] initWithFrame:CGRectMake(Screen_Width-120, 10, 20, 20)];
        UIImage *img1=[UIImage imageNamed:@"1.png"];
        aa1.image =img1;
        [textLalbe1 addSubview:aa1];
        //分割
        UIView *fenxian=[[UIView alloc] initWithFrame:CGRectMake(0, 149, Screen_Width,10)];
        fenxian.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:fenxian];
    }
    else if(indexPath.row==1)
    {
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake((Screen_Width-150)/2, 50, 150, 35);
        denglu.backgroundColor = [UIColor blueColor];
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"提交认证" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        
        [denglu addTarget:self action:@selector(BtnClickRz) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
//        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 22)];
//        lable.text=@"个人信息";
//        lable.font=[UIFont systemFontOfSize:13];
//        lable.textColor=[UIColor orangeColor];
//        [cell.contentView addSubview:lable];
//        
//        UIView *xian=[[UIView alloc] initWithFrame:CGRectMake(10, 40, Screen_Width-20, 0.5)];
//        xian.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:xian];
//        
//        UILabel *lable1=[[UILabel alloc] initWithFrame:CGRectMake(0, 50, 70, 30)];
//        lable1.text=@"姓名";
//        lable1.font=[UIFont systemFontOfSize:13];
//        lable1.textAlignment=NSTextAlignmentRight;
//        [cell.contentView addSubview:lable1];
//        
//        UILabel *lable2=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 70, 30)];;
//        lable2.text=@"电话号码";
//        lable2.font=[UIFont systemFontOfSize:13];
//        lable2.textAlignment=NSTextAlignmentRight;
//        [cell.contentView addSubview:lable2];
//        
//        textName=[[UITextField alloc] initWithFrame:CGRectMake(90, 45, Screen_Width-100, 40)];
//        textName.layer.borderWidth=1.0f;
//        textName.layer.borderColor=[UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
//        [cell.contentView addSubview: textName];
//        
//        textIphone=[[UITextField alloc] initWithFrame:CGRectMake(90, 95, Screen_Width-100, 40)];
//        textIphone.layer.borderWidth=1.0f;
//        textIphone.layer.borderColor=[UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
//        [cell.contentView addSubview: textIphone];
//        
//        //分割
//        UIView *fenxian=[[UIView alloc] initWithFrame:CGRectMake(0, 149, Screen_Width,10)];
//        fenxian.backgroundColor=[UIColor grayColor];
//        [cell.contentView addSubview:fenxian];
    }
    else if (indexPath.row==2)
    {
        UIButton *denglu = [UIButton buttonWithType:UIButtonTypeCustom];
        denglu.frame = CGRectMake((Screen_Width-150)/2, 50, 150, 35);
        denglu.backgroundColor = [UIColor greenColor];
        [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        denglu.titleLabel.font=[UIFont systemFontOfSize:20];
        [denglu setTitle:@"提交认证" forState:UIControlStateNormal];
        denglu.layer.cornerRadius=5;
        
        [denglu addTarget:self action:@selector(BtnClickRz) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:denglu];
    }
    //取消选中颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//身份选择
-(void)ylableBtn
{
    NSLog(@"身份");
    ddLid=@"";
    [titles removeAllObjects];
    [[WebClient sharedClient] Tvinfo:ddtvinfo Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"resultObject=%@",resultObject);
        shengfenArray=[[NSMutableArray alloc]initWithArray:[XiaoQuModele mj_objectArrayWithKeyValuesArray:[resultObject objectForKey:@"Data"]]];
        NSString *ss=[resultObject objectForKey:@"Status"];
        int aa=[ss intValue];
        if (aa==1) {
            [SVProgressHUD showSuccessWithStatus:@"获取成功"];
            for (int i=0; i<shengfenArray.count; i++) {
                XiaoQuModele *mode=[shengfenArray objectAtIndex:i];
                [titles addObject:mode.type];
            }
            [ZJBLStoreShopTypeAlert showWithTitle:@"选择你的身份" titles:titles selectIndex:^(NSInteger selectIndex) {
                NSLog(@"选择了第%ld个",selectIndex);
                ddLid=[NSString stringWithFormat:@"%ld",selectIndex+1];
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                textLalbe1.text=selectValue;
                // self.titleLabel.text = selectValue;
            } showCloseButton:NO];
        }else{
            NSLog(@"没有数据:%@",[resultObject objectForKey:@"Message"]);
        }
    }];
    
}
//小区信息选择
-(void)lableBtn
{
    NSLog(@"小区地址");
    BangDingViewController *bangding=[[BangDingViewController alloc] init];
    bangding.frstBlock = ^(NSString *title,NSString *xqid) {
        textLalbe.text=title;
        myid=xqid;
    };
    [self.navigationController pushViewController:bangding animated:NO];
}
-(void)BtnClickRz
{
    NSLog(@"%@",myid);
    if (textLalbe.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择小区信息"];
    }
    else if (textLalbe1.text.length==0)
    {
         [SVProgressHUD showErrorWithStatus:@"请选择身份"];
    }
    else{
       NSLog(@"提交认证");
        [SVProgressHUD showWithStatus:@"加载中"];
        [[WebClient sharedClient] Hid:myid TVinfo:ddtvinfo Lid:ddLid Userid:ddid Keys:ddkey ResponseBlock:^(id resultObject, NSError *error) {
           // NSLog(@"实力认证中：%@",resultObject);
            NSString *ss=[resultObject objectForKey:@"Status"];
            int aa=[ss intValue];
            if (aa==1) {
                //先删除
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:shzts];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:ALid];
                [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
                 NSString *zt=[resultObject objectForKey:@"shzt"];
                //再添加
                 [[NSUserDefaults standardUserDefaults] setObject:zt forKey:shzts];
                 [[NSUserDefaults standardUserDefaults] setObject:ddLid forKey:ALid];
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                NSLog(@"%@",[resultObject objectForKey:@"Message"]);
                [SVProgressHUD showSuccessWithStatus:[resultObject objectForKey:@"Message"]];
            }
        }];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
