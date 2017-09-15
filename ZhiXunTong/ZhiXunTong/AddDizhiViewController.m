





//
//  AddDizhiViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/8/5.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "AddDizhiViewController.h"
#import "PchHeader.h"
#import "addressModel.h"


@interface AddDizhiViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIButton *butxiala;
     UIButton *butbaocun;
    NSMutableArray *shengArray;
    NSMutableArray *shiArray;
    NSMutableArray *xianArray;
    UIPickerView *myPickerView;
    NSString *shenid;
    NSString *shiid;
    NSString *xianid;
    NSMutableDictionary *chooseDic;
    UIView *viewpick;
    NSString *dzstr;
    NSString *addstr1;
     NSString *addstr2;
    
}
@property (strong ,nonatomic)UITextField *textFile1;
@property (strong ,nonatomic)UITextField *textFile2;
@property (strong ,nonatomic)UITextField *textFile3;
@end

@implementation AddDizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"编辑(新增)收货地址";
    [self initUI];
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
-(void)initUI{
    NSArray *arrayone=@[@"收  货  人:",@"手机号码:",@"所在区域:",@"详细地址:"];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (45)+10, Screen_Width/4.5, 35)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        labzhum.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:labzhum];
    }
    butxiala=[[UIButton alloc]initWithFrame:CGRectMake(15+Screen_Width/4.5, 100, Screen_Width/1.5, 35)];
    butxiala.backgroundColor=[UIColor whiteColor];
    [butxiala setImageEdgeInsets:UIEdgeInsetsMake(5, butxiala.frame.size.width-15, 5, 5)];
    [butxiala setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [butxiala setImage:[UIImage imageNamed:[NSString stringWithFormat:@"向右箭头"]]forState:UIControlStateNormal];
    [butxiala setTitle:@"请选择" forState:UIControlStateNormal];
    butxiala.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butxiala setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butxiala.font=[UIFont systemFontOfSize:13.0f];
    [butxiala.layer setBorderWidth:1.0];   //边框宽度
    [butxiala addTarget:self action:@selector(butxialaClic) forControlEvents:UIControlEventTouchUpInside];
    [butxiala.layer setBorderColor:RGBColor(238, 238, 238).CGColor];//边框颜色
    [self.view addSubview:butxiala];
    _textFile1= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10,10, Screen_Width/1.5 ,35)];
    _textFile1.backgroundColor = [UIColor whiteColor];
    _textFile1.font = [UIFont systemFontOfSize:14.f];
    _textFile1.textColor = [UIColor blackColor];
    _textFile1.textAlignment = NSTextAlignmentLeft;
    _textFile1.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile1.placeholder = @"请输入收货人姓名";
    _textFile1.layer.borderWidth= 1.0f;
    [self.view addSubview:_textFile1];
    _textFile2= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 55, Screen_Width/1.5,35)];
    _textFile2.backgroundColor = [UIColor whiteColor];
    _textFile2.font = [UIFont systemFontOfSize:14.f];
    _textFile2.textColor = [UIColor blackColor];
    _textFile2.textAlignment = NSTextAlignmentLeft;
    _textFile2.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile2.placeholder = @"请输入手机号码";
    _textFile2.layer.borderWidth= 1.0f;
    
    [self.view addSubview:_textFile2];
    _textFile3= [[UITextField alloc]initWithFrame:CGRectMake( Screen_Width/4.3+10, 145, Screen_Width/1.5 ,35)];
    _textFile3.backgroundColor = [UIColor whiteColor];
    _textFile3.font = [UIFont systemFontOfSize:14.f];
    _textFile3.textColor = [UIColor blackColor];
    _textFile3.textAlignment = NSTextAlignmentLeft;
    _textFile3.layer.borderColor= RGBColor(230, 233, 233).CGColor;
    _textFile3.placeholder = @"请输入详细地址";
    _textFile3.layer.borderWidth= 1.0f;
    [self.view addSubview:_textFile3];
    
    butbaocun=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/4, 220, Screen_Width/2, 30)];
    butbaocun.clipsToBounds=YES;
    butbaocun.layer.cornerRadius=3;
    butbaocun.font=[UIFont systemFontOfSize:14.0f];
    [butbaocun setTitle:@"保存" forState:UIControlStateNormal];
    [butbaocun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butbaocun.backgroundColor=RGBColor(0, 163, 0);
    [butbaocun addTarget:self action:@selector(butbaocunClic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butbaocun];
    
}
-(void)butxialaClic{
    viewpick=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_height-247, Screen_Width, 200)];
    viewpick.layer.cornerRadius = 3;
    
    viewpick.layer.masksToBounds = YES;
    viewpick.layer.borderWidth = 1;
    viewpick.layer.borderColor = [[UIColor grayColor] CGColor];
    UIButton *butwc=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width/1.3, 0, Screen_Width/4.5, 35)];
    [butwc setTitle:@"确定" forState:UIControlStateNormal];
    [butwc setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [butwc addTarget:self action:@selector(butwcClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *butqx=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, Screen_Width/4.5, 35)];
    [butqx setTitle:@"取消" forState:UIControlStateNormal];
    [butqx setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [butqx addTarget:self action:@selector(butqxClick) forControlEvents:UIControlEventTouchUpInside];
    [viewpick addSubview:butqx];
    [viewpick addSubview:butwc];
    
    [self.view addSubview:viewpick];
    NSString *strurlpl=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=0",URLds];
    //省请求
    [ZQLNetWork getWithUrlString:strurlpl success:^(id data) {
        NSLog(@"sad===2==2=2=2========%@",data);
        
      shengArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
        addressModel *model=shengArray[0];
        shenid=[NSString stringWithFormat:@"%@",model.id];
        NSString *strurlpl1=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=%@",URLds,model.id];
        //市请求
        [ZQLNetWork getWithUrlString:strurlpl1 success:^(id data) {
            NSLog(@"sad===2==2=2=2========%@",data);
            
            shiArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            addressModel   *model1=shiArray[0];
            shiid=[NSString stringWithFormat:@"%@",model1.id];
            NSString *strurlpl2=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=%@",URLds,model1.id];
            NSLog(@"sad===2==2=2=2========%@",strurlpl);
            //县请求
            [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
                NSLog(@"========%@",data);
                
                xianArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
                addressModel *model2=xianArray[0];
                
                dzstr=[NSString stringWithFormat:@"%@-%@-%@",model.areaName,model1.areaName,model2.areaName];
                NSLog(@"========%@",model2);
              xianid=[NSString stringWithFormat:@"%@",model2.id];
                // 选择框
                myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35, Screen_Width, viewpick.frame.size.height-35)];
                // 显示选中框
                myPickerView.showsSelectionIndicator=YES; 
                myPickerView.dataSource = self;
                
                myPickerView.delegate = self;
                [viewpick addSubview:myPickerView];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"失败!!"];
            }];

        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
      
    } failure:^(NSError *error) {
        NSLog(@"---------------%@",error);
        [SVProgressHUD showErrorWithStatus:@"失败!!"];
    }];
 
   
}
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return shengArray.count;
    }
    if (component==1) {
        return  shiArray.count;
    }
    if (component==2) {
        return xianArray.count;
    }
    
    return 0;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        addressModel *model=shengArray[row];
        shenid=[NSString stringWithFormat:@"%@",model.id];
        addstr1=[NSString stringWithFormat:@"%@",model.areaName];
        NSString *strurlpl1=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=%@",URLds,model.id];
          NSLog(@"========%@",model.id);
        //市请求
        [ZQLNetWork getWithUrlString:strurlpl1 success:^(id data) {
            
            shiArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            addressModel *model1=shiArray[0];
           shiid=[NSString stringWithFormat:@"%@",model1.id];
            NSString *strurlpl2=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=%@",URLds,model1.id];
            //县请求
            [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {

                xianArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
                addressModel *model2=xianArray[0];
            dzstr=[NSString stringWithFormat:@"%@-%@-%@",model.areaName,model1.areaName,model2.areaName];
            xianid=[NSString stringWithFormat:@"%@",model2.id];
                // 选择框
                [myPickerView reloadAllComponents];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"失败!!"];
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];


    }
    if (component==1) {
        addressModel *model1=shiArray[row];
        addstr2=[NSString stringWithFormat:@"%@",model1.areaName];
       shenid=[NSString stringWithFormat:@"%@",model1.id];
        
        NSString *strurlpl2=[NSString stringWithFormat:@"%@getAllAreaById.htm?parentId=%@",URLds,model1.id];
        //县请求
        [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
            
            xianArray=[addressModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            addressModel *model2=xianArray[0];
         xianid=[NSString stringWithFormat:@"%@",model2.id];
    dzstr=[NSString stringWithFormat:@"%@-%@-%@",addstr1,model1.areaName,model2.areaName];
            // 选择框
            [myPickerView reloadAllComponents];
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];

        
    }
    if (component==2) {
        addressModel *model2=xianArray[row];
         NSLog(@"========%@",model2.id);
        
xianid=[NSString stringWithFormat:@"%@",model2.id];
    dzstr=[NSString stringWithFormat:@"%@-%@-%@",addstr1,addstr2,model2.areaName];
    }

    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component==0) {
        addressModel *model=shengArray[row];
        return model.areaName;
    }
    if (component==1) {
        addressModel *model=shiArray[row];
        return model.areaName;
    }
    if (component==2) {
        addressModel *model=xianArray[row];
        return model.areaName;
    }
    return nil;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        
        //在这里设置字体相关属性
        
        lbl.font = [UIFont systemFontOfSize:14];
        
        lbl.textColor = [UIColor blackColor];
        
        [lbl setTextAlignment:0];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lbl;
}
-(void)butwcClick{
    [viewpick removeFromSuperview];
    [butxiala setTitle:dzstr forState:UIControlStateNormal];

}
-(void)butqxClick{
  [viewpick removeFromSuperview];
  xianid=@"";
}
-(void)butbaocunClic{
    if (_xiugaiid.length!=0) {
        if (_textFile1.text.length!=0&&_textFile3.text.length!=0&&_textFile2.text.length!=0 ) {
            if ([[butxiala currentTitle] containsString:@"请选择"]) {
                [SVProgressHUD showErrorWithStatus:@"请选择！"];
            }else{
                NSString *name=[[NSString stringWithFormat:@"%@",_textFile1.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *phone=[[NSString stringWithFormat:@"%@",_textFile2.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *xiangxi=[[NSString stringWithFormat:@"%@",_textFile3.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *strurlpl2=[NSString stringWithFormat:@"%@address_save.htm?id=%@&area_id=%@&trueName=%@&area_info=%@&zip=&mobile=%@",URLds,_xiugaiid,xianid,name,xiangxi,phone];
                [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
                    NSLog(@"%@",data);
                    NSString *msg=[data objectForKey:@"msg"];
                    [SVProgressHUD showSuccessWithStatus:msg];
                } failure:^(NSError *error) {
                    NSLog(@"---------------%@",error);
                    [SVProgressHUD showErrorWithStatus:@"失败!!"];
                }];
            }
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"你的输入有误请检查"];
        }

    }else{
    
        if (_textFile1.text.length!=0&&_textFile3.text.length!=0&&_textFile2.text.length!=0 ) {
            if ([[butxiala currentTitle] containsString:@"请选择"]) {
                [SVProgressHUD showErrorWithStatus:@"请选择！"];
            }else{
                NSString *name=[[NSString stringWithFormat:@"%@",_textFile1.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *phone=[[NSString stringWithFormat:@"%@",_textFile2.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *xiangxi=[[NSString stringWithFormat:@"%@",_textFile3.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *strurlpl2=[NSString stringWithFormat:@"%@api/address_save.htm?id=&area_id=%@&trueName=%@&area_info=%@&zip=&mobile=%@",URLds,xianid,name,xiangxi,phone];
                [ZQLNetWork getWithUrlString:strurlpl2 success:^(id data) {
                    NSLog(@"%@",data);
                    NSString *msg=[data objectForKey:@"msg"];
                    [SVProgressHUD showSuccessWithStatus:msg];
                } failure:^(NSError *error) {
                    NSLog(@"---------------%@",error);
                    [SVProgressHUD showErrorWithStatus:@"失败!!"];
                }];
            }
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"你的输入有误请检查"];
        }

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
