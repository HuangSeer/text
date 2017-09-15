//
//  WebClient.h
//  Weixinduokai
//
//  Created by 王林 on 2017/6/13.
//  Copyright © 2017年 Mou. All rights reserved.
//

#import "AFHTTPSessionManager.h"
typedef void (^responseBlock)(id resultObject,NSError *error);

@interface WebClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
/**  方法列子
- (void)方法名：（参数一）参数 ResponseBlock:(responseBlock) block;
 */
//首页轮播图
-(void)getlod:(NSString *)tvinfoId Keys:(NSString *)key Deptid:(NSString *)deptid ResponseBlock:(responseBlock) block;
//政务轮播图
-(void)getlod:(NSString *)tvinfoId Keys:(NSString *)key Depid:(NSString *)dpid Pagsize:(NSString *)pagsize Status:(NSString *)status ResponseBlock:(responseBlock) block;
//首页垂直轮播
-(void)ChuiZhi:(NSString *)tvinfoId Keys:(NSString *)key Depid:(NSString *)dpid Pagsize:(NSString *)pagsize Status:(NSString *)status Page:(NSString *)page ResponseBlock:(responseBlock) block;
//党校轮播图
-(void)DangXiao:(NSString *)tvinfoId Keys:(NSString *)key Deptid:(NSString *)deptid ResponseBlock:(responseBlock) block;
//预约办事
-(void)tvinfo:(NSString *)tvinfo Deptid:(NSString *)dept Keys:(NSString *)key ResponseBlock:(responseBlock) block;

-(void)tvinfo:(NSString *)tvinfo Deptid:(NSString *)dept Keys:(NSString *)key NameId:(NSString *)nid Date:(NSString *)date ResponseBlock:(responseBlock) block;
//登录
-(void)userName:(NSString *)name PassWodr:(NSString *)passwode ResponseBlock:(responseBlock) block;
//二维码生成
-(void)Stard:(NSString *)sta ResponseBlock:(responseBlock)block;
//注销
-(void)GetId:(NSString *)getid ResponseBlock:(responseBlock) block;
//修改手机号
-(void)Iphone:(NSString *)iphone Tvinfo:(NSString *)tvionf Keys:(NSString *)keys UserId:(NSString *)userid ResponseBlock:(responseBlock) block;
//获取验证码
-(void)YZMIphone:(NSString *)iphone tvinfo:(NSString *)tvifo keys:(NSString *)keys  ResponseBlock:(responseBlock) block;
//注册
-(void)userName:(NSString *)name PassWodr:(NSString *)passwode Iphone:(NSString *)iphone Deptid:(NSString *)deptid ResponseBlock:(responseBlock)block;
//找回密码
-(void)NewPass:(NSString *)pass Phone:(NSString *)phone Tvinfo:(NSString *)tvinfo keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//修改头像
-(void)Tvinfo:(NSString *)tvinfo keys:(NSString *)keys userid:(NSString *)useid headimg:(NSString *)headimg ResponseBlock:(responseBlock)block;
//修改密码
-(void)NewPwd:(NSString *)newpwd Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid Pwd:(NSString *)pwd ResponseBlock:(responseBlock)block;
//物业消息
-(void)aPagesi:(NSString *)pages aPage:(NSString *)page aKeys:(NSString *)keys aTVinfo:(NSString *)tvinfo aDeptd:(NSString *)depd aUserId:(NSString *)userid ResponseBlock:(responseBlock)block;
//小区绑定
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo ResponseBlock:(responseBlock)block;
//小区绑定1
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo Xqid:(NSString *)xqid ResponseBlock:(responseBlock)block;
//小区绑定2
-(void)BiDepd:(NSString *)dept Keys:(NSString *)keys TVinfo:(NSString *)tvifo Xqid:(NSString *)xqid Infoid:(NSString *)infoid ResponseBlock:(responseBlock)block;
//提交认证
-(void)Hid:(NSString *)hid TVinfo:(NSString *)tvifo Lid:(NSString *)lid Userid:(NSString *)userid Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//热门话题
-(void)Userid:(NSString *)userid Keys:(NSString *)keys Tvinfo:(NSString *)tvinfo pages:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;

//身份选择
-(void)Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//物业公告
-(void)Page:(NSString *)page PageSize:(NSString *)pagesize DePtid:(NSString *)deptid Tvinfo:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//物业缴费
-(void)ChaUserId:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo ResponseBlock:(responseBlock)block;
//物业推荐
-(void)TuiJie:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)useid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//物业处理公示
-(void)Gongshi:(NSString *)tvinfo Keys:(NSString *)keys DptId:(NSString *)deid MobileNo:(NSString *)mobi UserName:(NSString *)username pages:(NSString *)pagesize Page:(NSString *)page ResponseBlock:(responseBlock)block;
//物业处理公示详情
-(void)XQgongshi:(NSString *)tvinfo Keys:(NSString *)keys AId:(NSString *)aid ResponseBlock:(responseBlock)block;
//物业的头
-(void)touWu:(NSString *)MyId ResponseBlock:(responseBlock)block;
//留言
-(void)LiuYan:(NSString *)tvinfo Deid:(NSString *)deptid Keys:(NSString *)keys UserId:(NSString *)userid Content:(NSString *)content ResponseBlock:(responseBlock)block;
//故障类型  有多少个
-(void)LeiXin:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//提交一键报修
-(void)TJyijian:(NSString *)tvinfo Keys:(NSString *)keys MyId:(NSString *)myid Lxid:(NSString *)lxid ResponseBlock:(responseBlock)block;
//投票数据请求
-(void)toupiao:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo id:(NSString *)id ResponseBlock:(responseBlock)block;
//投票
-(void)toup:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo id:(NSString *)id ResponseBlock:(responseBlock)block;

//户型请求
-(void)ResponleixseBlock:(responseBlock)block;
-(void)ResponhouseseBlock:(responseBlock)block;
//新增物业托管
-(void)wytoug:(NSString *)Sid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo Deptid:(NSString *)Deptid Information:(NSString*)Information  Area:(NSString*)Area Rent:(NSString *)Rent Url:(NSString *)Url Charge:(NSString *)Charge
          Hid:(NSString*)Hid ResponseBlock:(responseBlock)block;

//新增物业托管
-(void)wytougche:(NSString *)Sid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo Deptid:(NSString *)Deptid Information:(NSString*)Information   Rent:(NSString *)Rent Url:(NSString *)Url Charge:(NSString *)Charge
   ResponseBlock:(responseBlock)block;

//故障紧急程度
-(void)ChenDu:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//故障类别
-(void)GuZleiX:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;

//公共服务故障
-(void)GGfugz:(NSString *)userid Keys:(NSString *)keys TVinfo:(NSString *)tvinfo content:(NSString *)content type:(NSString*)type   level:(NSString *)level img:(NSString *)img ResponseBlock:(responseBlock)block;
//诉求问题显示列表
-(void)suqiuWT:(NSString *)tvinfo Keys:(NSString *)keys pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//诉求部门列表
-(void)suqiubmen:(NSString *)tvinfo Keys:(NSString *)keys pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//手机获取验证码
-(void)ShoujYZ:(NSString *)tvinfo Keys:(NSString *)keys phone:(NSString *)phone YZ:(NSString *)YZ ResponseBlock:(responseBlock)block;
//诉求提交
-(void)SQtjiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)Deptid UserName:(NSString *)UserName  Title:(NSString *)Title Content:(NSString *)Content MobileNo:(NSString *)MobileNo  OpinionClassId:(NSString *)OpinionClassId Visible:(NSString *)Visible  SMS:(NSString *)SMS Opinionid:(NSString *)Opinionid ResponseBlock:(responseBlock)block;
//办事攻略 李
-(void)GongLie:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//党员风采 李
-(void)FengCai:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//党群活动 李
-(void)HuoDong:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//办事指南  next三 李
-(void)BanShiNext:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ChuanID:(NSString *)nextId ResponseBlock:(responseBlock)block;
//办事指南  next二 李
-(void)BanShibiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ChuanID:(NSString *)nextId ResponseBlock:(responseBlock)block;
//结果查询
-(void)ChaXun:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Page:(NSString *)page Pagesize:(NSString *)pagesize UserName:(NSString *)username MobileNo:(NSString *)mobi ResponseBlock:(responseBlock)block;
//政务六项 李
-(void)ZWLiuXiang:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid ResponseBlock:(responseBlock)block;
//掌上党校 李
-(void)ZSDangXiao:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Sid:(NSString *)sid ResponseBlock:(responseBlock)block;
//预约办事  表格到-选择器 李
-(void)XuanZeQi:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid Time:(NSString *)time NewId:(NSString *)newid ResponseBlock:(responseBlock)block;
//预约办事-》提交
-(void)BanShiTJ:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid EditDate:(NSString *)edit Period:(NSString *)peri UserName:(NSString *)uname MobileNo:(NSString *)phone HandleClassId:(NSString *)handid ResponseBlock:(responseBlock)block;


//书记信箱事项类别
-(void)Docket:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//书记类型接口
-(void)Secretary:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//书记信箱
-(void)Mailbox:(NSString *)tvinfo Keys:(NSString *)keys genre:(NSString *)genre docketid:(NSString *)docketid  title:(NSString *)title phone:(NSString *)phone Name:(NSString *)Name  content:(NSString *)content time:(NSString *)time  Deptid:(NSString *)Deptid secretaryid:(NSString *)secretaryid ResponseBlock:(responseBlock)block;

//、组织概况
-(void)Organize:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid idcard:(NSString *)idcard ResponseBlock:(responseBlock)block;
//党员风采
-(void)pioneer:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid page:(NSString *)page Pagesize:(NSString *)pagesize ResponseBlock:(responseBlock)block;
//党群活动
-(void)HuoDong:(NSString *)tvinfo Keys:(NSString *)keys Deptid:(NSString *)deptid pagesize:(NSString *)pagesize page:(NSString *)page ResponseBlock:(responseBlock)block;
//党员登陆
-(void)partylogin:(NSString *)idcard name:(NSString *)name LinkTel:(NSString *)LinkTel  ResponseBlock:(responseBlock)block;
//、党费查询
-(void)interface:(NSString *)tvinfo Keys:(NSString *)keys idcard:(NSString *)idcard name:(NSString *)name ResponseBlock:(responseBlock)block;
//、入党申请书
-(void)Application:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid name:(NSString *)name idcard:(NSString *)idcard age:(NSString *)age unit:(NSString *)unit job:(NSString *)job content:(NSString *)content phone:(NSString *)phone levelId:(NSString *)levelId nationId:(NSString *)nationId ResponseBlock:(responseBlock)block;
//专业
-(void)culturelevel:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//名族
-(void)nation:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//反腐倡廉
-(void)Corruption:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  page:(NSString *)page Pagesize:(NSString *)pagesize ResponseBlock:(responseBlock)block;
//精准帮扶
-(void)JZBF:(NSString *)tvinfo Keys:(NSString *)keys ResponseBlock:(responseBlock)block;
//帮扶政策
-(void)BFZC:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//帮扶力量
-(void)BFLL:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//帮扶对象
-(void)BFDX:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//帮扶活动
-(void)BFHD:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid  ResponseBlock:(responseBlock)block;
//社区概况
-(void)IndexNews:(NSString *)tvinfo Keys:(NSString *)keys Page:(NSString *)Page Deptid:(NSString *)Deptid  PageSize:(NSString *)PageSize ClassId:(NSString *)ClassId ResponseBlock:(responseBlock)block;
//党员管理系统
-(void)party:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid shzt:(NSString *)shzt ResponseBlock:(responseBlock)block;
//修改昵称
-(void)NiChen:(NSString *)tvinfo Keys:(NSString *)keys deptid:(NSString *)deptid nickName:(NSString *)neckname ResponseBlock:(responseBlock)block;
//车位锁查询
-(void)CWSuo:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid PageSize:(NSString *)PageSize Page:(NSString *)page ResponseBlock:(responseBlock)block;
//车位锁添加
-(void)CWSuoTianjia:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid Name:(NSString *)name Num:(NSString *)num ResponseBlock:(responseBlock)block;
//车位锁修改
-(void)CWSuoRevise:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid LockAddress:(NSString *)lockAddress ResponseBlock:(responseBlock)block;
//车位锁删除
-(void)CWSuoDelete:(NSString *)tvinfo Keys:(NSString *)keys UserId:(NSString *)userid ResponseBlock:(responseBlock)block;
//判断未完成的是否显示
-(void)PanDuan:(NSString *)tvinfo Keys:(NSString *)keys State:(NSString *)state ResponseBlock:(responseBlock)block;

@end
