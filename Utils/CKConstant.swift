//
//  CKConstant.swift
//  qiqi_ios
//
//  Created by design on 2018/6/6.
//  Copyright © 2018年 design. All rights reserved.
//

import UIKit

//MARK:  --  尺寸有关
///屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width
///屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height
///nav height
let kNavHeight = CGFloat(44.0)
///status bar height
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
///main view height
let kMainHeight = kScreenHeight - kNavHeight - kStatusBarHeight
///nav and status bar height
let kTopHeight = kNavHeight + kStatusBarHeight
///nav and status bar height
let kBottomHeight = deviceModel() == "iPhone X" ? CGFloat(34.0) : CGFloat(0.0)
///tabBar height
let kTarBarHeight = CGFloat(49.0)
///mainScale
let kMainScale = UIScreen.main.scale
///one_px
let kOne_px = 1 / kMainScale
let kZeroHeight = CGFloat(0.000001)

//MARK:  --  INFO
///APP  version
let kAppVersion =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
///system version
let kSystemVersion = UIDevice.current.systemVersion
/// uuid
let kDeviceUUID = UIDevice.current.identifierForVendor?.uuidString
///二维码前缀，标识为企企二维码
let codePrefix = "qiqi-"

//MARK:  --  颜色有关
///导航条颜色
let navColorStr = "#92D1F1"
let kNavColor = UIColor.colorSrting(navColorStr)
///默认文字颜色
let kTextDefaultColor = UIColor.colorSrting("#333333")
///黄色字体颜色
let kYellowTextColor = UIColor.colorSrting("#f8b551")
///绿色字体颜色
let kGreenTextColor = UIColor.colorSrting("#80C269")
///nav title color
let kNavTitleColor = UIColor.white
///button normal color
let kBtnNormalColor = UIColor.colorSrting("#666666")
///灰色字体
let kTextGray = UIColor.colorSrting("#999999")
///none image place color
let kNoneImageColor = UIColor.cyan
///back color
let kBackColor = UIColor.white
///cell line color
let kCellLineColr = UIColor.colorSrting("#CCCCCC")
///导航栏按钮字体颜色
let kItemColor = UIColor.colorSrting("#FFFFFF")
///灰色背景
let kBackGray = UIColor.colorSrting("#EBEBEB")
///进行中的绿色---渐变
//"4be24b"----"bffdbf"
let kTaskingColor = UIColor.colorSrting("#4be24b")
let kTaskingEndedColor = UIColor.colorSrting("#bffdbf")
///审核中的蓝---渐变
//80dcfa --- cbf1fd
let kReviewColor = UIColor.colorSrting("#80dcfa")
let kReviewEndedColor = UIColor.colorSrting("#cbf1fd")
///结束灰
//dddddd
let kEndColor = UIColor.colorSrting("#dddddd")

///Placeholder Image
let kPlaceholderImage = UIImage.imageWithColor(kTextGray)

//MARK:  --  通知相关
let noticationDidSeleted = NSNotification.Name(rawValue: "didSeletedNotify")
/// contact did seleted
let contactDidSeleted = NSNotification.Name(rawValue: "contactDidSeleted")
///点击 部门
let departmentDidSeleted = NSNotification.Name(rawValue: "departmentDidSeletedNotify")
///点击查看我公司信息
let companyDidSeleted = NSNotification.Name(rawValue: "companyDidSeletedNotify")
/// chat begin play voice notify key
let noticationPlayAudio = NSNotification.Name(rawValue: "playVoiceNotify")
/// chat begin play voice notify key
let noticationAssignments = NSNotification.Name(rawValue: "assignmentsNotify")
/// 好友状态更新
let contanctsReload = NSNotification.Name(rawValue: "contanctsReloadNotify")
/// 查看会话列表信息清楚未读信息个数
let canalUnReadCount = NSNotification.Name(rawValue: "canalUnReadCountNotify")
/// 群组信息更新
let updateGroupInfo = NSNotification.Name(rawValue: "updateGroupInfoNotify")
/// 任务更新
let reloadTask = NSNotification.Name(rawValue: "reloadTaskNotify")
/// 回复评论
let replyComment = NSNotification.Name(rawValue: "replyCommentNotify")
/// 创建公司成功
let companyInfoReload = NSNotification.Name(rawValue: "companyInfoReloadNotify")
/// 修改个人信息成功
let mineModdifyInfo = NSNotification.Name(rawValue: "mineModdifyInfoNotify")
/// 右滑菜单可用
let menuUsed = NSNotification.Name(rawValue: "menuUsedNotify")
/// 动态新消息
let feedsNewMessages = NSNotification.Name(rawValue: "feedsNewMessagesNotify")


//MARK:   --    通用闭包

///begin request data
typealias Begin = () -> Void
///request data success
typealias Success = (_ result: ResultModel?) -> Void
///request data failur
typealias Failure = (_ error: Error?) -> Void
///finished something call back
typealias Finished = () -> Void
///带参数的回调
typealias CallBackClosure = (_ obj: Any?) -> Void

//MAKR:  --  api

///  http header
let httpHeader = "\(httpHost)"

let rsa2Key = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAN78hVrODBExfXean0+fY/Mn/yV7Bgstt1kuaopQB+NY8mNVm1cwXNav4NI4J+SVXq/r4WPdNcJvVCUYXnNjhPslLAox4LWzwXxAXp/5x07zDcc2ugzmY86S+3HaaCoLS4ZA1I0A5rIKAoUxA5qRcwr3KMjmJsIjaNua1YPoWlMbAgMBAAECgYAXNwUPMhpxg8yDMjbZzEdUnlpi5Y74hPbssvdmlPRtR+pcSyJUDnXr5/2pBS2qD57/A7jAc9xP9NU203Wp37eNWE38/7rM3NUvOBavFjU4C81vNYpOq7NcuY+g+usa1QNyE2ucq6j1w5aPkrzoaykCo4C3I0la8xPlNM+RDKstqQJBAPFTNLx0RpwXorXbcqMWjswLJdcK4GDS695ndJoFDi0lX05g4WNeWWWU6l6lSlEo12ip49cUjh4+9qTg+EEWltUCQQDsi9TBonDVBqKZ79Qx3ydLYwTqahdlyP/vu+2MLLbItvBl1ohWEhEbuuPmWT4NIj/+euTCNhnj0GXttZeJ1xovAkEAqiWPNhwJOL7VYsEht2kNL0Hg4RhzEPFFih6JMJrF3wDNjJZz8zqvbxaqlCaYGlbgYZP+50M/3IVqIt/XSRTjLQJBAM7SvGXJ+EnqkUVzUt+ANEVQAL5NoMOYaV9du6fyeKcqfSst1usaxOawFBAWO5EUP0vsfBPrZduxHU4olqUo9HUCQQDHIG4d92a/30MKLEtVvCOF716ldW0bIlXIzK242WAoaHUB3JnChvamoMQ7kvK0ZpW9cZ1EoICsfPNNEHsZEzVj"

//MARK:   --    第三方集成相关

#if DEVELOPER
let JMessageAppKey = "36f26bee399abed305900060"
let JPushAppKey = "36f26bee399abed305900060"
///http  host
let httpHost = "http://api.dev.qiqi166.com"
let httpStr = "/app"
///阿里云域名
let endPoint = "https://oss-cn-hangzhou.aliyuncs.com"
///阿里云bucketname
let bucketname = "test166"
///获取图片  host
let getImageHost = "https://test166.oss-cn-hangzhou.aliyuncs.com"
#elseif TEST
let JMessageAppKey = "582e1a23f307d3542c82b2b1"
let JPushAppKey = "582e1a23f307d3542c82b2b1"
///http  host
let httpHost = "https://api.test.qiqi166.com"
let httpStr = "/app"
///阿里云域名
let endPoint = "https://oss-cn-hangzhou.aliyuncs.com"
///阿里云bucketname
let bucketname = "test166"
///获取图片  host
let getImageHost = "https://test166.oss-cn-hangzhou.aliyuncs.com"
///高德地图key
let AMapKey = "f2308847156c0dbed322a0d9dede180e"
#elseif RELEASE
let JMessageAppKey = "5e0d92060dd32e6c3d8839d5"
let JPushAppKey = "5e0d92060dd32e6c3d8839d5"
///http  host
let httpHost = "https://api.qiqi166.com"
let httpStr = "/app"
///阿里云域名
let endPoint = "https://oss-cn-beijing.aliyuncs.com"
///阿里云bucketname
let bucketname = "qiqi166"
///获取图片  host
let getImageHost = "https://qiqi166.oss-cn-beijing.aliyuncs.com"
///高德地图key
let AMapKey = "3282dba53104fcab9ff01fb922285c36"
#endif

///微信keys
let WechatAppKey = "wx8c41386996a98f98"
let WechatSecret = "2fdda75b52ffc4616413206b893b0d7b"


//MARK:    --    枚举
enum TeamPossition: String {
    ///执行人
    case executor
    ///负责人
    case manager
    ///审核人
    case reviewer
    ///次要负责人
    case vice_manager
    ///参与人
    case partner
}

enum TaskStatus: String {
    ///全部
    case all = "All"
    ///待分配状态
    case ready = "ready"
    ///执行中
    case running = "running"
    ///已完成、待审核
    case finish = "finish"
    ///审核完成、已结束
    case reviewed = "reviewed"
    case unknown = "unknown"
}

enum GroupType: String {
    ///公司群
    case company = "company"
    ///部门群
    case department = "department"
    ///自建群
    case custom = "custom"
    ///全部群
    case all = "all"
}

///部门类型
enum DepartmentType: String {
    ///管理 部门
    case admin = "admin"
    ///默认
    case normal = "normal"
}

///性别
enum GenderType: String {
    ///管理 部门
    case man = "man"
    ///默认
    case woman = "woman"
}

///任务操作行为
enum Operate: String {
    ///未知操作
    case unKnow = "unKnow"
    ///创建
    case create = "create"
    ///修改
    case modify = "modify"
    ///评论
    case comment = "comment"
    ///分配
    case allot = "allot"
    ///删除
    case delete = "delete"
}

///任务操作类型
enum ExtrasType: String {
    ///任务信息
    case info = "info"
    ///任务名称,
    case name = "name"
    ///地址,
    case address = "address"
    ///开始时间
    case startTime = "startTime"
    ///结束 时间
    case endTime = "endTime"
    ///描述
    case description = "description"
    ///任务细节
    case detail = "detail"
}

///通知类型
enum NotificationType: String {
    ///未知类型
    case unknown
    ///任务日志
    case taskLog
    ///添加好友
    case addFriend
    ///好友申请
    case friendInvitation
    ///部门申请
    case departmentInvitation
    ///部门拉人
    case departmentAdd
    ///动态关于我
    case feedAboutMe
    ///运营者邀请
    case operatorInvitation
    ///小任务等待审核
    case detail_waiting_review
    ///小任务已经审核
    case detail_reviewed
    ///小任务审核失败
    case detail_refuse
    ///分配执行人
    case detail_allocate_executor
    ///项目对接接受邀请
    case dock_accept
    ///项目对接拒绝邀请
    case dock_refuse
}

enum ChatCellModel: Int {
    ///normal cell show text
    case text
    ///voice cell
    case voice
    ///card cell
    case card
    /// article cell
    case article
    ///  call cell
    case call
}

