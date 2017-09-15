//
//  LZShopModel.m
//  LZCartViewController
//
//  Created by Artron_LQQ on 16/5/31.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "LZShopModel.h"
#import "LZGoodsModel.h"

@implementation LZShopModel

- (void)configGoodsArrayWithArray:(NSArray*)array; {
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            LZGoodsModel *model = [[LZGoodsModel alloc]init];
            
            model.count = [[dic valueForKey:@"count"] integerValue];
            model.goodsID = [dic valueForKey:@"goods_id"];
            model.goodsName =[NSString stringWithFormat:@"%@", [dic valueForKey:@"goods_name"]];
            model.price = [NSString stringWithFormat:@"%@",[dic valueForKey:@"store_price"]];
            model.goods_current_price=[NSString stringWithFormat:@"%@",[dic valueForKey:@"goods_price"]];
            model.image =  [dic valueForKey:@"goods_img"];
            model.evaluate=[dic valueForKey:@"evaluate"];
             model.complaint=[dic valueForKey:@"complaint"];
            [dataArray addObject:model];
        }
        
        _goodsArray = [dataArray mutableCopy];
    }
}
@end
