//
//  DesireViewController.m
//  XiangQu
//
//  Created by xk_mac01 on 16/2/19.
//  Copyright © 2016年 骆驼刺科技. All rights reserved.
//

#import "DesireViewController.h"
//#import "CollectViewController.h"
//#import "PlftoViewController.h"
//#import "AppConfig.h"
//#import "HMViewController.h"
#import "XiuViewController.h"
#import "BaoXiuViewController.h"
@interface DesireViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_viewArray;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSMutableArray *_buttonArray;
    
}
@end

@implementation DesireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"一键报修";
    [self changeButton];
    [self scroll];
    //返回按钮
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lanse.png"] forBarMetrics:UIBarMetricsDefault];
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backItem.tag=110;
    [backItem addTarget:self action:@selector(buttondesire) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
}
- (void)changeButton{
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    //2个内容切换的button
    UIView *kongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,44)];
    kongView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArray = @[@"一键报修",@"公共报修"];
    
    for (int i = 0 ; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(self.view.bounds.size.width/2*i, 0, self.view.bounds.size.width/2, 64);
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(-7, 0, 7, 0);
        button.tintColor = [UIColor blackColor];
        if (i == 0) {
            button.tintColor =[UIColor greenColor];
        }
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [kongView addSubview:button];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2*i, 42, self.view.bounds.size.width/2,3)];
        view.backgroundColor = [UIColor greenColor];
        if (i) {
            view.hidden = YES;
        }
        [kongView addSubview:view];
        [_viewArray addObject:view];
        [_buttonArray addObject:button];
        
    }
    UIView *xView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    xView.backgroundColor = [UIColor clearColor];
    [kongView addSubview:xView];
    
    [self.view addSubview:kongView];
}

- (void)buttonClick:(UIButton *)buttonClick{
    UIButton *button;
    for (int i = 0; i<2; i++) {
        UIView * view = _viewArray[i];
        button = _buttonArray[i];
        if (buttonClick.tag == i) {
            view.hidden = NO;
//            button.tintColor = [UIColor redColor];
            
        }else{
            view.hidden = YES;
            button.tintColor = [UIColor blackColor];
        }
        
    }
    if (buttonClick.tag == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    if (buttonClick.tag == 1) {
        [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:NO];
    }
}
- (void)scroll{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            BaoXiuViewController *ml = [[BaoXiuViewController alloc] init];
            [_scrollView addSubview:ml.view];
            [self addChildViewController:ml];
        }
        if (i == 1) {
            XiuViewController *cvc = [[XiuViewController alloc] init];
            cvc.view.frame =CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            [_scrollView addSubview:cvc.view];
            [self addChildViewController:cvc];
            
        }
    }
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 127, self.view.frame.size.width, 2)];
    _pageControl.numberOfPages = 2;
    _pageControl.currentPage = 0;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.directionalLockEnabled = YES;
    
    _scrollView.bounces = NO;
    //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0,self.view.frame.size.width , 0);
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIButton *button;
    for (int i = 0; i<2; i++) {
        UIView * view = _viewArray[i];
        button = _buttonArray[i];
        if (scrollView.contentOffset.x ==self.view.bounds.size.width*i) {
            view.hidden = NO;
            button.tintColor = [UIColor greenColor];
            
        }else{
            view.hidden = YES;
            button.tintColor = [UIColor blackColor];
        }
        
    }
}
-(void)buttondesire{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
