 //
//  WebClient.m
//  Weixinduokai
//
//  Created by 李刚 on 2017/6/13.
//  Copyright © 2017年 Mou. All rights reserved.
//

#import "WebClient.h"
#define WebService @"http://oa.ybqtw.org.cn"
//#define WebService @"http://192.168.1.222:8099"
@implementation WebClient
+ (instancetype)sharedClient{
    static WebClient *_shareClient = nil;
    static dispatch_once_t onctToken;
    dispatch_once(&onctToken,^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _shareClient = [[WebClient alloc] initWithBaseURL:[NSURL URLWithString:WebService] sessionConfiguration:configuration];
        _shareClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        AFJSONResponseSerializer *serial = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        serial.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        _shareClient.responseSerializer = serial;
        _shareClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _shareClient.requestSerializer.timeoutInterval = 10;
        [_shareClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
    });
    return _shareClient;
}
- (NSURLSessionDataTask *)post:(NSString *)urlString parmeters:(NSDictionary *) params complete:(responseBlock) block{
    NSString *url = [NSString stringWithFormat:@"%@%@",WebService,urlString];
   return  [self POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       if(block){
           block(responseObject,nil);
       }
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if(block){
           block(nil,error);
       }
   }];
    
}
- (NSURLSessionDataTask *)get:(NSString *)urlString parmeters:(NSDictionary *) params complete:(responseBlock) block{
    NSString *url = [NSString stringWithFormat:@"%@%@",WebService,urlString];
    return [self GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(block){
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(block){
            block(nil,error);
        }
        
    }];
}
//首页轮播图请求
-(void)getlod:(NSString *)tvinfoId Keys:(NSString *)key Deptid:(NSString *)deptid ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvinfoId forKey:@"Tvinfoid"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:deptid forKey:@"DeptId"];
    [parme setObject:@"6" forKey:@"PageSize"];
    [parme setObject:@"1" forKey:@"page"];
    [parme setObject:@"home" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//政务轮播图
-(void)getlod:(NSString *)tvinfoId Keys:(NSString *)key Depid:(NSString *)dpid Pagsize:(NSString *)pagsize Status:(NSString *)status ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];    
    [parme setObject:@"newlist" forKey:@"method"];
    [parme setObject:@"Pic" forKey:@"ClassId"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:tvinfoId forKey:@"TVInfoId"];
    [parme setObject:pagsize forKey:@"PageSize"];
    [parme setObject:@"1" forKey:@"page"];
    [parme setObject:status forKey:@"status"];
    [parme setObject:dpid forKey:@"DeptId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//首页垂直轮播
-(void)ChuiZhi:(NSString *)tvinfoId Keys:(NSString *)key Depid:(NSString *)dpid Pagsize:(NSString *)pagsize Status:(NSString *)status Page:(NSString *)page ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"newlist" forKey:@"method"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:tvinfoId forKey:@"TVInfoId"];
    [parme setObject:pagsize forKey:@"PageSize"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:status forKey:@"status"];
    [parme setObject:dpid forKey:@"DeptId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//党校轮播图
-(void)DangXiao:(NSString *)tvinfoId Keys:(NSString *)key Deptid:(NSString *)deptid ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"IndexNews" forKey:@"method"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:tvinfoId forKey:@"TVInfoId"];
    [parme setObject:@"6" forKey:@"PageSize"];
    [parme setObject:@"1" forKey:@"page"];
    [parme setObject:deptid forKey:@"DeptId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//办事指南
-(void)tvinfo:(NSString *)tvinfo Deptid:(NSString *)dept Keys:(NSString *)key ResponseBlock:(responseBlock) block{
    //TVInfoId=19&    deptId=851   Key=21218CCA77804D2BA1922C33E0151105&method=booking
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:dept forKey:@"deptId"];
    [parme setObject:@"booking" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
-(void)tvinfo:(NSString *)tvinfo Deptid:(NSString *)dept Keys:(NSString *)key NameId:(NSString *)nid Date:(NSString *)date ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:key forKey:@"Key"];
    [parme setObject:dept forKey:@"deptId"];
    [parme setObject:@"booking" forKey:@"method"];
    [parme setObject:nid forKey:@"id"];
    [parme setObject:date forKey:@"date"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//登录
-(void)userName:(NSString *)name PassWodr:(NSString *)passwode ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:name forKey:@"userName"];
    [parme setObject:passwode forKey:@"Pwd"];
    [parme setObject:@"disembark" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//二维码生成
-(void)Stard:(NSString *)sta ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"getpadvar" forKey:@"method"];
    [parme setObject:sta forKey:@"typeVer"];
    [self get:@"/api/GetAppVar.aspx" parmeters:parme complete:block];
}
//注销
-(void) GetId:(NSString *)getid ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:getid forKey:@"id"];
    [parme setObject:@"disembarkout" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//修改手机号
-(void)Iphone:(NSString *)iphone Tvinfo:(NSString *)tvionf Keys:(NSString *)keys UserId:(NSString *)userid ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvionf forKey:@"TVInfoId"];
    [parme setObject:@"resetphone" forKey:@"method"];
    [parme setObject:keys forKey:@"key"];
    [parme setObject:userid forKey:@"UserId"];
    [parme setObject:iphone forKey:@"Phone"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//获取验证码
-(void)YZMIphone:(NSString *)iphone tvinfo:(NSString *)tvifo keys:(NSString *)keys  ResponseBlock:(responseBlock) block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvifo forKey:@"TVInfoId"];
    [parme setObject:@"Short" forKey:@"method"];
    [parme setObject:keys forKey:@"key"];
    [parme setObject:@"1" forKey:@"YZ"];
    [parme setObject:iphone forKey:@"Phone"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//注册
-(void)userName:(NSString *)name PassWodr:(NSString *)passwode Iphone:(NSString *)iphone Deptid:(NSString *)deptid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:@"Register" forKey:@"method"];
    [parme setObject:name forKey:@"userName"];
    [parme setObject:passwode forKey:@"pwd"];
    [parme setObject:iphone forKey:@"Phone"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//method=forgotpwd&TVInfoId=&Key=&phone=&     newpass
//找回密码
-(void)NewPass:(NSString *)pass Phone:(NSString *)phone Tvinfo:(NSString *)tvinfo keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:pass forKey:@"newpwd"];
    [parme setObject:@"forgotpwd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:phone forKey:@"Phone"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//修改头像
-(void)Tvinfo:(NSString *)tvinfo keys:(NSString *)keys userid:(NSString *)useid headimg:(NSString *)headimg ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:@"headportrait" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:headimg forKey:@"headimg"];
    [parme setObject:useid forKey:@"useid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//修改密码
-(void)NewPwd:(NSString *)newpwd Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid Pwd:(NSString *)pwd ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:@"changepwd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:userid forKey:@"UserId"];
    [parme setObject:newpwd forKey:@"NewPwd"];
    [parme setObject:pwd forKey:@"Pwd"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业消息
-(void)aPagesi:(NSString *)pages aPage:(NSString *)page aKeys:(NSString *)keys aTVinfo:(NSString *)tvinfo aDeptd:(NSString *)depd aUserId:(NSString *)userid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"propertynotice" forKey:@"method"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:keys forKey:@"Key"];
     [parme setObject:userid forKey:@"userid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//小区绑定
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"binding" forKey:@"method"];
    [parme setObject:dept forKey:@"DeptId"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvifo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//小区绑定1
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo Xqid:(NSString *)xqid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"binding" forKey:@"method"];
    [parme setObject:dept forKey:@"DeptId"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvifo forKey:@"TVInfoId"];
    [parme setObject:xqid forKey:@"xqid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//小区绑定2
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo Xqid:(NSString *)xqid Infoid:(NSString *)infoid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"binding" forKey:@"method"];
    [parme setObject:dept forKey:@"DeptId"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvifo forKey:@"TVInfoId"];
    [parme setObject:infoid forKey:@"infoid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//提交认证
-(void)Hid:(NSString *)hid TVinfo:(NSString *)tvifo Lid:(NSString *)lid Userid:(NSString *)userid Keys:(NSString *)keys ResponseBlock:(responseBlock)block
{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"housebinding" forKey:@"method"];
    [parme setObject:userid forKey:@"Useid"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvifo forKey:@"TVInfoId"];
    [parme setObject:hid forKey:@"Hid"];
    [parme setObject:lid forKey:@"Lxid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//热门话题
-(void)Userid:(NSString *)userid Keys:(NSString *)keys Tvinfo:(NSString *)tvinfo pages:(NSString *)pagesize page:(NSString *)page  ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"title" forKey:@"method"];
    [parme setObject:userid forKey:@"userid"];
    [parme setObject:keys forKey:@"Key"];
      [parme setObject:page forKey:@"page"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//身份选择
-(void)Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"ownertype" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业公告
-(void)Page:(NSString *)page PageSize:(NSString *)pagesize DePtid:(NSString *)deptid Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"anncounce" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [parme setObject:deptid forKey:@"deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业缴费
-(void)ChaUserId:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"propertylog" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"userid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业推荐
-(void)TuiJie:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)useid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Recommended" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:useid forKey:@"userid"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [parme setObject:page forKey:@"page"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业公示
-(void)Gongshi:(NSString *)tvinfo Keys:(NSString *)keys DptId:(NSString *)deid MobileNo:(NSString *)mobi UserName:(NSString *)username pages:(NSString *)pagesize Page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"OpinionList" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:username forKey:@"UserName"];
    [parme setObject:deid forKey:@"DptId"];
    
    [parme setObject:mobi forKey:@"MobileNo"];
    [parme setObject:@"6" forKey:@"OpinionClassId"];
    [parme setObject:pagesize forKey:@"PageSize"];
    [parme setObject:page forKey:@"Page"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业处理公示详情
-(void)XQgongshi:(NSString *)tvinfo Keys:(NSString *)keys AId:(NSString *)aid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"OpinionShow" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:@"" forKey:@"Action"];
    [parme setObject:aid forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//物业的头
-(void)touWu:(NSString *)MyId ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"information" forKey:@"method"];
    [parme setObject:MyId forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//留言
-(void)LiuYan:(NSString *)tvinfo Deid:(NSString *)deptid Keys:(NSString *)keys UserId:(NSString *)userid Content:(NSString *)content ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"guestbook" forKey:@"method"];
    [parme setObject:userid forKey:@"UserId"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:deptid forKey:@"deptid"];
    [parme setObject:content forKey:@"Content"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//故障类型  有多少个
-(void)LeiXin:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"faultsort" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//提交一键报修
-(void)TJyijian:(NSString *)tvinfo Keys:(NSString *)keys MyId:(NSString *)myid Lxid:(NSString *)lxid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"warranty" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:myid forKey:@"id"];
    [parme setObject:tvinfo forKey:@"lxid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//
-(void)toupiao:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo id:(NSString *)id ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"NewVotes" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"userid"];
    [parme setObject:id forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
-(void)toup:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo id:(NSString *)id ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"VotesLoging" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"userid"];
    [parme setObject:id forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//户型请求
-(void)ResponhouseseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc]initWithCapacity:0];
    [parme setObject:@"house" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//托管类型
-(void)ResponleixseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc]initWithCapacity:0];
    [parme setObject:@"Hosteds" forKey:@"method"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//新增物业托管
-(void)wytoug:(NSString *)Sid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo Deptid:(NSString *)Deptid Information:(NSString*)Information  Area:(NSString*)Area Rent:(NSString *)Rent Url:(NSString *)Url Charge:(NSString *)Charge
          Hid:(NSString*)Hid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"hostedadd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:Sid forKey:@"Sid"];
    [parme setObject:Deptid forKey:@"Deptid"];
    
    [parme setObject:Information forKey:@"Information"];
    [parme setObject:Area forKey:@"Area"];
    [parme setObject:Rent forKey:@"Rent"];
    [parme setObject:Url forKey:@"Url"];
    [parme setObject:Charge forKey:@"Charge"];
    [parme setObject:Hid forKey:@"Hid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//新增物业车位托管
-(void)wytougche:(NSString *)Sid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo Deptid:(NSString *)Deptid Information:(NSString*)Information   Rent:(NSString *)Rent Url:(NSString *)Url Charge:(NSString *)Charge
   ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"hostedadd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:Sid forKey:@"Sid"];
    [parme setObject:Deptid forKey:@"Deptid"];
    
    [parme setObject:Information forKey:@"Information"];
    [parme setObject:Rent forKey:@"Rent"];
    [parme setObject:Url forKey:@"Url"];
    [parme setObject:Charge forKey:@"Charge"];
    
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//故障紧急程度
-(void)ChenDu:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Faulthow" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//故障类型
-(void)GuZleiX:(NSString *)tvinfotwo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"FaultSort" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfotwo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//公共故障报修提交
-(void)GGfugz:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo content:(NSString *)content type:(NSString*)type   level:(NSString *)level img:(NSString *)img ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"breakadd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:content forKey:@"content"];
    [parme setObject:type forKey:@"type"];
    [parme setObject:level forKey:@"level"];
    [parme setObject:img forKey:@"img"];
    [parme setObject:userid forKey:@"userId"];
    
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
    
}
//诉求问题显示列表
-(void)suqiuWT:(NSString *)tvinfo Keys:(NSString *)keys pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"OpinionClass" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [parme setObject:page forKey:@"page"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//诉求部门列表
-(void)suqiubmen:(NSString *)tvinfo Keys:(NSString *)keys pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"deptlist" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [parme setObject:page forKey:@"page"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//手机获取验证码
-(void)ShoujYZ:(NSString *)tvinfo Keys:(NSString *)keys phone:(NSString *)phone YZ:(NSString *)YZ ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"short" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:phone forKey:@"phone"];
    [parme setObject:YZ forKey:@"YZ"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//诉求提交
-(void)SQtjiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)Deptid UserName:(NSString *)UserName  Title:(NSString *)Title Content:(NSString *)Content MobileNo:(NSString *)MobileNo  OpinionClassId:(NSString *)OpinionClassId Visible:(NSString *)Visible  SMS:(NSString *)SMS Opinionid:(NSString *)Opinionid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"OpinionAdd1" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:Deptid forKey:@"Deptid"];
    [parme setObject:UserName forKey:@"UserName"];
    [parme setObject:Visible forKey:@"Visible"];
    [parme setObject:Title forKey:@"Title"];
    [parme setObject:SMS forKey:@"SMS"];
    [parme setObject:Opinionid forKey:@"Opinionid"];
    [parme setObject:OpinionClassId forKey:@"OpinionClassId"];
    [parme setObject:MobileNo forKey:@"MobileNo"];
    [parme setObject:Content forKey:@"Content"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//办事攻略 李
-(void)GongLie:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"strategy" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//党员风采 李
-(void)FengCai:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"pioneer" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//党群活动
-(void)HuoDong:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"activities" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//办事指南  next三 李
-(void)BanShiNext:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ChuanID:(NSString *)nextId ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"BSZL" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:nextId forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//办事指南  next二 李
-(void)BanShibiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ChuanID:(NSString *)nextId ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"bszl" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:nextId forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//结果查询
-(void)ChaXun:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Page:(NSString *)page Pagesize:(NSString *)pagesize UserName:(NSString *)username MobileNo:(NSString *)mobi ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"opinionlist" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:username forKey:@"UserName"];
    [parme setObject:mobi forKey:@"MobileNo"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:pagesize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//政务六项 李
-(void)ZWLiuXiang:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"sybszl" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//掌上党校 李
-(void)ZSDangXiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Sid:(NSString *)sid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"school" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"deptid"];
    [parme setObject:sid forKey:@"sid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//预约办事  表格到-选择器 李
-(void)XuanZeQi:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Time:(NSString *)time NewId:(NSString *)newid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"yuyue" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"deptid"];
    [parme setObject:newid forKey:@"id"];
    [parme setObject:time forKey:@"time"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//预约办事-》提交
-(void)BanShiTJ:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid EditDate:(NSString *)edit Period:(NSString *)peri UserName:(NSString *)uname MobileNo:(NSString *)phone HandleClassId:(NSString *)handid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"handleadd1" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"deptid"];
    [parme setObject:edit forKey:@"EditDate"];
    [parme setObject:peri forKey:@"Period"];
    [parme setObject:uname forKey:@"UserName"];
    [parme setObject:phone forKey:@"MobileNo"];
    [parme setObject:handid forKey:@"HandleClassId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//书记信箱事项类别
-(void)Docket:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Docket" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//书记类型接口
-(void)Secretary:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Secretary" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//书记信箱
-(void)Mailbox:(NSString *)tvinfo Keys:(NSString *)keys genre:(NSString *)genre docketid:(NSString *)docketid  title:(NSString *)title phone:(NSString *)phone Name:(NSString *)Name  content:(NSString *)content time:(NSString *)time  Deptid:(NSString *)Deptid secretaryid:(NSString *)secretaryid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Mailbox" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:Deptid forKey:@"Deptid"];
    [parme setObject:genre forKey:@"genre"];
    [parme setObject:docketid forKey:@"docketid"];
    [parme setObject:title forKey:@"title"];
    [parme setObject:phone forKey:@"phone"];
    [parme setObject:Name forKey:@"Name"];
    [parme setObject:content forKey:@"content"];
    [parme setObject:time forKey:@"time"];
    [parme setObject:secretaryid forKey:@"secretaryid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//组织概况
-(void)Organize:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid idcard:(NSString *)idcard ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Organize" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:idcard forKey:@"idcard"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//党员风采
-(void)pioneer:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid page:(NSString *)page Pagesize:(NSString *)pagesize ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"pioneer" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
      [parme setObject:page forKey:@"page"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//党群活动
//-(void)HuoDong:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block{
//    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
//    [parme setObject:@"activities" forKey:@"method"];
//    [parme setObject:keys forKey:@"Key"];
//    [parme setObject:tvinfo forKey:@"TVInfoId"];
//    [parme setObject:deptid forKey:@"Deptid"];
//    [parme setObject:page forKey:@"page"];
//    [parme setObject:pagesize forKey:@"pagesize"];
//    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
//}
//党员登陆
-(void)partylogin:(NSString *)idcard name:(NSString *)name LinkTel:(NSString *)LinkTel  ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"PartyLogin" forKey:@"method"];
    [parme setObject:idcard forKey:@"idcard"];
    [parme setObject:name forKey:@"name"];
    [parme setObject:LinkTel forKey:@"LinkTel"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//、党费查询
-(void)interface:(NSString *)tvinfo Keys:(NSString *)keys idcard:(NSString *)idcard name:(NSString *)name ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"interface" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:idcard forKey:@"idcard"];
    [parme setObject:name forKey:@"name"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//、入党申请书
-(void)Application:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid name:(NSString *)name idcard:(NSString *)idcard age:(NSString *)age unit:(NSString *)unit job:(NSString *)job content:(NSString *)content phone:(NSString *)phone levelId:(NSString *)levelId nationId:(NSString *)nationId ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"application" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"deptid"];
    [parme setObject:name forKey:@"name"];
    [parme setObject:idcard forKey:@"idcard"];
    [parme setObject:age forKey:@"age"];
    [parme setObject:unit forKey:@"unit"];
    [parme setObject:job forKey:@"job"];
    [parme setObject:content forKey:@"content"];
    [parme setObject:phone forKey:@"phone"];
    [parme setObject:levelId forKey:@"levelId"];
    [parme setObject:nationId forKey:@"nationId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
    //http://192.168.1.222:8099/api/APP1.0.aspx?method=application&TVInfoId=&Key=&deptid=&name=&idcard=&age=&unit=&job=&content=
}
//专业
-(void)culturelevel:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"culturelevel" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//名族
-(void)nation:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"nation" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//反腐倡廉
-(void)Corruption:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  page:(NSString *)page Pagesize:(NSString *)pagesize ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"Corruption" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//帮扶政策
-(void)JZBF:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"JZBF" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//帮扶政策
-(void)BFZC:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"BFZC" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//帮扶力量
-(void)BFLL:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    
    
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"BFLL" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//帮扶对象
-(void)BFDX:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"BFDX" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//帮扶活动
-(void)BFHD:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"BFHD" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//社区概况
-(void)IndexNews:(NSString *)tvinfo Keys:(NSString *)keys Page:(NSString *)Page Deptid:(NSString *)Deptid  PageSize:(NSString *)PageSize ClassId:(NSString *)ClassId ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"IndexNews" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:Deptid forKey:@"Deptid"];
    [parme setObject:PageSize forKey:@"PageSize"];
    [parme setObject:ClassId forKey:@"ClassId"];
    [parme setObject:Page forKey:@"Page"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//党员管理系统
-(void)party:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid shzt:(NSString *)shzt ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"party" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"Deptid"];
    [parme setObject:shzt forKey:@"shzt"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//修改昵称
-(void)NiChen:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid nickName:(NSString *)neckname ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"appnickname" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:deptid forKey:@"userId"];
    [parme setObject:neckname forKey:@"nickname"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//车位锁查询
-(void)CWSuo:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid PageSize:(NSString *)PageSize Page:(NSString *)page ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"parkinglock" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"userid"];
    [parme setObject:page forKey:@"page"];
    [parme setObject:PageSize forKey:@"pagesize"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//车位锁添加
-(void)CWSuoTianjia:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid Name:(NSString *)name Num:(NSString *)num ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"carlockadd" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"userid"];
    [parme setObject:name forKey:@"name"];
    [parme setObject:num forKey:@"num"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//车位锁修改
-(void)CWSuoRevise:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid LockAddress:(NSString *)lockAddress ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"lockupdate" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"id"];
    [parme setObject:lockAddress forKey:@"lockName"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
}
//车位锁删除
-(void)CWSuoDelete:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"lockremoval" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:userid forKey:@"id"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}
//判断未完成的是否显示
-(void)PanDuan:(NSString *)tvinfo Keys:(NSString *)keys State:(NSString *)state ResponseBlock:(responseBlock)block{
    NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parme setObject:@"copewith" forKey:@"method"];
    [parme setObject:keys forKey:@"Key"];
    [parme setObject:tvinfo forKey:@"TVInfoId"];
    [parme setObject:state forKey:@"state"];
    [self get:@"/api/APP1.0.aspx" parmeters:parme complete:block];
    
}










/**  方法列子
 - (void)方法名：（参数一）参数 ResponseBlock:(responseBlock) block{
     NSMutableDictionary *parme = [[NSMutableDictionary alloc] initWithCapacity:0];
     [parme setObject:参数 forKey:@"参数名"];
     [self get:@"/Order/get.html" parmeters:parme complete:block]; // get post 请求根据实际情况选择
 }
 */
@end
