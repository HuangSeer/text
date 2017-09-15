//
//  SearchViewController.m
//  LeBao
//
//  Created by 小黄人 on 2017/4/7.
//  Copyright © 2017年 小黄人. All rights reserved.
//

#import "SearchViewController.h"
#define Start_X          10.0f      // 第一个按钮的X坐标
#define Start_Y          50.0f     // 第一个按钮的Y坐标
#define Width_Space      10.0f      // 2个按钮之间的横间距
#define Height_Space     20.0f     // 竖间距
#define Button_Height   40.0f    // 高
#define Button_Width    65// 宽
#import "SearchTableViewCell.h"
#import "ZQLNetWork.h"
//#import "SSJGViewController.h"
//#import "activityModel.h"
#import "MJExtension.h"
#import "SousuoModel.h"
#import "PchHeader.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *array;
    UIButton *tempBtn1;
    UITableView *tableview;
    SearchTableViewCell *cell;
    UIView *allview;
    UIButton *butx;
    NSString *strlex;
}
@property(nonatomic,strong)NSString *setrcode;

@property (strong ,nonatomic) NSArray * butTitles;
@property (strong ,nonatomic) NSArray * labtexts;
@property(strong,nonatomic) UITextField *searchText;
@property (strong ,nonatomic) NSMutableArray * SousArray;
@property (strong ,nonatomic) NSArray * jilusArray;

@end

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
    
    
}
-(UITextField *)searchText{
    if (!_searchText) {
        _searchText=[[UITextField alloc]init];
    }
    return _searchText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"搜索";
    [self sousuoloade];
    [self readNSUserDefaults];
    
    [self search];
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
-(void)search{
UIView *viewss=[[UIView alloc]initWithFrame:CGRectMake(10,10, Screen_Width-20,  Screen_height/13)];
    
    viewss.layer.borderWidth=0.5;
    
    viewss.layer.masksToBounds = YES;
    viewss.layer.borderColor=RGBColor(86, 86, 86).CGColor;
    
    [self.view addSubview:viewss];
    self.searchText.frame=CGRectMake(50,0,viewss.frame.size.width-100,viewss.frame.size.height);
    self.searchText.placeholder=@"  请输入关键字";
//    self.searchText.layer.borderWidth=0.5;
 
 
    self.searchText.textColor=RGBColor(163, 163, 163);
    self.searchText.font=[UIFont systemFontOfSize:11.0f];
    self.searchText.delegate=self;
    butx=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, viewss.frame.size.height)];
//    butx.backgroundColor=[UIColor blackColor];
    butx.layer.borderWidth=0.5;
    [butx setTitle:@"宝贝" forState:UIControlStateNormal];
    strlex=@"goods";
    [butx setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    butx.font=[UIFont systemFontOfSize:14.0f];
    butx.layer.masksToBounds = YES;
    butx.layer.borderColor=RGBColor(86, 86, 86).CGColor;
        [butx addTarget:self action:@selector(butxclick) forControlEvents:UIControlEventTouchUpInside];
    [viewss addSubview:butx];
    
   [self.searchText addTarget:self action:@selector(FiledBeganEdting) forControlEvents:UIControlEventEditingDidBegin];
     [viewss addSubview:_searchText];
    

    tempBtn1=[[UIButton alloc]initWithFrame:CGRectMake(viewss.frame.size.width-50,0, 50, viewss.frame.size.height)];
    [tempBtn1 setImage:[UIImage imageNamed:@"serch2"] forState:UIControlStateNormal];
    //button点击事件
//    tempBtn1.backgroundColor=[UIColor blackColor];
    [tempBtn1 addTarget:self action:@selector(butToMinePage) forControlEvents:UIControlEventTouchUpInside];
    [viewss addSubview:tempBtn1];
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, Screen_height/3.8, Screen_Width, Screen_height/1.5) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview registerNib:[UINib nibWithNibName:NSStringFromClass([SearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    tableview.backgroundColor=[UIColor whiteColor];
    UIView * viewwei = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height/1.41, Screen_Width, Screen_height)];
    viewwei.backgroundColor = RGBColor(229, 229, 229);
    [self.view addSubview:viewwei];
    
 
    [self.view addSubview:tableview];
    
  
}
-(void)sousuoloade{
    
    [ZQLNetWork postWithUrlString:@"http://www.xhrgogo.com/api/index/hotSearch" parameters:nil success:^(id data) {
        NSLog(@"%@",data);
        _butTitles=[[data objectForKey:@"data"]objectForKey:@"key"];
         NSLog(@"123%@",_butTitles);
        for (int i = 0 ; i < _butTitles.count; i++) {
            NSInteger index = i % _butTitles.count;
            NSInteger page = i / _butTitles.count;
            UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            mapBtn.tag = i;//这句话不写等于废了
            mapBtn.frame = CGRectMake(index * (Screen_Width/4.8 + Width_Space) + Start_X+9, page  * (Button_Height + Height_Space)+(self.searchText.frame.size.height+10), Screen_Width/5.5, Button_Height);
            [mapBtn setTitle:_butTitles[i] forState:UIControlStateNormal];
            mapBtn.tintColor=RGBColor(247, 182, 45);
            mapBtn.titleLabel.font = [UIFont systemFontOfSize: 11];
            
            [self.view addSubview:mapBtn];
            //按钮点击方法
            [mapBtn addTarget:self action:@selector(mapBwtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        for (int i = 0 ; i < _butTitles.count; i++) {
            NSInteger index = i % _butTitles.count;
            NSInteger page = i / _butTitles.count;
            UILabel *labsx=[[UILabel alloc]init];
              labsx.textColor=RGBColor(211, 213, 213);
            labsx.tag=i;
            labsx.backgroundColor=RGBColor(211, 213, 213);
            labsx.frame=CGRectMake(index * (Screen_Width/4.8 + Width_Space) +Screen_Width/3.8, page  * (Button_Height + Height_Space)+(self.searchText.frame.size.height+20),1, 20);
            [labsx setText:_labtexts[i]];
          
            [self.view addSubview:labsx];
            
        }
 
        
    } failure:^(NSError *error) {
    }];
}

-(void)butToMinePage{
    if (_searchText.text.length!=0) {
      
        NSString *strsearch=[[NSString stringWithFormat:@"%@",self.searchText.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strurl=[NSString stringWithFormat:@"%@search.htm?type=%@&keyword=%@",URLds,strlex,strsearch];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"%@",data);
             [self SearchText:self.searchText.text];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];

    }else{

    }}
-(void)SearchText:(NSString *)seaTxt
{
    NSMutableArray *searTXT = [[NSMutableArray alloc] init];
    if (self.jilusArray) {
        searTXT = [self.jilusArray mutableCopy];
    }
    [searTXT addObject:seaTxt];
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:@"searchHistory"];
    [tableview reloadData];
}

-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    self.jilusArray =[userDefaultes arrayForKey:@"searchHistory"] ;
         NSLog(@"myArray======%@",self.jilusArray);
    [tableview reloadData];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//删除历史记录
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSUInteger row = [indexPath row]; //获取当前行
//        [self.jilusArray removeObjectAtIndex:row]; //在数据中删除当前对象
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

//修改编辑按钮文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)butqcClick{
    NSString *message = NSLocalizedString(@"确定清空历史搜索吗？", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];
    
    //确认删除
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSArray * myArray = [userDefaultes arrayForKey:@"searchHistory"];
        NSMutableArray *searTXT = [myArray mutableCopy];
        [searTXT removeAllObjects];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:searTXT forKey:@"searchHistory"];
        
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

//点击按钮方法,这里容易犯错
-(void)mapBwtnClick:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    if (sender.tag==0) {
        self.searchText.text=_butTitles[0];
        [self butToMinePage];
    }else if (sender.tag==1){
    
     self.searchText.text=_butTitles[1];
        [self butToMinePage];
    }
    else if (sender.tag==2){
        
        self.searchText.text=_butTitles[2];
        [self butToMinePage];
    }
    else if (sender.tag==3){
        
        self.searchText.text=_butTitles[3];
        [self butToMinePage];
    }else{
        NSLog(@"不可点击");
    
    }
}
-(void)textFiledBeganEdting{
    self.view.hidden=NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchText resignFirstResponder];
}
- (void)keyboardWillHide:(NSNotification *) notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat height = [[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGRect bottomBarFrame = self.view.frame;
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration: animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    bottomBarFrame.origin.y += height;
    [self.view setFrame:bottomBarFrame];
    [UIView commitAnimations];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *butqc=[[UIButton alloc]
initWithFrame:CGRectMake(5, 0, Screen_Width, Screen_height/12)];
    [butqc setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [butqc setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butqc.font=[UIFont systemFontOfSize:11];
    butqc.backgroundColor=[UIColor whiteColor];
      [butqc addTarget:self action:@selector(butqcClick) forControlEvents:UIControlEventTouchUpInside];
    [tableview addSubview:butqc];
    return butqc;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return Screen_height/12;
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.jilusArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_height/12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
      
    cell.lab.text=self.jilusArray[indexPath.row];
    cell.lab.font=[UIFont systemFontOfSize:11];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.lab.text=self.jilusArray[indexPath.row];
    _searchText.text=cell.lab.text;
    [self butToMinePage];
}

-(void)FiledBeganEdting{

    if ([self.searchText.text isEqualToString:@""]) {
                //        self.loginBtn.backgroundColor = [UIColor grayColor];
                tempBtn1.userInteractionEnabled = NO;
            }else{
                //        self.loginBtn.backgroundColor = [UIColor redColor];
               tempBtn1.userInteractionEnabled = YES;
            }
}

//设置输入框光标颜色
- (void)setCursorColor:(UIColor *)cursorColor
{
    if (cursorColor) {
        _cursorColor = cursorColor;
        //获取输入框
        UITextField *searchField = self.searchText;
        if (searchField) {
            //光标颜色
            [searchField setTintColor:cursorColor];
        }
    }
}
-(void)butxclick{


    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    
    allview= [[UIView alloc]initWithFrame:CGRectMake(10,120,45,83)];
    allview.backgroundColor=[UIColor whiteColor];
    NSArray *array=@[@"宝贝",@"商铺"];
    for (int i=0;i<array.count; i++) {
        int crp=i%2;
        UIButton *butxs=[[UIButton alloc]initWithFrame:CGRectMake(0, crp*41, 45,41)];
        butxs.layer.borderWidth=0.5;
        butxs.tag=i+1;
        [butxs setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        [butxs setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        butxs.font=[UIFont systemFontOfSize:14.0f];
        butxs.layer.masksToBounds = YES;
        butxs.layer.borderColor=RGBColor(86, 86, 86).CGColor;
        [butxs addTarget:self action:@selector(butxclickcon:) forControlEvents:UIControlEventTouchUpInside];
        [allview addSubview:butxs];
        
    }
    [window addSubview:allview];
}
- (void)butxclickcon:(UIButton *)btn{
   [allview removeFromSuperview];
    NSLog(@"点击了%ld",btn.tag);
    if (btn.tag==1) {
         strlex=@"goods";
        [butx setTitle:@"宝贝" forState:UIControlStateNormal];
    }else{
         strlex=@"store";
    [butx setTitle:@"商铺" forState:UIControlStateNormal];
    
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
@end
