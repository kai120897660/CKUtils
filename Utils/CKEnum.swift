//
//  CKEnum.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/13.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit


//MARK:   ---    枚举
///沃阿汇成绩汇总类型
enum ScoreType: Int {
    ///魔方任务
    case mofangMission
    ///隐患排查
    case hiddenTrouble
    ///抢答软件
    case replySoftware
    ///答题软件
    case answerSoftware
    
}

///用户身份
enum UserType: Int {
    ///后台管理员
    case admin
    ///管理员/老师
    case teacher
    ///学员
    case student
    ///大后台管理员
    case bigAdmin
    ///超级管理员
    case superAdmin
    ///后台管理员
    case backAdmin
}

///平台类型
enum PlatformType: String {
    ///知筑
    case zhizhu = "zhizhu_platform"
    ///沃阿汇
    case wah = "wah_platform"
    ///hse
    case hse = "hse_platform"
}

///通知类型
enum NotificationType: String {
    ///预约二维码开门禁
    case reseverStatus = "ibox_resever_status"
    ///学生二维码扫码开门
    case openStatus = "ibox_open_status"
}

///预约二维码开门状态
enum IBoxReserveStatus: Int {
    
    ///未开始
    case unBegin
    ///成功
    case success
    ///预约时间失效
    case invalid
    ///iBox和预约任务不匹配
    case mismatch
    ///迟到
    case late
}

///修改用户信息
enum EditUserInfo: Int {
    case userName
    case number
//    case job
    case email
    case detailAddress
    case signature
    case releaseMission
}
