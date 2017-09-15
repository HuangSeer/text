//
//  SDKCommonDef.h
//  AnjubaoSDK
//
//  Created by YangFan on 4/8/16.
//  Copyright © 2016 YangFan. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface AJBVersionInfo : NSObject<NSCopying>
/** 未一标识一款soft */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_name;
/** 运行系统平台 1：android, 2：ios, 3：windows,4:elinux-arm */
@property(nonatomic, readwrite) int soft_os_type;
/** 0:成功;1:网络异常;2:无需升级;3:没有升级包4:未知错误 */
@property(nonatomic, readwrite) int error_code;
/** 版本号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_version;
/** 升级类型 1：普通升级，2：强制升级 */
@property(nonatomic, readwrite) int soft_upgrade_type;
/** 安装包下载地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_dowload_url;
/** 版本说明 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_note;
/** 运行系统平台版本号 格式自定义 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_os_version;
/** 文件MD5效验码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* soft_file_md5;
@end
/**
 * 手机操作系统类型
 **/
typedef enum AJBTerminalOSType {
	TerminalOSType_Android = 1,
	TerminalOSType_Ios = 2,
} AJBTerminalOSType;
typedef enum AJBLangType {
	/** 中文 */
	LangType_Lang_chs = 1,
	/** 英文 */
	LangType_Lang_eng = 2,
	/** 泰文 */
	LangType_Lang_tha = 3,
} AJBLangType;
/**
 * mob平台错误码
 **/
typedef enum AJBMobErr {
	/** 发送短信成功 */
	MobErr_OK = 200,
	/** 服务器拒绝访问，或者拒绝操作 */
	MobErr_Server_ablehnen = 512,
	/** 求Appkey不存在或被禁用。 */
	MobErr_without_appkey = 513,
	/** 权限不足 */
	MobErr_Permission_denied = 514,
	/** 服务器内部错误 */
	MobErr_server_error = 515,
	/** 缺少必要的请求参数 */
	MobErr_Missing_Parameters = 517,
	/** 请求中用户的手机号格式不正确（包括手机的区号） */
	MobErr_mobile_format_error = 518,
	/** 请求发送验证码次数超出限制 */
	MobErr_number_beyond_limit = 519,
	/** 无效验证码。 */
	MobErr_Invalid_verification_code = 520,
	/** 余额不足 */
	MobErr_not_sufficient_funds = 526,
} AJBMobErr;
/**
 * QueueID请求类型
 **/
typedef enum AJBEServerInfoRequestType {
	/** 请求分配自己的队列id； */
	EServerInfoRequestType_E_QUEUEID_MY = 1,
	/** 请求分配其它服务的队列id； */
	EServerInfoRequestType_E_QUEUEID_THEIR = 2,
} AJBEServerInfoRequestType;
/**
 * QueueID请求类型
 **/
typedef enum AJBEServerType {
	/** APP服务； */
	EServerType_E_SERVERTYPE_APP = 1,
	/** IPC服务； */
	EServerType_E_SERVERTYPE_IPC = 2,
	/** 分配服务； */
	EServerType_E_SERVERTYPE_RMS = 3,
	/** 视频媒体服务； */
	EServerType_E_SERVERTYPE_VideoMedia = 4,
	/** 语音对讲服务； */
	EServerType_E_SERVERTYPE_TalkMedia = 5,
	/** http消息网关 */
	EServerType_E_SERVERTYPE_Nginx_Msg_Gateway = 6,
	/** http消息推送服务器 */
	EServerType_E_SERVERTYPE_Nginx_Push = 7,
	/** rtmp服务,包括录制功能 */
	EServerType_E_SERVERTYPE_Nginx_Rtmp_Gateway = 8,
	/** rtsp服务 */
	EServerType_E_SERVERTYPE_Rtsp = 9,
	/** ipc服务V2版本 */
	EServerType_E_SERVERTYPE_IPC_HTTP = 10,
	/** 运营服务 */
	EServerType_E_SERVERTYPE_OP = 11,
	/** 流媒体文件传输服务，传送ipc本地录像给app */
	EServerType_E_SERVERTYPE_File_Transfer = 12,
	/** 运营服务测试 */
	EServerType_E_SERVERTYPE_OP_TEST = 13,
	/** 推送服务器 */
	EServerType_E_SERVERTYPE_Push = 14,
} AJBEServerType;
/**
 * 平台内部统一错误码定义
 **/
typedef enum AJBErrorCode {
	ErrorCode_ERR_UNKNOWN = 99999,
	ErrorCode_ERR_OK = 0,
	/** 空指针错误 */
	ErrorCode_ERR_NULL_PTR = 9001,
	/** 请求序号错误 */
	ErrorCode_ERR_REQ_SEQ_ERROR = 9002,
	ErrorCode_ERR_EMAIL_ALREADY_REGISTER = 1,
	ErrorCode_ERR_MOBILE_ALREADY_REGISTER = 2,
	/** 账号不存在 */
	ErrorCode_ERR_LOGIN_ACCOUNT_NOTEXIST = 3,
	/** 密码错误 */
	ErrorCode_ERR_LOGIN_PWD_ERROR = 4,
	/** 用户添加的商铺数量已达最大值 */
	ErrorCode_ERR_SHOPS_ALREADY_MAX = 5,
	/** 商铺不存在 */
	ErrorCode_ERR_BIND_SHOP_NOTEXIST = 6,
	/** ipc不存在 */
	ErrorCode_ERR_BIND_IPC_NOTEXIST = 7,
	/** sensor不存在 */
	ErrorCode_ERR_BIND_SENSOR_NOTEXIST = 8,
	/** 客户端消息格式错误 */
	ErrorCode_ERR_MSG_FORMAT_ERROR = 9,
	/** 服务器的内部错误 */
	ErrorCode_ERR_SERVER_ERROR = 10,
	/** 用户已经离线，需要重新登录 */
	ErrorCode_ERR_USER_OFFLINE = 12,
	/** 布防失败 */
	ErrorCode_ERR_DEFENCE_FAILURE = 13,
	/** 找不到ipc信息 */
	ErrorCode_ERR_FIND_IPC_FAIL = 14,
	/** 找不到sensor信息 */
	ErrorCode_ERR_FIND_SENSOR_FAIL = 15,
	/** 开启监听失败 */
	ErrorCode_ERR_LISTEN_FAIL = 16,
	/** 没有权限 */
	ErrorCode_ERR_PERMISSION_DENIED = 17,
	/** ipc已经绑定 */
	ErrorCode_ERR_IPC_ISBIND = 18,
	/** 访问ipc服务出错 */
	ErrorCode_ERR_IPC_SERVER_TIMEOUT = 19,
	/** 用户不存在 */
	ErrorCode_ERR_USER_NOTEXIST = 20,
	/** IPC推流错误 */
	ErrorCode_ERR_IPC_PUSHSTREAM_ERROR = 21,
	/** IPC停流错误 */
	ErrorCode_ERR_IPC_STOPSTREAM_ERROR = 22,
	/** rtspUrl格式错误 */
	ErrorCode_ERR_RTSPURL_FORMAT_ERROR = 23,
	/** ipc 正在忙 */
	ErrorCode_ERR_IPC_BUSY = 24,
	/** IPC不支持当前编解码信息 */
	ErrorCode_ERR_IPC_CODEC_NOT_SUPPORT = 25,
	/** ipc上传图片失败 */
	ErrorCode_ERR_IPC_UPLOAD_PICTURE_FAIL = 26,
	/** ipc正在对讲，请稍候再试 */
	ErrorCode_ERR_IPC_HAS_TALKING = 27,
	/** 撤防失败 */
	ErrorCode_ERR_OUTDEFENCE_FAILURE = 28,
	/** 连接异常,请重试 */
	ErrorCode_ERR_PLEASE_RETRY = 29,
	/** ipc不在线 */
	ErrorCode_ERR_IPC_UNLINE = 30,
	/** 该型号ipc没有更新信息 */
	ErrorCode_ERR_IPC_HASNOT_VERSIONINFO = 31,
	/** 用户已经被邀请 */
	ErrorCode_ERR_HAS_BEEN_INVITED = 32,
	/** 添加sensor失败 */
	ErrorCode_ERR_ADD_SERSOR_FAIL = 33,
	/** 删除sensor失败 */
	ErrorCode_ERR_DELETE_SERSOR_FAIL = 34,
	/** 商铺已经存在 */
	ErrorCode_ERR_SHOP_ALREADY_EXISTS = 35,
	/** 该商铺没有IPC */
	ErrorCode_ERR_SHOP_HASNO_IPC = 36,
	/** 验证码错误 */
	ErrorCode_ERR_ERROR_VERIFICATION_CODE = 37,
	/** 访问ipc超时 */
	ErrorCode_ERR_IPC_TIMEOUT = 38,
	/** 验证码超时，请重新获取 */
	ErrorCode_ERR_AUTHCODE_TIMEOUT = 39,
	/** 验证码错误 */
	ErrorCode_ERR_AUTHCODE_ERROR = 40,
	/** 重复下载视频文件 */
	ErrorCode_ERR_REDOWNLOAD_FILE = 41,
	/** 下载的tf视频文件不存在 */
	ErrorCode_ERR_TFFILE_NOTEXIST = 42,
	/** 相关ipc的live流已存在 */
	ErrorCode_ERR_ALREADY_EXIST_LIVESTREAM = 200,
	/** 相关ipc的live流不存 */
	ErrorCode_ERR_IPC_LIVESTREAM_NOT_EXIST = 201,
	/** IPC基本信息缺失 */
	ErrorCode_ERR_IPCINFO_LOSS = 202,
	/** rtsp url不存在 */
	ErrorCode_ERR_RTSP_URL_NOT_EXIST = 203,
	/** 想要切换的码流分辨率相同 */
	ErrorCode_ERR_STREAM_CODE_CHANGE_SAME = 204,
	/** 请求ipc视频的处理函数在等待2s之后发现数据库没有该ipc push流的缓存 */
	ErrorCode_ERR_IPC_PUSHSTREAM_NOT_EXIST = 205,
	/** 请求ipc视频的处理函数在等待2s之后发现数据库中该ipc push流仍不是running状态 */
	ErrorCode_ERR_IPC_PUSHSTREAM_NOT_READY = 206,
	/** 传感器已经绑定 */
	ErrorCode_ERR_SERSOR_ISBIND = 207,
	/** 对讲失败 */
	ErrorCode_ERR_TALK_FAILED = 300,
	/** 太多设备 */
	ErrorCode_ERR_SCENCE_TOOMANYDEV = 301,
	/** ipc已经关闭 关闭视频和音频 */
	ErrorCode_ERR_IPC_ClOSED = 302,
	/** 连不上升级服务 */
	ErrorCode_ERR_UPDATESERVER_LINKERROR = 303,
	/** 升级服务错误 */
	ErrorCode_ERR_UPDATEERROR = 304,
	/** 分配资源成功 */
	ErrorCode_ERR_ALLOC_SUCCEED = 2000,
	/** 分配资源失败 */
	ErrorCode_ERR_ALLOC_FAILED = 2001,
	/** 数据库错误 */
	ErrorCode_ERR_DB_ACCESS = 2200,
	/** 找不到音频转发项 */
	ErrorCode_ERR_STREAM_EXCHANGE_STREAM_NOTEXIST = 3000,
	/** 发送Qpid消息到别的Rtp server失败 */
	ErrorCode_ERR_SEND_QPID_MESSAGE_FAILED = 3001,
	/** rtp服务无可用SSRC */
	ErrorCode_ERR_RUN_OUT_OF_SSRC = 3002,
	/** 发功能键控制, 这个键没有学习 */
	ErrorCode_ERR_INFRARED_REPEATER_LEARNING_CONTROL_KEY_NOTEXIST = 3100,
	/** 已进入学习模式,无法再次进入学习模式 */
	ErrorCode_ERR_INFRARED_REPEATER_LEARNING_ALREADY_ENTER_STUDY = 3101,
	/** 结束学习的时候返回, 学习失败 */
	ErrorCode_ERR_INFRARED_REPEATER_LEARNING_STUDY_KEY_FAILED = 3102,
	/** 添加家电超过限制 */
	ErrorCode_ERR_INFRARED_REPEATER_LEARNING_ADD_APPLIANCE_OVER_LIMIT = 3103,
	/** 需要的消息字段不存在或内容错误 */
	ErrorCode_ERR_MESSAGE_FIELD_INCORRECT = 9000,
	ErrorCode_ERR_TIME_OUT = 10000,
	ErrorCode_ERR_NET_BREAK = 10001,
	ErrorCode_ERR_PARSE_CONFIG = 10002,
	ErrorCode_ERR_TARGET_EXISTED = 10004,
	ErrorCode_ERR_TF_CARD_NOT_EXIST = 10005,
	ErrorCode_ERR_TF_CARD_NEED_FORMAT = 10006,
	ErrorCode_ERR_TF_CARD_FORMAT_FAIL = 10007,
	/** 读入SD卡异常，请重新插入 */
	ErrorCode_ERR_TF_CARD_EXCEPTION = 10008,
	/** sensor达到最大值，不能再添加 */
	ErrorCode_ERR_SENSOR_REACH_MAX = 10009,
	/** 控制设备失败 */
	ErrorCode_ERR_CONTROL_DEVICE_FAIL = 10010,
	/** 打开情景失败 */
	ErrorCode_ERR_OPEN_SCENCE_FAIL = 10011,
	/** 增加情景失败 */
	ErrorCode_ERR_ADD_SCENCE_FAIL = 100012,
	/** 删除情景失败 */
	ErrorCode_ERR_DEL_SCENCE_FAIL = 100013,
	/** 增加指纹情景失败 */
	ErrorCode_ERR_ADD_FPSCENCE_FAIL = 100014,
	/** 编辑情景失败 */
	ErrorCode_ERR_EDIT_SCENCE_FAIL = 100015,
	/** 指纹情景已经存在 */
	ErrorCode_ERR_ALREADY_EXIST_FPSCENCE = 100016,
	/** 添加情景超过上限(现在情景上限是8个) */
	ErrorCode_ERR_ADD_SCENCE_OVER_LIMIT = 100017,
	/** 增加情景联动失败 */
	ErrorCode_ERR_ADD_SCENCELINK_FAIL = 100100,
	/** 超出ipc支持的配置信息范围 */
	ErrorCode_ERR_IPC_OUTOFNUM = 100200,
	/** 添加的锁太多了 */
	ErrorCode_ERR_IPC_OUTOF_LOCKNUM = 100201,
	/** 接警点不存在 */
	ErrorCode_ERR_OP_POINT_NOTEXIST = 20000,
	/** 短信发送失败 */
	ErrorCode_ERR_SMS_SEND_FAIL = 20001,
	/** 接警点不在有效期 */
	ErrorCode_ERR_OP_POINT_INVALID = 20002,
	/** 没有找到报警事件 */
	ErrorCode_ERR_ALARM_NOTFOUND = 20003,
	/** 没有找到商铺信息 */
	ErrorCode_ERR_SHOP_NOTFOUND = 20004,
	/** 没有找到IPC信息 */
	ErrorCode_ERR_IPC_NOTFOUND = 20005,
	/** 没有找到租赁信息 */
	ErrorCode_ERR_LEASE_INFO_NOTFOUND = 20006,
	/** 预览视频权限拒绝 */
	ErrorCode_ERR_PREVIEW_PERMISSION_DENIED = 20007,
	/** 商铺已经被分派 */
	ErrorCode_ERR_ADDRESS_ALREADY_ALLOC = 20008,
	/** 扫描出错 */
	ErrorCode_ERR_WIFI_SCAN = 20010,
	/** wifi不存在 */
	ErrorCode_ERR_WIFI_AP_NO_EXSIT = 20011,
	/** 重启失败 */
	ErrorCode_ERR_IPC_RESTART = 20012,
	/** 正在升级中 */
	ErrorCode_ERR_IPC_IS_UPGRADING = 20013,
	/** 设备类型错误 */
	ErrorCode_ERR_UPGRADE_PARAM_INVALID = 20014,
	/** 已经是最新版本 */
	ErrorCode_ERR_IPC_VERSION_IS_LATEST = 20015,
	/** 源用户不存在 */
	ErrorCode_ERR_OLD_USER_NOTEXIST = 30000,
	/** 用户下没有商铺 */
	ErrorCode_ERR_USER_NOTEXIST_SHOP = 30001,
	/** 没有找到商铺 */
	ErrorCode_ERR_ADDRESS_NOTFOUND = 30002,
	/** 接警点未审核通过 */
	ErrorCode_ERR_OP_POINT_APPROVED_NO_PASS = 30003,
	/** 接警点欠费 */
	ErrorCode_ERR_OP_POINT_ARREARS = 30004,
	/** 不能删除自己 */
	ErrorCode_ERR_UNABLE_DELETE_MYSELF = 30005,
	/** 不能添加自己 */
	ErrorCode_ERR_UNABLE_ADD_MYSELF = 30006,
	/** 未连接服务 */
	ErrorCode_ERR_HAS_NOT_CONNECT_SERVICE = -1,
	/** 未登录 */
	ErrorCode_ERR_HAS_NOT_LOGIN = -2,
	/** HTTP请求失败 */
	ErrorCode_ERR_HTTP_REQUEST_FAILED = -3,
} AJBErrorCode;
/**
 * 系统升级类型
 **/
typedef enum AJBEUpdateType {
	/** 文件系统； */
	EUpdateType_E_FS = 1,
	/** 内核； */
	EUpdateType_E_KERNAL = 2,
	/** 文件系统 和 内核； */
	EUpdateType_E_FS_KERNAL = 3,
	/** 应用程序 */
	EUpdateType_E_APP = 4,
} AJBEUpdateType;
/**
 * 系统升级结果
 **/
typedef enum AJBEUpdateResult {
	/** 升级成功； */
	EUpdateResult_E_Update_Success = 1,
	/** 下载失败； */
	EUpdateResult_E_Update_Download_Fail = 2,
	/** 硬件错误； */
	EUpdateResult_E_Update_FileSys_Invalid = 3,
	/** 内核错误； */
	EUpdateResult_E_Update_kernel_Invalid = 4,
	/** 应用错误； */
	EUpdateResult_E_Update_App_Invalid = 5,
} AJBEUpdateResult;
/**
 * 图像反转类型
 **/
typedef enum AJBEImageReverseType {
	/** 垂直反转； */
	EImageReverseType_E_vertical = 1,
	/** 水平反转； */
	EImageReverseType_E_level = 2,
	/** 水平和垂直都反转； */
	EImageReverseType_E_vertical_and_level = 3,
	EImageReverseType_E_normal = 4,
} AJBEImageReverseType;
/**
 * 网络错误类型
 **/
typedef enum AJBENetError {
	/** 连接断开 */
	ENetError_Conn_NetworkBreak = 0,
	/** 连接成功 */
	ENetError_Conn_NetworkOk = 1,
} AJBENetError;
/**
 * 数据传输协议
 **/
typedef enum AJBETransMode {
	ETransMode_E_TRANS_TCP = 1,
	ETransMode_E_TRANS_UDP = 2,
} AJBETransMode;
/**
 * 上报消息类型, 设备事件不用录像, 报警事件要录像,
 * 紧急报警不管用户是否布撤防都要上报
 **/
typedef enum AJBEAlarmType {
	/** 所有报警 */
	EAlarmType_E_ALARM_ALL = 0,
	/** 控制器（主机）报警   报警事件 */
	EAlarmType_E_ALARM_CONTROLLER = 1,
	/** 中继器	报警事件 */
	EAlarmType_E_ALARM_REPEATER = 2,
	/** 红外探测报警 报警事件 */
	EAlarmType_E_ALARM_INFRARED_DETECTOR = 3,
	/** 紧急报警 报警事件 紧急报警 */
	EAlarmType_E_ALARM_EMERGENCY_BUTTON = 4,
	/** 门磁报警 报警事件 */
	EAlarmType_E_ALARM_MAGNETIC_DOOR = 5,
	/** 烟雾报警 报警事件 紧急报警 */
	EAlarmType_E_ALARM_SMOKE_DETECTOR = 6,
	/** 煤气报警 报警事件 紧急报警 */
	EAlarmType_E_ALARM_GAS_DETECTOR = 7,
	/** 红外幕帘报警 报警事件 */
	EAlarmType_E_ALARM_CURTAIN = 8,
	/** 求助报警  报警事件 紧急报警 */
	EAlarmType_E_ALARM_HELP_BUTTON = 9,
	/** 胁迫按钮报警 报警事件 紧急报警  app不响报警声 */
	EAlarmType_E_ALARM_DURESS_BUTTON = 10,
	/** 控制面板报警 报警事件 */
	EAlarmType_E_ALARM_CONTROLPANEL = 11,
	/** 报警拍录器报警 报警事件 */
	EAlarmType_E_ALARM_ALARM_RECORDER = 12,
	/** 玻璃破碎报警  报警事件 */
	EAlarmType_E_ALARM_GLASS_BREAK_DETECTOR = 13,
	/** 警号报警 报警事件 */
	EAlarmType_E_ALARM_WARNING = 14,
	/** 移动侦测报警 报警事件 */
	EAlarmType_E_ALARM_MOTION_DECTCH = 15,
	/** 遮挡报警 报警事件 */
	EAlarmType_E_ALARM_SHELTER = 16,
	/** 视频丢失报警 报警事件 */
	EAlarmType_E_ALARM_VIDEO_LOST = 17,
	/** IPC掉线  设备事件 */
	EAlarmType_E_ALARM_IPC_OUTLINE = 18,
	/** IPC上线  设备事件 */
	EAlarmType_E_ALARM_IPC_ONLINE = 19,
	/** IPC升级失败  设备事件 */
	EAlarmType_E_ALARM_IPC_UPDATE_FAIL = 20,
	/** 防止拆除报警 报警事件 紧急报警 */
	EAlarmType_E_ALARM_PREVENT_DEMOLITION = 21,
	/** 电池欠压报警 报警事件 */
	EAlarmType_E_ALARM_LOW_VOLTAGE = 22,
	/** 失联(防区丢失)报警 报警事件 */
	EAlarmType_E_ALARM_LOST = 23,
	/** 普通报警  报警事件 */
	EAlarmType_E_ALARM_NORMAL = 24,
	/** 传感器硬件异常 设备事件 */
	EAlarmType_E_ALARM_SERSOR_HARDWARE_EXCEPTION = 25,
	/** 传感器下线  设备事件 */
	EAlarmType_E_ALARM_SENSOR_OUTLINE = 26,
	/** 传感器上线  设备事件 */
	EAlarmType_E_ALARM_SENSOR_ONLINE = 27,
	/** 联网异常    设备事件 */
	EAlarmType_E_ALARM_SENSOR_REMIND = 28,
	/** 指纹开锁    设备事件 */
	EAlarmType_E_ALARM_FINGERPRINT_OPEN = 29,
	/** 密码开锁    设备事件 */
	EAlarmType_E_ALARM_PASS_OPEN = 30,
	/** 射频开锁    设备事件 */
	EAlarmType_E_ALARM_RF_OPEN = 31,
	/** 连续开锁失败 报警事件 */
	EAlarmType_E_ALARM_CONOPENLOCK_FAILED = 32,
	/** 机械开锁		设备事件 */
	EAlarmType_E_ALARM_MACHINE_OPEN = 33,
	/** 胁迫开锁报警 报警事件 紧急报警 app不响报警声 */
	EAlarmType_E_ALARM_DURESS_OPENLOCK = 34,
	/** 门锁被撬报警 报警事件 */
	EAlarmType_E_ALARM_DOOR_PICKED = 35,
	/** 反锁状态报警 报警事件 */
	EAlarmType_E_ALARM_DOOR_LOCKED = 36,
	/** IPC升级成功	设备事件 */
	EAlarmType_E_ALARM_IPC_UPDATE_SUCCEED = 37,
	/** 漏水报警 报警事件  紧急报警 */
	EAlarmType_E_ALARM_LEAKING = 38,
	/** 开门情况  设备事件(0关门 1开门) */
	EAlarmType_E_ALARM_DOOR_STATUS = 39,
	/** 斜舌异常报警  报警事件 */
	EAlarmType_E_ALARM_LATCHBOLT_ABNORMAL = 40,
	/** 下压把手开门 设备事件 */
	EAlarmType_E_ALARM_HANDLEBAR_OPEN_DOOR = 41,
	/** 远程开锁  设备事件 */
	EAlarmType_E_ALARM_REMOTE_OPEN_DOOR = 42,
	/** 插座负载过大 报警事件 */
	EAlarmType_E_PLUG_PAYLOAD_HIGH = 43,
	/** 插座电压过高 报警事件 */
	EAlarmType_E_PLUG_VOLTAGE_HIGH = 44,
	/** 插座负载增大 设备事件 */
	EAlarmType_E_PLUG_PAYLOAD_GROW = 45,
	/** 插座负载减小 设备事件 */
	EAlarmType_E_PLUG_PAYLOAD_DECREASE = 46,
	/** 一氧化碳报警 */
	EAlarmType_E_ALARM_CO = 47,
} AJBEAlarmType;
/**
 * 传感器类型
 **/
typedef enum AJBESensorType {
	/** 保留 */
	ESensorType_E_NULL_DEVICE = 0,
	/** 控制器（主机IPC） */
	ESensorType_E_CONTROLLER_IPC = 1,
	/** Zigbee协调器 */
	ESensorType_E_ZigbeeCoordinator = 2,
	/** 声光报警器 */
	ESensorType_E_AcoustoOpticAlarm = 3,
	/** 门（窗）磁 */
	ESensorType_E_MAGNETIC_DOOR = 4,
	/** 红外探测器 */
	ESensorType_E_INFRARED_DETECTOR = 5,
	/** 紧急按钮 */
	ESensorType_E_EMERGENCY_BUTTON = 6,
	/** 一位灯控 */
	ESensorType_E_LIGHT_CONTROL = 7,
	/** 温度传感器 */
	ESensorType_E_TEMPERATURE_DETECTOR = 8,
	/** 情景开关 */
	ESensorType_E_SCENCE_CONTROL = 9,
	/** 电动窗帘 */
	ESensorType_E_ELECTRIC_CURTAIN = 10,
	/** 两位灯控 */
	ESensorType_E_LIGHT_CONTROL_TWO = 11,
	/** 空气质量传感器 */
	ESensorType_E_AIR_QUALITY = 12,
	/** 两路零火线窗帘控制器 */
	ESensorType_E_TOWWAY_CURTAINCONTROL = 13,
	/** 无线红外转发器 */
	ESensorType_E_INFRARED_REPEATER = 14,
	/** 三位灯控 */
	ESensorType_E_LIGHT_CONTROL_THREE = 15,
	/** 一位插座 */
	ESensorType_E_SOCKET_ONE = 16,
	/** 煤气 */
	ESensorType_E_GAS = 17,
	/** 烟感 */
	ESensorType_E_SMOKE_DETECTOR = 18,
	/** 光照度传感器 */
	ESensorType_E_SOLAR_SENSOR = 19,
	/** 智能插座 */
	ESensorType_E_SMART_POWER_PLUG = 20,
	/** 空调控制器 */
	ESensorType_E_AC_CONTROL = 21,
	/** 空调电扇 */
	ESensorType_E_AC_FAN = 22,
	/** 智能无线转接器 */
	ESensorType_E_WIRALESS_ADAPTER = 23,
	/** 电视红外转发器 */
	ESensorType_E_TV_IR_REPEATER = 24,
	/** DVD红外转发器 */
	ESensorType_E_DVD_IR_REPEATER = 25,
	/** 无线门锁 */
	ESensorType_E_WIRELESS_LOCK = 26,
	/** 四路无线转接器 */
	ESensorType_E_FOURWIRELESS_REPEATER = 27,
	/** 情景面板 */
	ESensorType_E_SCENCE_PANEL = 28,
	/** 智能密码锁 */
	ESensorType_E_SMART_CODELOCK = 29,
	/** 电动晾衣架 */
	ESensorType_E_ELECTRI_LAUNDRYRACK = 30,
	/** 双路干触点型窗帘控制器 */
	ESensorType_E_ELECTRIC_CURTAIN_TWO = 31,
	/** 单路双联灯控开关,(上下楼梯口用，由一位灯控改造) */
	ESensorType_E_LIGHT_CONTROL_STAIRS = 32,
	/** 低功耗版红外人体感应器 */
	ESensorType_E_LOWPOWER_INFRARED_DETECTOR = 33,
	/** 调光灯控 */
	ESensorType_E_LIGHT_DIMMER_CONTROL = 34,
	/** 具有音频功能的网关 */
	ESensorType_E_CONTROLLER_AUDIO_GATEWAY = 35,
	/** 不具有音频功能的网关 */
	ESensorType_E_CONTROLLER_NOAUDIO_GATEWAY = 36,
	/** 新风系统 */
	ESensorType_E_VENTILATION_SYSTEM = 37,
	/** 水浸传感器 */
	ESensorType_E_WATER_SENSOR = 38,
	/** 5孔插座 */
	ESensorType_E_FIVE_PLUG = 39,
	/** 学习型红外转发器 */
	ESensorType_E_INFRARED_REPEATER_LEARNING = 40,
	/** 一氧化碳探测器 */
	ESensorType_E_CO_DETECTOR = 41,
	/** 学习型红外转发器-dvd */
	ESensorType_E_INFRARED_REPEATER_LEARNING_DVD = 500,
	/** 学习型红外转发器-空调 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_AIRCONDITIONING = 501,
	/** 学习型红外转发器-电视 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_TV = 502,
	/** 学习型红外转发器-电视机顶盒 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_STB = 503,
	/** 学习型红外转发器-网络盒子 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_NETBOX = 504,
	/** 学习型红外转发器-投影仪 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_PROJECTOR = 505,
	/** 学习型红外转发器-功放 */
	ESensorType_E_INFRARED_REPEATER_LEARNING_AMPLIFIER = 506,
} AJBESensorType;
/**
 * 码流类型
 **/
typedef enum AJBEStreamType {
	EStreamType_E_STR_MAIN_1080P = 1,
	EStreamType_E_STR_SUB_720P = 2,
	EStreamType_E_STR_SUB_D1 = 3,
	EStreamType_E_STR_SUB_CIF = 4,
	EStreamType_E_STR_NOTYPE = 5,
	EStreamType_E_STR_VGA = 6,
} AJBEStreamType;
/**
 * 录制用途
 **/
typedef enum AJBRecordPuspose {
	RecordPuspose_Record_Alarm = 0,
	RecordPuspose_Record_Timer = 1,
} AJBRecordPuspose;
typedef enum AJBIpcEncryptType {
	IpcEncryptType_E_NONE = 0,
	IpcEncryptType_E_WEP = 1,
	IpcEncryptType_E_WPA = 2,
} AJBIpcEncryptType;
@class AJBAppSensorInfo;
@class AJBIpcFile;
@class AJBSensorChildEntity;
@class AJBUserAllInfo;
@class AJBAddress_OpPointInfomation;
@class AJBCodecInfo;
@class AJBAddressUser;
@class AJBWiFiAPInfo;
@class AJBNetworkAddress;
@class AJBIpcScenceInfomation;
/**
 * 推送消息
 **/
@interface AJBPushMessageObject : NSObject<NSCopying>
/** 推送消息名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* message_name;
/** 推送消息实体 */
@property(nonatomic, readwrite, copy, null_resettable) NSObject* message_object;
@end
/**
 * 推送消息
 **/
@interface AJBPushMessage : NSObject<NSCopying>
/** 推送消息 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBPushMessageObject*>* message_objects;
/** 服务器存在的消息条数 */
@property(nonatomic, readwrite) int srv_msg_count;
@end
/**
 * ipc信息
 **/
@interface AJBIpcInfomation : NSObject<NSCopying>
/** ipc所属的店铺名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_name;
/** ipc所属的店铺id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
/** 由app扫描设备上的二维码后得到的设备序列号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_serial_number;
@property(nonatomic, readwrite, copy, null_resettable) NSString* name;
/** 设备是否加入布防，首次加入默认为false */
@property(nonatomic, readwrite) BOOL join_against;
/** 设备是否在线，首次加入默认为false */
@property(nonatomic, readwrite) BOOL online;
/** 设备是否布防，首次加入默认为false */
@property(nonatomic, readwrite) BOOL safe_status;
/** 拥有的感应器 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAppSensorInfo*>* sensors;
/** 由app服务访问数据库后，获得的设备唯一UUid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* lan_ip;
@property(nonatomic, readwrite, copy, null_resettable) NSString* mac;
@property(nonatomic, readwrite, copy, null_resettable) NSString* register_time;
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_type;
@property(nonatomic, readwrite, copy, null_resettable) NSString* production_date;
@property(nonatomic, readwrite, copy, null_resettable) NSString* other_info;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_ip;
@property(nonatomic, readwrite) int broker_port;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_queue_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* wan_ip;
/** 放broker的帐号和密码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_conoptions;
/** 最近被打开过的时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* recentlyopen;
@property(nonatomic, readwrite) int address_type;
/** ipc 图片地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* Img_Url;
/** ipc版本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_version;
/** Ipc厂家 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_factory;
/** ipc码流类型，support_streamtype是ipc支持的所有类型 */
@property(nonatomic, readwrite) AJBEStreamType ss_type;
/** 是否开启移动侦测 true 开启 false 关闭 */
@property(nonatomic, readwrite) BOOL openMotionDetection;
/** 报警语音开关 true 开启 false 关闭 */
@property(nonatomic, readwrite) BOOL voice_prompt_active;
/** 自动升级开关 true 开启 false 关闭 */
@property(nonatomic, readwrite) BOOL level_up;
/** 抗闪烁开关 false close ,ture open */
@property(nonatomic, readwrite) BOOL ipc_seeflashing;
/** 是否有tf卡 false 没有 true 有 */
@property(nonatomic, readwrite) BOOL hasTF;
/** 时区 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* TimeZoneName;
/** TimeZoneName为 UTC+8 TimeZoneOffset 为 8 */
@property(nonatomic, readwrite) int TimeZoneOffset;
/** false close ,ture open 默认true */
@property(nonatomic, readwrite) BOOL videoswitch_status;
/** 1 低  2 中 3 高 默认3 */
@property(nonatomic, readwrite) int switchLevel;
/** 升级地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* updateUrl;
/** ipc所连的wifi */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_wifi;
/** ipc的通道名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_osd;
/** 图片旋转类型 */
@property(nonatomic, readwrite) AJBEImageReverseType reversetype;
/** ipc支持的所有码流类型，ss_type是当前类型 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSNumber*>* supported_streamtype;
/** 所属的传感器类型（01:ipc，35，36:智能网关） */
@property(nonatomic, readwrite) AJBESensorType sensor_type;
/** 设置IPC定时录像 */
@property(nonatomic, readwrite) BOOL tf_record_forever;
/** ipc延时布防时间，单位秒 */
@property(nonatomic, readwrite) int delay_defence_times;
@end
/**
 * 检查ipc是否需要更新
 **/
@interface AJBCheckIpcUpdate : NSObject<NSCopying>
/** ipcID */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 是否需要更新 */
@property(nonatomic, readwrite) BOOL isNeedUpdate;
/** 旧版本号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* oldVersionNumber;
/** 新版本号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* NewVersionNumber;
/** 更新版本信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* updateInfo;
/** 更新包的地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* updateUrl;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
@interface AJBAppSensorInfo : NSObject<NSCopying>
/** sensor序列号 mac地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* serial_number;
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
/** 类型 */
@property(nonatomic, readwrite) AJBESensorType type;
/** 型号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* module;
@property(nonatomic, readwrite) BOOL status;
/** 防区 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* defence_area;
/** 传感器名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSData* sensor_name;
/** 子属性列表 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBSensorChildEntity*>* sensor_child;
/** 传感器所属ipc的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** 房间id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomid;
/** 房间名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* room_name;
@end
/**
 * 商铺信息
 **/
@interface AJBAddressInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* Address_id;
/** 商铺名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* name;
/** 联系人电话 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile_phone;
/** 联系人1电话 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* telephone;
/** 商铺地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address;
/** 经度 */
@property(nonatomic, readwrite) double longitude;
/** 纬度 */
@property(nonatomic, readwrite) double latitude;
@property(nonatomic, readwrite, copy, null_resettable) NSString* country;
@property(nonatomic, readwrite, copy, null_resettable) NSString* province;
@property(nonatomic, readwrite, copy, null_resettable) NSString* city;
@property(nonatomic, readwrite, copy, null_resettable) NSString* district;
/** 拥有的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipcs;
/** 拥有的用户信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBUserAllInfo*>* ownusers;
/** 0或者false：撤防，1或者true：布防 */
@property(nonatomic, readwrite) BOOL address_safe_status;
/** 注册时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_register_time;
/** 用户访问权限(0：拥有者，1：访问者...) */
@property(nonatomic, readwrite) int address_permission;
@property(nonatomic, readwrite) int address_type;
/** 每天的撤防时间 格式 09:30:00 表示早上9点半撤防 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* noDefenceTime;
/** 每天的布防时间 格式 06:30:00 表示下午6点半布防 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* DayDefenceTime;
/** 保留字段 默认true ,是否开启定时布撤防 */
@property(nonatomic, readwrite) BOOL AutoDefence;
/** 商铺是否公共的 0 私有的 1 公共的，对外开放，所有人都能在被邀请的商铺里面看到 */
@property(nonatomic, readwrite) int ispublic;
/** 联系人1姓名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* name_1;
/** 联系人2姓名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* name_2;
/** 联系人2电话 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* phone_2;
/** 是否授权给op服务，1 授权 0 不授权 */
@property(nonatomic, readwrite) int is2op;
/** 接警点信息 */
@property(nonatomic, readwrite, copy, null_resettable) AJBAddress_OpPointInfomation* op_pointinfo;
/** 授权托管状态（0: 关闭授权，1：等待审核， 2：审核通过） */
@property(nonatomic, readwrite) int licensed_type;
/** 视频开关 要填 true 打开 false 关闭 */
@property(nonatomic, readwrite) BOOL av_switch;
/** 商铺类型名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* type_name;
@end
/**
 * 用户的所有信息，给前端显示用
 **/
@interface AJBUserAllInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* email;
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile;
@property(nonatomic, readwrite, copy, null_resettable) NSString* user_name;
/** 是否开启推送 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* push_status;
@property(nonatomic, readwrite, copy, null_resettable) NSString* user_pwd;
/** 最后登录时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* last_logintime;
/** 用户地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* user_address;
@end
/**
 * 录像信息
 **/
@interface AJBRecordInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* start_time;
@property(nonatomic, readwrite, copy, null_resettable) NSString* stop_time;
@property(nonatomic, readwrite) int duration;
@property(nonatomic, readwrite, copy, null_resettable) NSString* url_address;
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* record_type;
@property(nonatomic, readwrite, copy, null_resettable) NSString* record_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * //////////////////////////////////////////////////////////////////////
 * 网络消息
 * 用户注册,不带验证码,已弃用,请使用MutiUsersRegitser
 **/
@interface AJBUserRegister : NSObject<NSCopying>
/** email地址，可以用来注册和登陆 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* email;
/** 手机号码，可以用来注册和登陆 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile;
/** 密码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pwd;
/** 1 商铺报警 2 智能家居 */
@property(nonatomic, readwrite) int app_type;
@property(nonatomic, readwrite, copy, null_resettable) NSString* userid;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 厂商 默认:anjubao */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
@end
/**
 * 用户登陆
 **/
@interface AJBUserLogin : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* email;
/** 登录手机号 必填 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile;
/** 密码 md5加密 必填 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pwd;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_ip;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_port;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_queuename;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_connection_options;
/** 是否推送告警 */
@property(nonatomic, readwrite) BOOL is_push;
/** 服务返回userid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* userid;
/** 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* clientid;
/** 错误码 服务返回 */
@property(nonatomic, readwrite) AJBErrorCode res;
/** 错误信息 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite) AJBTerminalOSType ostype;
/** 设备id 必填,没有填空 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_id;
/** 1 商铺报警 2 智能家居 必填 */
@property(nonatomic, readwrite) int app_type;
/** 语言类型 1 中文 2 英文 必填  弃用 */
@property(nonatomic, readwrite) int lang_type;
/** 用户类型 1 超级管理员  2 接警点管理员 3 接警点普通运维人员 */
@property(nonatomic, readwrite) int user_type;
/** 厂商 默认:anjubao  必填 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
/** 区域type , 1国内, 2海外 app填写, 必填 */
@property(nonatomic, readwrite) int app_area_type;
@property(nonatomic, readwrite, copy, null_resettable) NSString* real_time_url;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ios_url;
@property(nonatomic, readwrite, copy, null_resettable) NSString* non_real_time_url;
/** 服务返回, http推送url, 不可靠推送 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url;
/** 服务返回, 初始推送url, 返回未收到的推送消息数量 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url2;
/** 服务返回, http推送url,可靠推送 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url_safe;
/** app语言环境 */
@property(nonatomic, readwrite) AJBLangType language;
/** 所在时区 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* time_zone;
/** 时区偏移值 */
@property(nonatomic, readwrite) int time_zone_offset;
@end
/**
 * 用户添加商铺
 **/
@interface AJBUserAddAddress : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* name;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite) int address_type;
/** 电话 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_mobile;
/** 地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_addr;
@property(nonatomic, readwrite, copy, null_resettable) AJBAddressInfo* address;
@end
/**
 * 用户获取商铺
 **/
@interface AJBUserGetAddress : NSObject<NSCopying>
/** 我的商铺 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAddressInfo*>* my_address;
/** 邀请的商铺 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAddressInfo*>* invite_address;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 公共的商铺 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAddressInfo*>* public_address;
@end
/**
 * 用户获取商铺ipc
 **/
@interface AJBUserGetAddressIpcs : NSObject<NSCopying>
/** 所有的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* address_ipcs;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite) int address_type;
@end
/**
 * 用户获取商铺ipc传感器=刷新
 **/
@interface AJBUserGetAddressIpcSensors : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipcid;
/** 所有的传感器 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAppSensorInfo*>* sensors;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 绑定商铺ipc
 **/
@interface AJBAddressBindIpcs : NSObject<NSCopying>
/** app发送 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipcs;
/** server发送 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* reipcs;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite) int address_type;
@end
/**
 * 商铺一键布防
 **/
@interface AJBAddressSetAgainst : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
/** 布防、撤防 */
@property(nonatomic, readwrite) BOOL safe_status;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 不成功的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* unsecess_ipcs;
@property(nonatomic, readwrite) int address_type;
/** 布防延时 0:立刻执行 */
@property(nonatomic, readwrite) int defense_delay;
@end
/**
 * 请求查看实时视频
 **/
@interface AJBReqWatchIpc : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite) AJBEStreamType ss_type;
/** rtmp地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* url_address;
/** rtsp地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* url_address_rtsp;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 商铺id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * 实时视频更改通知
 **/
@interface AJBChangeWatchIpc : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite) AJBEStreamType ss_type;
/** rtmp地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* url_address;
/** rtsp地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* url_address_rtsp;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 查询录像列表
 **/
@interface AJBQueryRecord : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBRecordInfo*>* records;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
@end
/**
 * 请求对讲, ipc可持续发送语音包
 **/
@interface AJBReqStartTalkIpc : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** app支持的codec */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBCodecInfo*>* app_support_codecs;
/** 返回字段 ssrc */
@property(nonatomic, readwrite) int app_ssrc;
/** 返回字段 对讲ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* streamexchange_ip;
/** 返回字段 对讲端口 */
@property(nonatomic, readwrite) int streamexchange_port;
/** 返回ipc选择的codec */
@property(nonatomic, readwrite, copy, null_resettable) AJBCodecInfo* ipc_sel_codec;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 请求的app ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_mac;
@property(nonatomic, readwrite, copy, null_resettable) NSString* codec;
@property(nonatomic, readwrite, copy, null_resettable) NSString* server_host;
@property(nonatomic, readwrite, copy, null_resettable) NSString* tcp_port;
@property(nonatomic, readwrite, copy, null_resettable) NSString* rtp_port;
@property(nonatomic, readwrite, copy, null_resettable) NSString* rtcp_port;
@property(nonatomic, readwrite) int start_upload;
@end
/**
 * IPC 抓图
 **/
@interface AJBGetIpcImg : NSObject<NSCopying>
/** 需要抓图的ipc id的集合 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* ipc_ids;
/** 返回的ipc信息,里面包含图片url */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* Ipcs;
/** 有一个ipc请求成功就返回ok */
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 报警事件信息
 **/
@interface AJBAlarmEventinfo : NSObject<NSCopying>
/** 事件类型, EAlarmType中的 除 18, 19, 25, 20, 27, 26, 28, 29, 22, 30, 31, 33, 37, 39, 41, 42之外的类型,请查看EAlarmType类型 */
@property(nonatomic, readwrite) AJBEAlarmType Alarmtype;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
/** 事件时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* alarm_time;
/** 是否已查看 */
@property(nonatomic, readwrite) BOOL isdeal;
/** 报警事件截图地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* PictureUrl;
/** 报警录像地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* VideoUrl;
/** 事件id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* eventid;
/** 1 正在录制 2 录像失败 3 录像成功 */
@property(nonatomic, readwrite) int hasrecord;
/** 告警的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* alarmid;
/** 告警的商铺id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* alarm_addrid;
/** 是否自己的告警 1 自己 0 别人的 */
@property(nonatomic, readwrite) int alarm_type;
/** 录像下载地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* video_download_url;
/** 所属的传感器类型（01:ipc, ... ,35，36:智能网关） */
@property(nonatomic, readwrite) AJBESensorType sensor_type;
/** 指纹名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* fingerprint_name;
/** sensor名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
@end
/**
 * 用户请求报警事件列表
 **/
@interface AJBReAlarmEventList : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAlarmEventinfo*>* AlarmEvents;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
/** 默认是0 表示全部类型 */
@property(nonatomic, readwrite) int selAlarmtype;
/** 默认是空 开始时间 格式：2015-05-05 17:06:00 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* begintime;
@property(nonatomic, readwrite, copy, null_resettable) NSString* endtime;
/** 1 所有的告警 2 自己的告警 3 别人的告警 */
@property(nonatomic, readwrite) int listType;
@end
/**
 * 设备事件信息
 **/
@interface AJBDeviceEventinfo : NSObject<NSCopying>
@property(nonatomic, readwrite) AJBESensorType SensorType;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
/** 事件时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* event_time;
/** 事件类型, EAlarmType中的 18, 19, 25, 20, 27, 26, 28, 29, 22, 30, 31, 33, 37, 39, 41, 42类型,请查看EAlarmType类型 */
@property(nonatomic, readwrite) AJBEAlarmType EventType;
/** 是否已处理 */
@property(nonatomic, readwrite) BOOL isdeal;
/** 事件id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* eventid;
/** 指纹名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* fingerprint_name;
/** sensor名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
@end
/**
 * 用户请求设备事件列表
 **/
@interface AJBReDeviceEventlist : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEventinfo*>* DeviceEvents;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
@end
/**
 * 服务事件信息
 **/
@interface AJBServiceEventinfo : NSObject<NSCopying>
/** 事件时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* event_time;
/** 事件类型(0:未知、10：布防成功、11:布防失败、12:撤防成功、13:撤防失败、20、添加商铺、21：删除商铺、30:添加IPC 31:删除IPC 32:IPC升级 33:云空间不足 34:云空间快满(80%~100%)) */
@property(nonatomic, readwrite, copy, null_resettable) NSString* EventType;
/** 是否已处理 */
@property(nonatomic, readwrite) BOOL isdeal;
/** 事件id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* eventid;
/** 事件描述 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* event_content;
@end
/**
 * 用户服务事件列表
 **/
@interface AJBReServiceEventlist : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBServiceEventinfo*>* ServiceEvents;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
@end
/**
 * 同步Ipc的在线状态   AppService-->App
 **/
@interface AJBIpcOnlineStatus : NSObject<NSCopying>
/** 请求字段 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
/** 请求字段 --true 代表上线；false 代表下线 */
@property(nonatomic, readwrite) BOOL isOnline;
/** 由app扫描设备上的二维码后得到的设备序列号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* production_id;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 对讲掉线推送消息
 **/
@interface AJBIpcRtpTimeout : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 描述内容，例如：01 pic 已经停止对讲 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* content;
@end
/**
 * 告警消息, app服务推送到app
 **/
@interface AJBIpcWarnInfo : NSObject<NSCopying>
/** 告警类型 */
@property(nonatomic, readwrite) AJBEAlarmType alarm_type;
/** ipcid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_name;
/** 告警信息说明 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* warn_msg;
/** 录像id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* record_id;
/** 告警信息批量说明 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* warn_msg_muti;
/** 传感器类型(01:ipc， 35，36：智能网关) */
@property(nonatomic, readwrite) int sensor_type;
@end
/**
 * 商铺邀请的用户列表
 **/
@interface AJBAddressVisitors : NSObject<NSCopying>
/** 商铺被邀请的用户信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAddressUser*>* addusers;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
@interface AJBAddressUser : NSObject<NSCopying>
/** 商铺id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
/** 商铺被邀请的用户信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBUserAllInfo*>* users;
@end
/**
 * Ipc 升级结果推送消息
 **/
@interface AJBIpcUpdateResult : NSObject<NSCopying>
/** 返回字段---ipc的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** 返回字段，升级结果 */
@property(nonatomic, readwrite) AJBEUpdateResult up_result;
/** 返回ipc的名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
@end
/**
 * 验证手机号码是否存在
 **/
@interface AJBMobileExists : NSObject<NSCopying>
/** 手机号码 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile;
/** true 存在 false 不存在 */
@property(nonatomic, readwrite) BOOL isExists;
/** 1 商铺报警 2 智能家居 */
@property(nonatomic, readwrite) int app_type;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 厂商 默认:anjubao */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
@end
/**
 * 检查可以升级的所有ipc,系统登陆后调用，已废弃
 **/
@interface AJBCheckAllIpcUpdate : NSObject<NSCopying>
/** 可以升级的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipc_vs;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 一键升级所有ipc,登陆后检查，用户点击确认升级所有的ipc
 * 先从升级服务器查到最新版本号，比较版本号，然后使用AllIpcUpdate这个消息让ipc升级，升级的软件包地址填在这个字段里
 * IpcInfomation的updateUrl字段里
 **/
@interface AJBAllIpcUpdate : NSObject<NSCopying>
/** 可以升级的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipc_vs;
/** 一键升级失败的ipc，先定义着，暂时没用 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipc_vs_err;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 下载ipc卡上的录像文件
 **/
@interface AJBappDownloadIpcFile : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** 文件的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_id;
/** 从这个时间点开始推 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* time_stamp;
@property(nonatomic, readwrite, copy, null_resettable) NSString* rtsp_url;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取ipc卡某月的录像信息
 **/
@interface AJBappGetIpcFileMonthInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** 月份范围 输入格式 2015-05 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* get_month;
/** 该月哪些天有录像 日期格式 2015-05-22 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* has_record_days;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取ipc卡上某天的录像文件
 **/
@interface AJBappGetIpcFileInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** 获取天, 日期格式 2015-05-22 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* get_day;
/** 该天所有的录像文件 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcFile*>* ipcfiles;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每页条数 默认20 最大120 */
@property(nonatomic, readwrite) int limit;
/** 从第几条开始 默认0 */
@property(nonatomic, readwrite) int offset;
/** 文件总数  ipc返回 */
@property(nonatomic, readwrite) int allnum;
@end
/**
 * 设备硬件异常, app服务推送到app
 **/
@interface AJBHardwareWarnInfo : NSObject<NSCopying>
/** 告警类型 */
@property(nonatomic, readwrite) AJBEAlarmType alarm_type;
/** ipcid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_name;
/** 告警信息说明 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* warn_msg;
/** 录像id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* record_id;
/** 传感器类型(01:ipc， 35，36：智能网关) */
@property(nonatomic, readwrite) int sensor_type;
@end
/**
 * 传感器上下线  AppService-->App
 **/
@interface AJBSensorOnlineStatus : NSObject<NSCopying>
/** 请求字段 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_uuid;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
/** 请求字段 --true 代表上线；false 代表下线 */
@property(nonatomic, readwrite) BOOL isOnline;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 检查Ipc是否已经连上服务器,初始加载ipc时用
 **/
@interface AJBrefreshIpcIsOnline : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_productionid;
@property(nonatomic, readwrite) BOOL isOnline;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** ipc厂商 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_factory;
@end
/**
 * 消息服务推送到app的，通知app做一些事情
 **/
@interface AJBAppServerNoticeMsg : NSObject<NSCopying>
/** 这个类型表示app端收到这个推送消息后，需要做的事情。1 获取设备列表 2 */
@property(nonatomic, readwrite) int msg_type;
/** 保留值，现在没用 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* msg_value;
@end
/**
 * 商铺接警点信息
 **/
@interface AJBAddress_OpPointInfomation : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* op_point_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* op_point_name;
@end
/**
 * ipc,wifi扫描
 **/
@interface AJBAppWiFiAPScannig : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
/** Ipc返回的wifi信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBWiFiAPInfo*>* APInfo;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * ipc心跳  Ipc-->IpcService-->
 **/
@interface AJBIpcHeartBeat : NSObject<NSCopying>
@property(nonatomic, readwrite) int production_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* lan_ip;
@property(nonatomic, readwrite, copy, null_resettable) NSString* wan_ip;
@property(nonatomic, readwrite) AJBErrorCode err_resp;
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
/** ipc厂家,ajb-ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_factory;
@end
/**
 * 请求对讲  App-->AppService-->IpcService -->Ipc
 **/
@interface AJBVoiceTalkReqInfo : NSObject<NSCopying>
@property(nonatomic, readwrite) int req_seq;
/** 请求字段 ipc的id */
@property(nonatomic, readwrite) int production_id;
/** 请求字段 ssrc */
@property(nonatomic, readwrite) int ipc_ssrc;
/** app支持的codec */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBCodecInfo*>* app_support_codecs;
/** 请求字段, 对讲服务的ip和port */
@property(nonatomic, readwrite, copy, null_resettable) AJBNetworkAddress* vts_addr;
/** 返回字段,返回ipc选择的codec */
@property(nonatomic, readwrite, copy, null_resettable) AJBCodecInfo* ipc_sel_codec;
/** 返回字段 */
@property(nonatomic, readwrite) AJBErrorCode err_resp;
/** 返回字段 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
/** 请求的app ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_mac;
/** 对讲服务的ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* server_host;
/** 对讲服务提供的rtp over tcp端口 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* tcp_port;
/** 对讲服务提供的rtp over udp端口 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* rtp_port;
/** 对讲服务提供的rtcp端口 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* rtcp_port;
@property(nonatomic, readwrite) int start_upload;
@end
/**
 * 停止对讲   App-->AppService-->IpcService -->Ipc
 **/
@interface AJBVoiceTalkStop : NSObject<NSCopying>
@property(nonatomic, readwrite) int req_seq;
/** 请求字段 ipc的id */
@property(nonatomic, readwrite) int production_id;
/** 请求字段 ssrc */
@property(nonatomic, readwrite) int ipc_ssrc;
/** 返回字段 */
@property(nonatomic, readwrite) AJBErrorCode err_resp;
/** 返回字段 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
/** 请求的app ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_mac;
@end
/**
 * 设备控制
 **/
@interface AJBDeviceControl : NSObject<NSCopying>
@property(nonatomic, readwrite) int req_seq;
/** ipc的生产序列号 */
@property(nonatomic, readwrite) int production_id;
/** 传感器的mac 也就是id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
/** 功能类型 */
@property(nonatomic, readwrite) int act_type;
/** 功能值 */
@property(nonatomic, readwrite) int act_value;
/** 是否ipc */
@property(nonatomic, readwrite) BOOL is_ipc;
@property(nonatomic, readwrite) AJBErrorCode err_resp;
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
/** 传感器设备类型 */
@property(nonatomic, readwrite) int device_type;
/** ipc uuid上层传递的时候需要 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
@end
/**
 * 进入情景
 **/
@interface AJBIPCOpenScence : NSObject<NSCopying>
@property(nonatomic, readwrite) int req_seq;
@property(nonatomic, readwrite) int production_id;
/** 情景uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_uuid;
/** 这里面是进入情景失败的设备 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcScenceInfomation*>* ipc_failscences;
@property(nonatomic, readwrite) AJBErrorCode err_resp;
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
@property(nonatomic, readwrite, copy, null_resettable) NSString* userid;
@end
/**
 * 联动情景报警 模式
 **/
@interface AJBLinkageScenceAlarm : NSObject<NSCopying>
@property(nonatomic, readwrite) int req_seq;
@property(nonatomic, readwrite) int production_id;
/** 联动指定情景uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_uuid;
/** 需要联动传感器的mac 也就是id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
/** 联动开始执行时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* startruntimer;
/** 联动结束执行时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* stopruntimer;
/** 执行状态 0 为关闭该功能；1为开启该功能 */
@property(nonatomic, readwrite) BOOL runstatus;
@property(nonatomic, readwrite) AJBErrorCode err_resp;
@property(nonatomic, readwrite, copy, null_resettable) NSString* err_desc;
/** ipc厂家,ajb-ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_factory;
/** ipc uuid上层传递的时候需要 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_uuid;
@end
/**
 * 指纹id与情景对应关系
 **/
@interface AJBFingerPrintScence : NSObject<NSCopying>
/** ipcID */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 传感器也就是锁的mac */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_mac;
/** 给指纹命名 上层显示用 ipc不用关注 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* FingerPrintName;
/** 备用名 暂时不用 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* FingerPrintName1;
/** 指纹ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString* FingerPrintID;
/** 情景ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_id;
/** 情景name 上层显示用 ipc不用关注 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_name;
@end
/**
 * 网络地址
 **/
@interface AJBNetworkAddress : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ip;
@property(nonatomic, readwrite) int port;
@end
/**
 * 传感器子节点
 **/
@interface AJBSensorChildEntity : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_name;
/** 设备类型 逻辑上的分类，学习型红外转发器使用,类型见ESensorType,从500开始 */
@property(nonatomic, readwrite) int device_type;
/** 设备的顺序 0 表示第一路 */
@property(nonatomic, readwrite) int device_num;
/** 设备的值 如 0 关 1 开 */
@property(nonatomic, readwrite) int device_value;
/** 房间的id，上层需要 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomid;
/** 老大传感器的mac地址,扫描出来的那个id号 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_mac;
/** 传感器类型， 煤气 烟感 */
@property(nonatomic, readwrite) AJBESensorType sensor_type;
/** 情景id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* Scence_id;
@end
/**
 * codec信息
 **/
@interface AJBCodecInfo : NSObject<NSCopying>
/** 编码类型名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* plname;
/** 负荷类型 */
@property(nonatomic, readwrite) int pltype;
/** 采样频率 */
@property(nonatomic, readwrite) int plfreq;
/** 一帧样本数 */
@property(nonatomic, readwrite) int pacsize;
/** 通道数 */
@property(nonatomic, readwrite) int channels;
/** 比特率 */
@property(nonatomic, readwrite) int bitrate;
/** 采样精度， 8/16位 */
@property(nonatomic, readwrite) int precision;
@end
/**
 * ipc文件信息
 **/
@interface AJBIpcFile : NSObject<NSCopying>
/** 文件名 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_name;
/** 文件路径 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_path;
/** 文件大小 kb */
@property(nonatomic, readwrite) int file_size;
/** 文件类型 */
@property(nonatomic, readwrite) int file_type;
/** 开始时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_begintime;
/** 结束时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_endtime;
/** 文件id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_id;
/** I帧开始时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* file_I_begintime;
@end
/**
 * 情景
 **/
@interface AJBIpcScenceInfomation : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_uuid;
/** 传感器mac */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
@property(nonatomic, readwrite) int ipc_production_id;
@property(nonatomic, readwrite) BOOL is_ipc;
/** 功能类型,如果是学习型红外,为虚拟设备号 */
@property(nonatomic, readwrite) int act_type;
/** 功能值,如果是学习型红外,为按键号 */
@property(nonatomic, readwrite) int act_value;
/** 设备名字(如果是ipc则是ipc名字,如果是sensor则是sensor名字) */
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_name;
/** scence名字 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_name;
@end
/**
 * WiFi 路由信息
 **/
@interface AJBWiFiAPInfo : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSData* ssid;
@property(nonatomic, readwrite, copy, null_resettable) NSString* password;
/** 加密方式 */
@property(nonatomic, readwrite) AJBIpcEncryptType encryptType;
/** MAC地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* bssid;
@end
/**
 * 循环周期
 **/
@interface AJBSetRecord_policy : NSObject<NSCopying>
/** 表示星期几 */
@property(nonatomic, readwrite) int day;
/** 表示开始时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* start_time;
/** 表示结束时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* stop_time;
/** 表示当天24小时都录制 */
@property(nonatomic, readwrite) BOOL all_day;
/** 表示是否循环 */
@property(nonatomic, readwrite) BOOL is_cycle;
@end
/**
 * 智能家居用户登陆
 **/
@interface AJBHomeUserLogin : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* email;
/** 登录手机号 必填 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* mobile;
/** 密码 md5加密 必填 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pwd;
/** 用户登录时建立的queue,连接ip */
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_ip;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_port;
/** 队列名称及其他属性 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_queuename;
@property(nonatomic, readwrite, copy, null_resettable) NSString* broker_connection_options;
/** 是否推送告警 */
@property(nonatomic, readwrite) BOOL is_push;
/** 服务返回userid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* userid;
/** 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* clientid;
/** 错误码 服务返回 */
@property(nonatomic, readwrite) AJBErrorCode res;
/** 错误信息 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 系统类型, 登陆时app填写 */
@property(nonatomic, readwrite) AJBTerminalOSType ostype;
/** 设备id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_id;
/** 1 商铺报警 2 智能家居 */
@property(nonatomic, readwrite) int app_type;
/** 语言类型 1 中文 2 英文 弃用 */
@property(nonatomic, readwrite) int lang_type;
/** 区域type , 1国内, 2海外 app填写, 必填 */
@property(nonatomic, readwrite) int app_area_type;
/** 智能家居用 1 子帐号 2 主账号, 服务返回 */
@property(nonatomic, readwrite) int isChildAccount;
/** 用户图像地址 服务返回 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* user_picurl;
/** 用户图像上传的地址 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* upload_picurl;
/** 主账号id 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* main_userid;
/** 主账号手机号码 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* main_usermobile;
/** app厂商 app填写 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
/** 帐号名字 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* username;
/** 服务返回, http推送url, 不可靠推送 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url;
/** 服务返回, 初始推送url, 返回未收到的推送消息数量 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url2;
/** 服务返回, http推送url,可靠推送 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* pull_url_safe;
/** 用户住址 服务返回 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* user_addr;
/** app语言环境 */
@property(nonatomic, readwrite) AJBLangType language;
/** 所在时区 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* time_zone;
/** 时区偏移值 */
@property(nonatomic, readwrite) int time_zone_offset;
@end
/**
 * 设备实体
 * 注意：发送控制命令给ipc的时候，DeviceEntity 消息体内各字段的含义。
 * 1.ipc端根据 device_status_type 和 device_status 控制对应的传感器
 * 2.ipc操作完毕之后需要上送最新的状态列表给云端，列表存在 Device_child 域
 * 
 **/
@interface AJBDeviceEntity : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_name;
/** 当设备不是ipc时，这个类型表示传感器类型 */
@property(nonatomic, readwrite) int device_type;
/** 设备的值 0 关 1 开 */
@property(nonatomic, readwrite) int device_status;
/** 设备是否ipc */
@property(nonatomic, readwrite) BOOL isipc;
/** ipcid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 顺序 */
@property(nonatomic, readwrite) int device_status_type;
/** 如果设备是传感器，而且这个对象有值 说明传感器有子节点，这时候界面上应该显示传感器的子节点而不是传感器本身,如二位灯控 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBSensorChildEntity*>* Device_child;
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_mac;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_production_id;
@end
/**
 * 房间实体
 **/
@interface AJBRoomEntity : NSObject<NSCopying>
/** id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomid;
/** 房间名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomname;
/** 图片地址，app先上传完图片再把地址传给我 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* picurl;
/** 房间类型 默认0 */
@property(nonatomic, readwrite) int roomtype;
/** 房间下面的设备 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* alldevice;
/** 地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * 帐号实体
 **/
@interface AJBAccountEntity : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* usermobile;
@property(nonatomic, readwrite, copy, null_resettable) NSString* userid;
@property(nonatomic, readwrite, copy, null_resettable) NSString* username;
@property(nonatomic, readwrite, copy, null_resettable) NSString* userpicurl;
/** 1 主账号 2 子帐号 */
@property(nonatomic, readwrite) int accounttype;
@end
/**
 * 情景实体
 **/
@interface AJBScenceEntity : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_name;
/** 情景类型，以后有用 */
@property(nonatomic, readwrite) int scence_type;
/** 保留，暂不用 */
@property(nonatomic, readwrite) int scence_value;
/** 情景描述信息 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_info;
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_userid;
/** 给ipc用的一个整数 */
@property(nonatomic, readwrite) int scence_code;
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBLinkageScenceAlarm*>* ipc_linkagescences;
/** 情景涉及的ipcid */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* ipc_infos;
/** 定时时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* open_time;
/** 是否打开定时 */
@property(nonatomic, readwrite) BOOL is_open_time;
/** 地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * 情景设备实体
 **/
@interface AJBScenceDeviceEntity : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* device_id;
/** 开关状态 0 关 1 开,如果是学习型红外,表示按键号 */
@property(nonatomic, readwrite) int scence_status;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 设备是否ipc */
@property(nonatomic, readwrite) BOOL isipc;
/** 设备值类型，目前表示灯的顺序, 如果是学习型红外,这个值是虚拟设备号 */
@property(nonatomic, readwrite) int scence_status_type;
@end
/**
 * 获取用户的所有房间
 **/
@interface AJBGetAllRoom : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBRoomEntity*>* allrooms;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 主用户获取所有的子帐号
 **/
@interface AJBGetAllSubUser : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAccountEntity*>* subaccounts;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取所有情景
 **/
@interface AJBGetAllScence : NSObject<NSCopying>
/** 用户所有的情景 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBScenceEntity*>* allscence;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取单个情景下面的设备
 **/
@interface AJBGetScenceInfo : NSObject<NSCopying>
/** 情景id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_id;
/** 情景下的设备详情 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* scence_device;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 设备操作
 **/
@interface AJBDeviceAction : NSObject<NSCopying>
/** 设备集合 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* device;
/** 操作失败的设备集合 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* failed_device;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取房间设备状态
 **/
@interface AJBRoomDeviceStatus : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomid;
/** 设备集合 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* device;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 家庭一键布防
 **/
@interface AJBHomeSetAgainst : NSObject<NSCopying>
/** 家的ID，等同于商铺id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_id;
/** 布防、撤防 */
@property(nonatomic, readwrite) BOOL safe_status;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 不成功的ipc */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcInfomation*>* unsecess_ipcs;
@property(nonatomic, readwrite) int address_type;
/** 布防延时 0:立刻执行 */
@property(nonatomic, readwrite) int defense_delay;
@end
/**
 * ipc传感器数据，空气质量，温度，==
 **/
@interface AJBIpcSensorData : NSObject<NSCopying>
/** uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 传感器类型 */
@property(nonatomic, readwrite) int sensor_type;
/** 传感器值 */
@property(nonatomic, readwrite) int sensor_value;
/** 数据的时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* datatime;
/** 传感器名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_name;
/** ipc名称 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_name;
/** 传感器值1 */
@property(nonatomic, readwrite) int sensor_value1;
@end
/**
 * 获取当前最新的空气质量
 **/
@interface AJBGetIpcAirQuality : NSObject<NSCopying>
/** 家的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_id;
/** 空气质量等级 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBIpcSensorData*>* QualityLevel;
/** 开始时间 格式：2015-05-05 17:06:00 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* begin_time;
/** 结束时间 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* end_time;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** ipcid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
@end
/**
 * 用户添加家(商铺)
 **/
@interface AJBUserAddHome : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite, copy, null_resettable) NSString* name;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite) int address_type;
/** 电话 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_mobile;
/** 地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_addr;
@property(nonatomic, readwrite, copy, null_resettable) AJBAddressInfo* address;
@end
/**
 * 获取一个房间的数据
 **/
@interface AJBGetRoomDevice : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* roomid;
@property(nonatomic, readwrite, copy, null_resettable) AJBRoomEntity* roominfo;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取家里所有的传感器
 **/
@interface AJBGetHomeAllSensor : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_id;
/** 所有的传感器 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAppSensorInfo*>* sensors;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取全家的设备状态
 **/
@interface AJBHomeDeviceStatus : NSObject<NSCopying>
/** 家的id,也就是商铺的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_id;
/** 设备集合 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEntity*>* device;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取某个情景的联动设备(传感器)
 **/
@interface AJBGetLinkageScenceAlarm : NSObject<NSCopying>
/** 情景ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString* scence_id;
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBLinkageScenceAlarm*>* ipc_linkagescences;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 获取设置锁的指纹名称、情景
 **/
@interface AJBGetLockFingerPrint : NSObject<NSCopying>
/** 传感器也就是锁的mac */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_mac;
/** 对应关系 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBFingerPrintScence*>* FPScences;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 按地址获取所有情景
 **/
@interface AJBGetAllScence_01 : NSObject<NSCopying>
/** 用户所有的情景 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBScenceEntity*>* allscence;
/** 地址 要传 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 按地址获取用户的所有房间
 **/
@interface AJBGetAllRoom_01 : NSObject<NSCopying>
/** 地址 要传 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBRoomEntity*>* allrooms;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 按地址请求报警事件列表
 **/
@interface AJBReAlarmEventList_02 : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBAlarmEventinfo*>* AlarmEvents;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
/** 默认是0 表示全部类型 */
@property(nonatomic, readwrite) int selAlarmtype;
/** 默认是空 开始时间 格式：2015-05-05 17:06:00 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* begintime;
@property(nonatomic, readwrite, copy, null_resettable) NSString* endtime;
@property(nonatomic, readwrite) int listType;
/** 地址 要传 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * 按地址请求设备事件列表
 **/
@interface AJBReDeviceEventlist_02 : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBDeviceEventinfo*>* DeviceEvents;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 每次查询的条数 */
@property(nonatomic, readwrite) int limit;
/** 查询的偏移量 */
@property(nonatomic, readwrite) int offset;
/** 地址 要传 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* address_id;
@end
/**
 * 获取单个报警的详细信息
 **/
@interface AJBgetAlarmInfo : NSObject<NSCopying>
/** 报警的id */
@property(nonatomic, readwrite, copy, null_resettable) NSString* alarm_id;
/** 报警信息 */
@property(nonatomic, readwrite, copy, null_resettable) AJBAlarmEventinfo* Alarminfo;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 批量查询用户是否存在,app 发给服务
 **/
@interface AJBMutiUsersExists : NSObject<NSCopying>
/** 用户类型 */
@property(nonatomic, readwrite) int app_type;
/** 厂商 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
/** 用户列表 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* users;
/** 存在的列表 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* exists;
/** 不存在的列表 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<NSString*>* notexists;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 批量注册用户,app 发给服务, 不带验证码
 **/
@interface AJBMutiUsersRegitser : NSObject<NSCopying>
/** 用户类型 */
@property(nonatomic, readwrite) int app_type;
/** 用户厂商 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* app_factory;
/** 用户列表 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBUserRegister*>* users;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@end
/**
 * 学习型红外, 添加家电
 **/
@interface AJBAddHomeAppliance : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 红外转发器sensor序列号 mac地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* serial_number;
/** 红外转发器 uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
@property(nonatomic, readwrite, copy, null_resettable) AJBSensorChildEntity* home_appliance;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 服务器返回家电的uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_appliance_id;
@end
/**
 * 学习型红外, 获取红外上添加的所有家电
 **/
@interface AJBGetHomeAppliance : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 红外转发器sensor序列号 mac地址 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* serial_number;
/** 红外转发器 uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* sensor_id;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBSensorChildEntity*>* home_appliances;
@end
@interface AJBApplianceScenceKeySceneInfo : NSObject<NSCopying>
@property(nonatomic, readwrite) int key_number;
/** 空调情景名称, 这里的情景与情景模式无任何关系，只是空调的状态名称,保存在云端 */
@property(nonatomic, readwrite, copy, null_resettable) NSString* key_scence_name;
@end
/**
 * 获取已学习的按键集合
 **/
@interface AJBGetAlreadyStudyApplianceButton : NSObject<NSCopying>
@property(nonatomic, readwrite, copy, null_resettable) NSString* ipc_id;
/** 家电id， uuid */
@property(nonatomic, readwrite, copy, null_resettable) NSString* home_appliance_id;
@property(nonatomic, readwrite) AJBErrorCode res;
@property(nonatomic, readwrite, copy, null_resettable) NSString* ErrDesc;
/** 已学习的按键，如果是空调, key_scence_name有值 */
@property(nonatomic, readwrite, copy, null_resettable) NSMutableArray<AJBApplianceScenceKeySceneInfo*>* key_scences;
@end
