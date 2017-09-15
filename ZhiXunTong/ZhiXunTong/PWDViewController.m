//
//  PWDViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/6/20.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "PWDViewController.h"
#import "PchHeader.h"
#import "LoginViewController.h"
@interface PWDViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *XiuTableview;
    UITextField *oneText;
    UITextField *twoText;
    UITextField *threeText;
    
    NSDictionary *userinfo;
    NSString *userid;
    NSString *ddkey;
    NSString *ddtvinfo;
}
@end

@implementation PWDViewController

-(void)viewWillAppear:(BOOL)animated
{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    arry=[userinfo objectForKey:@"Data"];
    ddkey=[userinfo objectForKey:@"Key"];
    ddtvinfo=[userinfo objectForKey:@"TVInfoId"];
    userid=[[arry objectAtIndex:0] objectForKey:@"id"];
    //NSLog(@"%@",useriphone);
}

- (void)viewDidLoad {
    [super viewDidLoad];//修改密码
    [self initView];
}
-(void)initView{
    self.navigationItem.title=@"修改密码";
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    XiuTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,Screen_height) style:UITableViewStylePlain];
    
    XiuTableview.delegate=self;
    XiuTableview.dataSource=self;
    [self.view addSubview:XiuTableview];
}

-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 70;
    } else {
        return 50;
    }
    
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
    if (indexPath.row==0) {
        //cell.textLabel.text=@"初始密码:";
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        lable.text=@"初 始 密 码:";
        lable.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable];
        oneText =[[UITextField alloc] initWithFrame:CGRectMake(110, 10, Screen_Width-130, 30)];
        oneText.borderStyle=UITextBorderStyleBezel;
        [cell.contentView addSubview:oneText];
    }
    else if (indexPath.row==1)
    {
       // cell.textLabel.text=@"新密码:";
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        lable.text=@"新    密    码:";
        lable.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable];
        twoText =[[UITextField alloc] initWithFrame:CGRectMake(110, 10, Screen_Width-130, 30)];
        twoText.borderStyle=UITextBorderStyleBezel;
        
        [cell.contentView addSubview:twoText];
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
    }else if(indexPath.row==2){
        //cell.textLabel.text=@"确认新密码:";
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
        lable.text=@"确认新密码:";
        lable.textAlignment=NSTextAlignmentRight;
        [cell.contentView addSubview:lable];
        threeText =[[UITextField alloc] initWithFrame:CGRectMake(110, 10, Screen_Width-130, 30)];
        threeText.borderStyle=UITextBorderStyleBezel;
        
        [cell.contentView addSubview:threeText];
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
    }else if(indexPath.row==3){
        UIView *chu=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0.5)];
        chu.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:chu];
        UIButton *zhuce = [UIButton buttonWithType:UIButtonTypeCustom];
        zhuce.frame = CGRectMake(Screen_Width/2-70, 30, 140, 35);
        zhuce.backgroundColor = [UIColor blueColor];
        [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
        [zhuce setTitle:@"确定修改" forState:UIControlStateNormal];
        zhuce.layer.cornerRadius=5;
        [zhuce addTarget:self action:@selector(BtnIphone) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:zhuce];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    XiuTableview.separatorStyle = NO;
    return  cell;
}
-(void)BtnIphone{
    NSLog(@"提交修改密码");
    NSLog(@"%@-%@-%@",oneText.text,twoText.text,threeText.text);
    if (oneText.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"初始密码不能为空"];
    }
    else if (twoText.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
    }
    else if (threeText.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空"];
    }
    else if ([threeText.text isEqualToString:oneText.text]){
        [SVProgressHUD showErrorWithStatus:@"初始密码和新密码不能一样"];
    }
    else if ([threeText.text isEqualToString:twoText.text])
    {
        NSLog(@"123456");//执行修改
        [SVProgressHUD showSuccessWithStatus:@"正在修改"];
        [self xiugai];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
    }
}
-(void)xiugai{
    [SVProgressHUD showWithStatus:@"执行中"];
    [[WebClient sharedClient] NewPwd:twoText.text Tvinfo:ddtvinfo Keys:ddkey UserId:userid Pwd:oneText.text ResponseBlock:^(id resultObject, NSError *error) {
        NSLog(@"%@ ",resultObject);
        NSString *Status=[resultObject objectForKey:@"Status"];
        int qq=[Status intValue];
        if (qq==1) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:UserInfo];//清空数据
            //返回个人中心
            [self.navigationController popToRootViewControllerAnimated:NO];
        
            
        } else {
            [SVProgressHUD dismiss];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
