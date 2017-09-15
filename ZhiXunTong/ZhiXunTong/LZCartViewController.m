//
//  LZCartViewController.m
//  LZCartViewController
//

#import "LZCartViewController.h"
#import "LZConfigFile.h"
#import "LZCartTableViewCell.h"
#import "LZShopModel.h"
#import "LZGoodsModel.h"
#import "LZTableHeaderView.h"
#import "PchHeader.h"
#import "LoginViewController.h"
#import "QueRxDViewController.h"


@interface LZCartViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isHiddenNavigationBarWhenDisappear;//记录当页面消失时是否需要隐藏系统导航
    BOOL _isHasTabBarController;//是否含有tabbar
    BOOL _isHasNavitationController;//是否含有导航
    NSMutableDictionary *userinfo;
    NSString *phone;
    NSString *cookiestr;
    NSString *integral;
    NSMutableArray *sparray;
}

@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@end

@implementation LZCartViewController

#pragma mark - viewController life cicle
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden=YES;
    
    self.navigationController.navigationBarHidden=NO;//隐藏导航栏
    [self.dataArray removeAllObjects];
    [_selectedArray removeAllObjects];
    [self loadData];
    self.navigationItem.title=@"购物车";
   
}

- (void)loadData {
    if (userinfo.count>0) {
        NSString *strurlphone=[NSString stringWithFormat:@"%@thirdPartyLogin.htm?mobileNum=%@",URLds,phone];
        NSLog(@"%@",strurlphone);
        [ZQLNetWork getWithUrlString:strurlphone success:^(id data) {
            NSLog(@"%@==bb==",data);
            NSString *strurlfl=[NSString stringWithFormat:@"%@cart_menu_detail.htm",URLds];
            NSString *aa=[NSString stringWithFormat:@"%@",[data objectForKey:@"statusCode"] ];
            if ([aa containsString:@"200"]) {
                NSString *strurlfl=[NSString stringWithFormat:@"%@cart_menu_detail.htm",URLds];
                NSLog(@"%@",strurlfl);
                [ZQLNetWork getWithUrlString:strurlfl success:^(id data) {
                    NSLog(@"sad===2==2=2=2========%@",data);
                    NSArray *array = [data objectForKey:@"data"];
                    if (array.count > 0) {
                        for (NSDictionary *dic in array) {
                            LZShopModel *model = [[LZShopModel alloc]init];
                            model.shopID = [dic valueForKey:@"storeCart_id"];
                            model.shopName = [dic  valueForKey:@"store_name"];
                            model.sID=[dic valueForKey:@"store_id"];
                            [model configGoodsArrayWithArray:[dic objectForKey:@"gcs"]];
                            
                            [self.dataArray addObject:model];
                            [_myTableView reloadData];
                            [self setupCustomBottomView];
                        }
                    }else{
                    
                    [_myTableView reloadData];
                    [self setupCustomBottomView];
                    }
                    
                    
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"获取品牌失败!!"];
                }];
            }
            else{
                
                
            }
        } failure:^(NSError *error) {
        }];
    }else{
        
        LoginViewController *login=[[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:NO];
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=YES;
        
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 16, 10, 18)];
    [backItem setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(btnCkmore) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem *leftItemBar = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    [self.navigationItem setLeftBarButtonItem:leftItemBar];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    userinfo=[userDefaults objectForKey:UserInfo];
    NSMutableArray *arry=[NSMutableArray arrayWithCapacity:0];
    userDefaults= [NSUserDefaults standardUserDefaults];
    arry=[userinfo objectForKey:@"Data"];
    
    phone=[[arry objectAtIndex:0] objectForKey:@"phone"];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _isHasTabBarController = self.tabBarController?YES:NO;
    _isHasNavitationController = self.navigationController?YES:NO;
    sparray=[NSMutableArray arrayWithCapacity:0];
     [self setupCartView];
//      [self loadData];
   
  
}
-(void)btnCkmore
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    if (_isHiddenNavigationBarWhenDisappear == YES) {
        self.navigationController.navigationBarHidden = NO;
    }
}

/**
 *  @author LQQ, 16-02-18 11:02:16
 *
 *  计算已选中商品金额
 */
-(void)countPrice {
    double totlePrice = 0.0;
    
    for (LZGoodsModel *model in self.selectedArray) {
        
        double price = [model.price doubleValue];
        
        totlePrice += price * model.count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.attributedText = [self LZSetString:string];
}

#pragma mark - 初始化数组
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectedArray;
}

#pragma mark - 布局页面视图

#pragma mark -- 自定义底部视图 
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = LZColorFromRGB(245, 245, 245);
    backgroundView.tag = TAG_CartEmptyView + 1;
    [self.view addSubview:backgroundView];
    
    //当有tabBarController时,在tabBar的上面
    if (_isHasTabBarController == YES) {
        backgroundView.frame = CGRectMake(0,self.view.frame.size.height-LZTabBarHeight, LZSCREEN_WIDTH, LZTabBarHeight);
    } else {
        backgroundView.frame = CGRectMake(0,self.view.frame.size.height-LZTabBarHeight, LZSCREEN_WIDTH, LZTabBarHeight);
    }
    
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 0, LZSCREEN_WIDTH, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    
    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, LZTabBarHeight - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:lz_Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = BASECOLOR_RED;
    btn.frame = CGRectMake(LZSCREEN_WIDTH - 80, 0, 80, LZTabBarHeight);
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor redColor];
    [backgroundView addSubview:label];
    
    label.attributedText = [self LZSetString:@"¥0.00"];
    CGFloat maxWidth = LZSCREEN_WIDTH - selectAll.bounds.size.width - btn.bounds.size.width - 30;
//    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, LZTabBarHeight)];
    label.frame = CGRectMake(selectAll.bounds.size.width + 20, 0, maxWidth - 10, LZTabBarHeight);
    self.totlePriceLabel = label;
}

- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}


#pragma mark -- 购物车有商品时的视图
- (void)setupCartView {
    //创建底部视图
    [self setupCustomBottomView];
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    table.delegate = self;
    table.dataSource = self;
    
    table.rowHeight = lz_CartRowHeight;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = LZColorFromRGB(245, 246, 248);
    [self.view addSubview:table];
    self.myTableView = table;
    
//    if (_isHasTabBarController) {
//        table.frame = CGRectMake(0, 0, LZSCREEN_WIDTH,self.view.frame.size.height-LZTabBarHeight);
//    } else {
        table.frame = CGRectMake(0, 0, LZSCREEN_WIDTH, LZSCREEN_HEIGHT - LZNaigationBarHeight - LZTabBarHeight);
//    }
    
    [table registerClass:[LZTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"LZHeaderView"];
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LZShopModel *model = [self.dataArray objectAtIndex:section];
    return model.goodsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCartReusableCell"];
    if (cell == nil) {
        cell = [[LZCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LZCartReusableCell"];
    }
    
    LZShopModel *shopModel = self.dataArray[indexPath.section];
    
    LZGoodsModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
    
    __block typeof(cell)wsCell = cell;
    
    [cell numberAddWithBlock:^(NSInteger number) {
        wsCell.lzNumber = number;
        model.count = number;
        NSString *strnumber=[NSString stringWithFormat:@"%ld",number];
        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
       
        NSString *strurl=[NSString stringWithFormat:@"%@add_goods_count.htm?count=%@&cart_goods_id=%@&store_id=%@",URLds,strnumber,model.goodsID,shopModel.sID];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"%@",data);
        
        } failure:^(NSError *error) {
        }];
    }];
    
    [cell numberCutWithBlock:^(NSInteger number) {
        
        wsCell.lzNumber = number;
        model.count = number;
       
         NSString *strnumber=[NSString stringWithFormat:@"%ld",number];
        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
          NSLog(@"%@",shopModel.shopID);
       
        NSString *strurl=[NSString stringWithFormat:@"%@add_goods_count.htm?count=%@&cart_goods_id=%@&store_id=%@",URLds,strnumber,model.goodsID,shopModel.sID];
        [ZQLNetWork getWithUrlString:strurl success:^(id data) {
            NSLog(@"%@",data);
            
        } failure:^(NSError *error) {
        }];

    }];
    
    [cell cellSelectedWithBlock:^(BOOL select) {
        
        model.select = select;
        if (select) {
            
            if (self.selectedArray.count==0) {
            [sparray addObject:shopModel.shopID];
                 NSLog(@"bb========%@",sparray);
            }
            
            [self.selectedArray addObject:model];

          
        } else {
    
            
            if (self.selectedArray.count==1) {
            
                    
                    [sparray removeObject:shopModel.shopID];
                NSLog(@"删除成功%@",sparray);
            }
            
              [self.selectedArray removeObject:model];
        }
        
        [self verityAllSelectState];
        [self verityGroupSelectState:indexPath.section];
        
        [self countPrice];
    }];
    
    [cell reloadDataWithModel:model];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LZTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LZHeaderView"];
    LZShopModel *model = [self.dataArray objectAtIndex:section];

    NSLog(@">>>>>>%d", model.select);
  
    view.title = model.shopName;
    
    view.select = model.select;
    view.lzClickBlock = ^(BOOL select) {
        model.select = select;
        
        if (select) {
         
                [sparray addObject:model.shopID];
                 NSLog(@"bb========%@",sparray);
            
           
            for (LZGoodsModel *good in model.goodsArray) {
                good.select = YES;
                if (![self.selectedArray containsObject:good]) {
                    
                    [self.selectedArray addObject:good];
                }
            }
            
        } else {
                    [sparray removeObject:model.shopID];
                    NSLog(@"删除成功%@",sparray);

            for (LZGoodsModel *good in model.goodsArray) {
                good.select = NO;
                if ([self.selectedArray containsObject:good]) {
                    
                    [self.selectedArray removeObject:good];
                }
            }
        }
        
        [self verityAllSelectState];

        [tableView reloadData];
        [self countPrice];
    };
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return LZTableViewHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LZShopModel *shop = [self.dataArray objectAtIndex:indexPath.section];
            LZGoodsModel *model = [shop.goodsArray objectAtIndex:indexPath.row];
            
            [shop.goodsArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSString *strurl=[NSString stringWithFormat:@"%@remove_goods_cart.htm?goodsCart_id=%@&store_id=%@",URLds,model.goodsID,shop.sID];
            [ZQLNetWork getWithUrlString:strurl success:^(id data) {
                NSLog(@"%@",data);
                NSString *msg=[data objectForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
            } failure:^(NSError *error) {
                NSLog(@"---------------%@",error);
                [SVProgressHUD showErrorWithStatus:@"数据请求失败!!"];
            }];
            
            if (shop.goodsArray.count == 0) {
                [self.dataArray removeObjectAtIndex:indexPath.section];
            }
            
            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }
            
            NSInteger count = 0;
            for (LZShopModel *shop in self.dataArray) {
                count += shop.goodsArray.count;
            }
            
            if (self.selectedArray.count == count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }
            
            if (count == 0) {
           
            }
            
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)reloadTable {
    [self.myTableView reloadData];
}
//#pragma mark -- 页面按钮点击事件
//#pragma mark --- 返回按钮点击事件
//- (void)backButtonClick:(UIButton*)button {
//    if (_isHasNavitationController == NO) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (LZGoodsModel *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (button.selected) {
        
        for (LZShopModel *shop in self.dataArray) {
            [sparray addObject:shop.shopID];
             NSLog(@"add成功%@",sparray);
            shop.select = YES;
            for (LZGoodsModel *model in shop.goodsArray) {
                model.select = YES;
                [self.selectedArray addObject:model];
                
            }
                  NSLog(@"2-----2--2-2-2--2-2-2------2--2-------%@",shop.shopID);
        }
  
    } else {
        [sparray removeAllObjects];
         NSLog(@"删除成功%@",sparray);
        for (LZShopModel *shop in self.dataArray) {
            shop.select = NO;
        }
    }
    
    [self.myTableView reloadData];
    [self countPrice];
}
#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
    if (self.selectedArray.count > 0) {
        
        LZShopModel *shopmodel;
        LZGoodsModel *model;
        NSString *strstoreCart_id;
        NSMutableArray *goodsidarray=[NSMutableArray arrayWithCapacity:0];
      for (model in self.selectedArray) {
                [goodsidarray addObject:model.goodsID];
    
            }
        for (shopmodel in self.dataArray) {
        
            strstoreCart_id=[NSString stringWithFormat:@"%@",shopmodel.shopID];
      
        }
        NSString *string = [goodsidarray componentsJoinedByString:@","];
        NSString *strurljs=[NSString stringWithFormat:@"%@goods_balance.htm?goods_id=%@",URLds,string];
        NSLog(@"%@",strurljs);
        [ZQLNetWork getWithUrlString:strurljs success:^(id data) {
            NSLog(@"===%@",data);
            NSString *cart_session=[data objectForKey:@"cart_session"];
            NSString *msg=[data objectForKey:@"msg"];
            QueRxDViewController *QueRxDVi=[[QueRxDViewController alloc]init];
            QueRxDVi.Cmodarry=[data objectForKey:@"data"];
             QueRxDVi.Cyhqarry=[data objectForKey:@"coupon"];
            QueRxDVi.cart_session=cart_session;
             QueRxDVi.goods_id=string;
            [self.navigationController pushViewController:QueRxDVi animated:NO];
            self.navigationController.navigationBarHidden=NO;
            self.tabBarController.tabBar.hidden=YES;
            
        } failure:^(NSError *error) {
            NSLog(@"---------------%@",error);
            [SVProgressHUD showErrorWithStatus:@"失败!!"];
        }];
    } else {
        NSLog(@"你还没有选择任何商品");
    }
    
}

- (void)verityGroupSelectState:(NSInteger)section {
    
    // 判断某个区的商品是否全选
    LZShopModel *tempShop = self.dataArray[section];
    // 是否全选标示符
    BOOL isShopAllSelect = YES;
    for (LZGoodsModel *model in tempShop.goodsArray) {
        // 当有一个为NO的是时候,将标示符置为NO,并跳出循环
        if (model.select == NO) {
            isShopAllSelect = NO;
            break;
        }
    }
    
    LZTableHeaderView *header = (LZTableHeaderView *)[self.myTableView headerViewForSection:section];
    header.select = isShopAllSelect;
    tempShop.select = isShopAllSelect;
}

- (void)verityAllSelectState {
    
    NSInteger count = 0;
    for (LZShopModel *shop in self.dataArray) {
        count += shop.goodsArray.count;
    }
    
    if (self.selectedArray.count == count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
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
