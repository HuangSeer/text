//
//  SJxqViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/18.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "SJxqViewController.h"
#import "PchHeader.h"
#import "ImageViewController.h"
#import "ImageBrowserViewController.h"

@interface SJxqViewController (){
 UIImageView *butimage;
 NSString *strcookie;
    NSMutableArray *muarray;
    NSMutableArray *strurlarray;
     NSMutableArray *imagearray;
}

@end

@implementation SJxqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    strcookie=[userDefaults objectForKey:Cookie];
    [self initui];
    self.navigationItem.title=@"事件处理详情";
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
-(void)initui{
    NSArray *array = [_time componentsSeparatedByString:@" "]; //从字符A中分隔成2个元素的数组
    NSArray *arrayone=@[[NSString stringWithFormat:@"标        题:    %@",_biaoti],[NSString stringWithFormat:@"事件来源:    %@",_strly],[NSString stringWithFormat:@"紧急程度:    %@",_strcd],[NSString stringWithFormat:@"事件类型:    %@",_leix],[NSString stringWithFormat:@"编  辑  人:    %@",_strname],[NSString stringWithFormat:@"编辑时间:    %@",array[1]],[NSString stringWithFormat:@"详情内容:    %@",_xiangq]];
    for (int i=0; i<arrayone.count; i++) {
        NSInteger page = i/1;
        UILabel *labzhum=[[UILabel alloc]initWithFrame:CGRectMake(10, page * (40)+10, Screen_Width-20, 30)];
        labzhum.textColor=[UIColor blackColor];
        labzhum.font=[UIFont systemFontOfSize:14.0f];
        labzhum.text=arrayone[i];
        //        labzhum.backgroundColor=[UIColor redColor];
        labzhum.textAlignment = UITextAlignmentLeft;
        [self.view addSubview:labzhum];
        self.navigationItem.title=@"请假调休";
    }
    
    NSArray *arrays = [_image componentsSeparatedByString:@";"];
    muarray=[[NSMutableArray alloc]init];
    [muarray addObjectsFromArray:arrays];
    [muarray removeObjectAtIndex:muarray.count-1];
    [muarray removeObject:@""""];
    NSLog(@"%@",muarray);
    strurlarray=[[NSMutableArray alloc]init];
    imagearray=[[NSMutableArray alloc]init];
    for (int i=0; i<muarray.count; i++) {
        NSInteger index = i %4;
        NSInteger page = i/4;
        butimage=[[UIImageView alloc]init];
        NSString *strurl=[@"http://www.eollse.cn:8080/grid/" stringByAppendingString:[NSString stringWithFormat:@"%@",muarray[i]]];
        [butimage sd_setImageWithURL:[NSURL URLWithString:strurl]placeholderImage:[UIImage imageNamed:@""]];
        [strurlarray addObject:strurl];
        NSLog(@"%@",strurlarray);
        butimage.frame= CGRectMake(index*(Screen_Width/4.3)+15, page * (65)+280, 60, 60);
        butimage.tag = i;
       UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurlarray[i]]]]];
        //        butimage.backgroundColor=[UIColor redColor];
        if (image!=nil) {
           
            [imagearray addObject:image];
            
        }else{
            
        }
        butimage.userInteractionEnabled = YES;//打开用户交互
        UITapGestureRecognizer *singleTapssd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [butimage addGestureRecognizer:singleTapssd];
        [self.view addSubview:butimage];
    }
    

}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {

        [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:gestureRecognizer.view.tag imagesBlock:^NSArray *{
            return imagearray;
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
