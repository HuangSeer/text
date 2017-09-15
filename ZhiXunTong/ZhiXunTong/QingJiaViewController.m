//
//  QingJiaViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/14.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "QingJiaViewController.h"
#import "PchHeader.h"
#import "Selestview.h"
#import "WSDatePickerView.h"

@interface QingJiaViewController ()<UITextViewDelegate>{

  UILabel *_placeholderLabel;
    UIButton *butxiala;
    UIButton *butxiala2;
    int strtypeid;
     NSString *strauditor;
     NSString *strbegin;
     NSString *strend;
       NSString *strcookie;
    NSString *date2;
    NSDate *datas;
    NSDate *datase2;
    NSString *date;
    
    //时间间隔
    UILabel *labzongg;
    
}
@property (strong ,nonatomic)UITextView *textView;
@end

@implementation QingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首先创建格式化对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
    [self viewBX];
    self.view.backgroundColor=[UIColor whiteColor];
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
-(void)viewBX{
    NSArray *arrayone=@[@"请假类型",@"开始时间",@"结束时间"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (65)+10, Screen_Width/4.5, 50)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
//        labzhum.backgroundColor=[UIColor redColor];
        labzhum.textAlignment = UITextAlignmentLeft;
        [self.view addSubview:labzhum];
        self.navigationItem.title=@"请假调休";
    }
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0,65, Screen_Width, 5)];
    views.backgroundColor=RGBColor(238, 238, 238);
    [self.view addSubview:views];
    for (int i=0; i<arrayone.count-1; i++) {
         NSInteger page = i/1;
        UIView *viewb=[[UIView alloc]initWithFrame:CGRectMake(10,page *(65)+135, Screen_Width-20, 1)];
        viewb.backgroundColor=RGBColor(238, 238, 238);
        [self.view addSubview:viewb];
    }
    NSArray *arraya=@[@"1",@"2",@"2"];
    for (int i=0; i<arraya.count; i++) {
        NSInteger page = i/1;
        butxiala=[[UIButton alloc]initWithFrame:CGRectMake(15+Screen_Width/4.5, page * (65)+20, Screen_Width-(40+Screen_Width/4.5), 30)];
        butxiala.backgroundColor=[UIColor whiteColor];
        [butxiala setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-25, 5, 5)];
        [butxiala setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        [butxiala setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",arraya[i]]]forState:UIControlStateNormal];
        butxiala.tag=i+1;
        [butxiala setTitle:@"请选择" forState:UIControlStateNormal];
        butxiala.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [butxiala setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        butxiala.font=[UIFont systemFontOfSize:14.0f];
        [butxiala.layer setBorderWidth:1.0];   //边框宽度
        [butxiala addTarget:self action:@selector(butxialaClick:) forControlEvents:UIControlEventTouchUpInside];
       [butxiala.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
        [self.view addSubview:butxiala];
    }
    labzongg=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, Screen_Width-20, 50)];
    labzongg.textColor=[UIColor blackColor];
    labzongg.font=[UIFont systemFontOfSize:14.0f];
    labzongg.text=@"共计  天";
    //        labzhum.backgroundColor=[UIColor redColor];
    labzongg.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:labzongg];
    UIView *views2=[[UIView alloc]initWithFrame:CGRectMake(0,255, Screen_Width, 5)];
    views2.backgroundColor=RGBColor(238, 238, 238);
    [self.view addSubview:views2];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 260, Screen_Width-20, 80)];
    [self.view addSubview:self.textView];
    self.textView.delegate = self;
    //设置文本
    //    self.textView.text = @"我是UITextView，大家欢迎使用。";
    //设置文字对齐方式属性
    self.textView.textAlignment = NSTextAlignmentLeft;
    //设置文字对齐方
    //设置文字颜色属性
    self.textView.textColor = [UIColor blackColor];
    //设置文字字体属性
    self.textView.font = [UIFont systemFontOfSize:12.0f];
    //设置编辑使能属性,是否允许编辑（=NO时，只用来显示，依然可以使用选择和拷贝功能）
    self.textView.editable = YES;
    //设置圆角、边框属性
    self.textView.layer.cornerRadius = 1.0f;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor =[UIColor grayColor].CGColor;
    
    //模仿UTextField的placeholder属性
    _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.textView.frame), 20)];
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.text = @"请输入内容";
    _placeholderLabel.font = self.textView.font;
    [self.textView addSubview:_placeholderLabel];
    [self.view addSubview:labzongg];
    UIView *views3=[[UIView alloc]initWithFrame:CGRectMake(0,345, Screen_Width, 5)];
    views3.backgroundColor=RGBColor(238, 238, 238);
    [self.view addSubview:views3];
    UILabel *labsh=[[UILabel alloc]initWithFrame:CGRectMake(10, 360, Screen_Width/6, 50)];
    labsh.textColor=[UIColor blackColor];
    labsh.font=[UIFont systemFontOfSize:14.0f];
    labsh.text=@"审核人";
    labsh.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:labsh];
    
   butxiala2=[[UIButton alloc]initWithFrame:CGRectMake(15+Screen_Width/6,370, Screen_Width/3, 30)];
    butxiala2.backgroundColor=[UIColor whiteColor];
    [butxiala2 setTitle:@"请选择审批人" forState:UIControlStateNormal];
    [butxiala2 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    butxiala2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [butxiala2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butxiala2 addTarget:self action:@selector(butxiala2saClick) forControlEvents:UIControlEventTouchUpInside];
    butxiala2.font=[UIFont systemFontOfSize:13.0f];
    [self.view addSubview:butxiala2];
    
    UIButton *buttijiao=[[UIButton alloc]initWithFrame:CGRectMake((Screen_Width-Screen_Width/2.6)/2,420, Screen_Width/2.6, 30)];
    buttijiao.backgroundColor=[UIColor redColor];
    [buttijiao setTitle:@"提交" forState:UIControlStateNormal];
    buttijiao.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [buttijiao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttijiao addTarget:self action:@selector(buttijiaoClick) forControlEvents:UIControlEventTouchUpInside];
    buttijiao.font=[UIFont systemFontOfSize:13.0f];
    buttijiao.clipsToBounds=YES;
    
    buttijiao.layer.cornerRadius=5;
    [self.view addSubview:buttijiao];


}
//点击按钮方法,这里容易犯错
-(void)butxialaClick:(UIButton *)sender{
    if (sender.tag==1) {
//           strtypeid=[NSString stringWithFormat:@"%ld",selectIndex];
        NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/leaves/getAllLeavesType.do?Cookie=%@",strcookie];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"data========%@",data);
            NSArray *titles=[data objectForKey:@"data"];
            [SelectAlert showWithTitle:@"审核类型" titles:titles selectIndex:^(NSInteger selectIndex) {
      
            NSString *s = [NSString stringWithFormat:@"%ld",selectIndex];
                
               strtypeid= [s intValue];
            } selectValue:^(NSString *selectValue) {
                NSLog(@"选择的值为%@",selectValue);
                [sender setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
                
            } showCloseButton:NO];
            
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
        }];
        
    }else if(sender.tag==2){
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
            
            datas=startDate;
             date= [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
               strbegin=[[NSString stringWithFormat:@"%@",date]
                         stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"时间： %@",strbegin);
            [sender setTitle:[NSString stringWithFormat:@"%@",date] forState:UIControlStateNormal];
            
        }];
        datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
        [datepicker show];
    }else if(sender.tag==3){
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
             strend=[[NSString stringWithFormat:@"%@",startDate] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             datase2=startDate;
             date2= [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
         
            
            [sender setTitle:date2 forState:UIControlStateNormal];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //然后创建日期对象
        
            //计算时间间隔（单位是秒）
            NSTimeInterval time = [datas timeIntervalSinceDate:datase2];
            //计算天数、时、分、秒
            int days = ((int)time)/(3600*24);
            int hours = ((int)time)%(3600*24)/3600;
           
            NSString *dateContent= [[NSString alloc] initWithFormat:@"共计%i天%i小时",days,hours];
            labzongg.text=dateContent;
            NSLog(@"components====%@",dateContent);
            
        }];
        datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
        [datepicker show];
    }

}
-(void)butxiala2saClick{
    
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/leaves/getLeavesAuditor.do?Cookie=%@",strcookie];
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data========%@",data);
        NSArray *titldbl=[data objectForKey:@"data"];
        [SelectAlert showWithTitle:@"审核人" titles:titldbl selectIndex:^(NSInteger selectIndex) {
        } selectValue:^(NSString *selectValue) {
            NSLog(@"选择的值为%@",selectValue);
            strauditor=[[NSString stringWithFormat:@"%@",selectValue]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
              [butxiala2 setTitle:[NSString stringWithFormat:@"     %@",selectValue] forState:UIControlStateNormal];
            [butxiala2 setTitleColor:RGBColor(134, 163, 255) forState:UIControlStateNormal];
//            [sender setTitle:[NSString stringWithFormat:@"%@",selectValue] forState:UIControlStateNormal];
            
            
        } showCloseButton:NO];
        
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];


}

-(void)buttijiaoClick{
    NSString *strtextview=[[NSString stringWithFormat:@"%@",_textView.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *strurl=[NSString stringWithFormat:@"http://www.eollse.cn:8080/grid/app/leaves/addOneLeavesInfo.do?leaves_type_id=%d&leaves_auditor=%@&leaves_begin_time=%@&leaves_end_time=%@&leaves_reason=%@Cookie=%@",strtypeid,strauditor,strbegin,strend,strtextview,strcookie];
//计算开始时间到结束时间的天数
    NSLog(@"%@",strurl);
    [ZQLNetWork getWithUrlString:strurl success:^(id data) {
        NSLog(@"data========%@",data);
        NSString *strtx=[NSString stringWithFormat:@"%@",[data objectForKey:@"message"]];
        [SVProgressHUD showSuccessWithStatus:strtx];

    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
    }];



}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑。");
    _placeholderLabel.text = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"结束编辑。");
    
    //模仿UTextField的placeholder属性
    if (self.textView.text.length == 0) {
        _placeholderLabel.text = @"请输入内容";
    }else{
        _placeholderLabel.text = @"";
    }
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
