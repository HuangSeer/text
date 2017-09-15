//
//  JudgeViewController.m
//  ZhiXunTong
//
//  Created by Mou on 2017/8/11.
//  Copyright © 2017年 airZX. All rights reserved.
//

#import "JudgeViewController.h"
#import "PchHeader.h"
#import "JudegeTableViewCell.h"
#import "OrderModel.h"
#import "PJXiangQingViewController.h"
@interface JudgeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableDictionary *bbArray;
}

@end

@implementation JudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"评价列表";
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height)];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _saveArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JudegeTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"JudegeTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    bbArray=[_saveArray objectAtIndex:indexPath.row];
    cell.Judege_lab.text=[NSString stringWithFormat:@"%@",[bbArray objectForKey:@"goods_name"]];
    cell.Judege_lab.font=[UIFont systemFontOfSize:13];
    cell.Judege_lab.numberOfLines=2;
    [cell.judege_img sd_setImageWithURL:[NSURL URLWithString:[bbArray objectForKey:@"goods_img"]] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    NSString *evaluate=[bbArray objectForKey:@"evaluate"];
    int ev=[evaluate intValue];
    if (ev==0) {
        NSLog(@"000");
        [cell.Judege_btn setTitle:@"未评价" forState:UIControlStateNormal];
        //cell.Judege_btn.backgroundColor=[UIColor redColor];
        cell.Judege_btn.layer.borderWidth = 1;
        cell.Judege_btn.layer.borderColor=[UIColor redColor].CGColor;
        cell.Judege_btn.tag=indexPath.row;
        [cell.Judege_btn addTarget:self action:@selector(Pingjia:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        NSLog(@"111");
        cell.Judege_btn.backgroundColor=[UIColor grayColor];
        [cell.Judege_btn setTitle:@"已评价" forState:UIControlStateNormal];
        [cell.Judege_btn addTarget:self action:@selector(tishi) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tishi{
    [SVProgressHUD showErrorWithStatus:@"您已经评价过了"];
}
-(void)Pingjia:(UIButton *)sender{
    NSLog(@"去评价");
    bbArray=[_saveArray objectAtIndex:sender.tag];
    NSLog(@"%@",[bbArray objectForKey:@"goods_img"]);
    NSLog(@"%@",[bbArray objectForKey:@"goods_name"]);
    NSLog(@"%@------%@",[bbArray objectForKey:@"goods_id"],_Oid);
    PJXiangQingViewController *PGDetails=[[PJXiangQingViewController alloc] init];
    PGDetails.PG_id=_Oid;
    PGDetails.PG_img=[bbArray objectForKey:@"goods_img"];
    PGDetails.PG_name=[bbArray objectForKey:@"goods_name"];
    PGDetails.pg_price=[bbArray objectForKey:@"price"];
    PGDetails.pg_good_id=[bbArray objectForKey:@"goods_id"];
    PGDetails.PG_count=[bbArray objectForKey:@"count"];
    [self.navigationController pushViewController:PGDetails animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
