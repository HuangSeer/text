//

//"areaName":"北京市",
//"common":true,
//"id":4521984,
//"level":0,
//"parentName":"中国",
//"pid":0,
//"sequence":0
#import <Foundation/Foundation.h>

@interface addressModel : NSObject

@property (nonatomic,strong)NSString *areaName;

@property (nonatomic,strong)NSString *common;

@property (nonatomic,strong)NSString *id;


@property (nonatomic,strong)NSString *level;

@property (nonatomic,strong)NSMutableArray *parentName;

@property (nonatomic,strong)NSString *pid;

@property (nonatomic,strong)NSMutableArray *sequence;

@end
