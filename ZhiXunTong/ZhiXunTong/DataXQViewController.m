//
//  DataXQViewController.m
//  ZhiXunTong
//
//  Created by mac  on 2017/7/17.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "DataXQViewController.h"
#import "PchHeader.h"

#import "JLPhotoBrowser.h"
#import "ImageBrowserViewController.h"
#define isShowNetWorkImages   0
@interface DataXQViewController (){
    UIImageView *butimage;
    NSMutableArray *muarray;
    NSMutableArray *strurlarray;
    NSMutableArray *imagearray;
}
@property(nonatomic,strong) NSArray *imageArray;
@end

@implementation DataXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.title=@"日志详情";
    [self initviewxq];
    
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
-(void)initviewxq{
      NSArray *titles=@[[NSString stringWithFormat:@"标        题:      %@",_biaoti],[NSString stringWithFormat:@"网  格 员:       %@",_wgy],[NSString stringWithFormat:@"事件类型:      %@",_leix],[NSString stringWithFormat:@"日志详情:      %@",_xiangq]];
//    NSArray *titles=@[@"网  格 员:",@"标       题:",@"事件类型:",@"日志详情:"];
    for (int i=0; i<titles.count; i++) {
        //        NSInteger index = i %5;
        NSInteger page = i/1;
        UILabel *labfeil=[[UILabel alloc]init];
        labfeil.text=titles[i];
        labfeil.frame= CGRectMake(10, page * (50)+20, Screen_Width-20, 30);
        labfeil.tag = i+1;
        labfeil.font=[UIFont systemFontOfSize:13.0f];
        labfeil.textAlignment = UITextAlignmentLeft;
        [self.view addSubview:labfeil];
        
    }
        
  
    
    NSArray *array = [_image componentsSeparatedByString:@";"];
    muarray=[[NSMutableArray alloc]init];
    [muarray addObjectsFromArray:array];
   
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
        butimage.frame= CGRectMake(index*(Screen_Width/4.3)+15, page * (65)+220, 60, 60);
        butimage.tag = i;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",strurlarray[i]]]]];
        //        butimage.backgroundColor=[UIColor redColor];
        if (image!=nil) {
            [imagearray addObject:image];
            
        }else{
            
        }
//        butimage.backgroundColor=[UIColor redColor];
        butimage.userInteractionEnabled = YES;//打开用户交互
        UITapGestureRecognizer *singleTapssd = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [butimage addGestureRecognizer:singleTapssd];
//http://192.168.1.223:8080/grid/images/app/blog/zs/20170510134301221.png
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
