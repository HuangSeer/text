//
//  CouponViewController.m
//
//

#import "CouponViewController.h"
#import "PchHeader.h"
#import "CouponTableViewCell.h"
#import "YHqModel.h"
#import "MJExtension.h"

@interface CouponViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView ;
    NSMutableArray *kbarray;
    


}
@property(nonatomic,strong)NSMutableArray *YdhArray;
@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    kbarray=[NSMutableArray arrayWithCapacity:0];
//    _straarray=[NSMutableArray arrayWithCapacity:0];
    
    NSLog(@"%@",_Cyhqtwoarry);

    self.navigationItem.title=@"我的优惠券";

    _YdhArray=[YHqModel mj_objectArrayWithKeyValuesArray:_Cyhqtwoarry];
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

-(void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

       [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
   }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _YdhArray.count;
}
#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 118;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     YHqModel *YHqM=_YdhArray[indexPath.row];
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
   
    
    BOOL isbool = [_straarray containsObject: str];
    
//    if () {
//        cell.imgxgt.image=[UIImage imageNamed:@"q副本"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }else{
//        NSString *strbb=[NSString stringWithFormat:@"%ld",indexPath.row];
//        [kbarray addObject:strbb];
//    }
// 
    int a=[YHqM.coupon_order_amount intValue];
    int b=[_strprice intValue];

    
    if (isbool==1 || a>b ) {
        
        if (isbool==1){
            cell.imgxgt.image=[UIImage imageNamed:@"q@2x副本"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        }else{
        cell.imgxgt.image=[UIImage imageNamed:@"q副本"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    }else{
        NSString *strbb=[NSString stringWithFormat:@"%ld",indexPath.row];
        [kbarray addObject:strbb];
    }
  
    cell.YHqM=_YdhArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YHqModel *YHqM=_YdhArray[indexPath.row];
    NSString *straa=[NSString stringWithFormat:@"%ld",indexPath.row];
//    [straarray addObject:straa];
    NSLog(@"==22%@",_straarray);
    BOOL isbool = [kbarray containsObject:straa];
    if (isbool==1) {
        self.ceBackBlock(YHqM.coupon_id,YHqM.coupon_amount,straa); //1
        [self.navigationController popViewControllerAnimated:YES];
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
