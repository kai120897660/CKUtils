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
///底部高度
let kBottomHeight = (iPhoneX_All ? CGFloat(34.0) : CGFloat(0.0))
///tabBar height
let kTabBarHeight = CGFloat(49.0)
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

///判断iPhoneX所有系列
let iPhoneX_All = ((kScreenWidth == 375 && kScreenHeight == 812) || (kScreenWidth == 414 && kScreenHeight == 896))

//MARK:  --  颜色有关
///导航条颜色
let navColorStr = "#3F69F9"
let kNavColor = UIColor.colorSrting(navColorStr)
///黄色字体颜色
let kYellowTextColor = UIColor.colorSrting("#f8b551")
///绿色字体颜色
let kGreenTextColor = UIColor.colorSrting("#80C269")
///nav title color
let kNavTitleColor = UIColor.white
///button normal color
let kBtnNormalColor = UIColor.colorSrting("#666666")
///按钮的蓝色
let kBtnBlueColor = UIColor.colorSrting("#0091FF")
///按钮的橙色
let kBtnOrangeColor = UIColor.colorSrting("#F9783F")
///按钮的红色
let kBtnRedColor = UIColor.colorSrting("#DA373A")
///灰色字体
let kTextGray = UIColor.colorSrting("#646464")
///黑色字体颜色
let kTextBlack = UIColor.colorSrting("#313131")
///none image place color
let kNoneImageColor = UIColor.cyan
///back color
let kBackColor = UIColor.groupTableViewBackground
///cell line color
let kCellLineColr = UIColor.colorSrting("#E5E5E5")
///导航栏按钮字体颜色
let kItemColor = UIColor.colorSrting("#FFFFFF")

///灰色背景
let kBackGray = UIColor.colorSrting("#DCDCDC")

///结束灰
let kEndColor = UIColor.colorSrting("#dddddd")

///浅灰色
let kLightGrayColor = UIColor.colorSrting("#959595")
///蓝色
let kBlueColor = UIColor.colorSrting("#0090FF")
///弹出框背景颜色
let kPopBackColor = UIColor.colorSrting("#000000", alpha: 0.25)

///Placeholder Image
let kPlaceholderImage = UIImage.imageWithColor(kLightGrayColor)

//MARK:   --    通用闭包

///begin request data
typealias Prepare = () -> Void
///request data success
//typealias Success = (_ result: ResultModel?) -> Void
///request data failur
typealias Failure = (_ error: Error?) -> Void
///finished something call back
typealias Completed = () -> Void
///带参数的回调
typealias CallBackClosure = (_ obj: Any?) -> Void

//MARK:   ---     第三方key
let JPushAppKey = "30da585013900570e8cbb9bd"

///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
let iBoxStatuscolors = ["#6DC465", "#E4892E", "#AFB0AF", "#D62E11", "#A95FDC", "#F0379C"]
