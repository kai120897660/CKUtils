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
public let kScreenWidth = UIScreen.main.bounds.size.width
///屏幕高度
public let kScreenHeight = UIScreen.main.bounds.size.height
///nav height
public let kNavHeight = CGFloat(44.0)
///status bar height
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
///main view height
public let kMainHeight = kScreenHeight - kNavHeight - kStatusBarHeight
///nav and status bar height
public let kTopHeight = kNavHeight + kStatusBarHeight
///底部高度
public let kBottomHeight = (iPhoneX_All ? CGFloat(34.0) : CGFloat(0.0))
///tabBar height
public let kTabBarHeight = CGFloat(49.0)
///mainScale
public let kMainScale = UIScreen.main.scale
///one_px
public let kOne_px = 1 / kMainScale
public let kZeroHeight = CGFloat(0.000001)

//MARK:  --  INFO
///APP  version
public let kAppVersion =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
///system version
public let kSystemVersion = UIDevice.current.systemVersion
/// uuid
public let kDeviceUUID = UIDevice.current.identifierForVendor?.uuidString

///判断iPhoneX所有系列
public let iPhoneX_All = ((kScreenWidth == 375 && kScreenHeight == 812) || (kScreenWidth == 414 && kScreenHeight == 896))

//MARK:  --  颜色有关
///导航条颜色
public let navColorStr = "#3F69F9"
public let kNavColor = UIColor.colorSrting(navColorStr)
///黄色字体颜色
public let kYellowTextColor = UIColor.colorSrting("#f8b551")
///绿色字体颜色
public let kGreenTextColor = UIColor.colorSrting("#80C269")
///nav title color
public let kNavTitleColor = UIColor.white
///button normal color
public let kBtnNormalColor = UIColor.colorSrting("#666666")
///按钮的蓝色
public let kBtnBlueColor = UIColor.colorSrting("#0091FF")
///按钮的橙色
public let kBtnOrangeColor = UIColor.colorSrting("#F9783F")
///按钮的红色
public let kBtnRedColor = UIColor.colorSrting("#DA373A")
///灰色字体
public let kTextGray = UIColor.colorSrting("#646464")
///黑色字体颜色
public let kTextBlack = UIColor.colorSrting("#313131")
///none image place color
public let kNoneImageColor = UIColor.cyan
///back color
public let kBackColor = UIColor.groupTableViewBackground
///cell line color
public let kCellLineColr = UIColor.colorSrting("#E5E5E5")
///导航栏按钮字体颜色
public let kItemColor = UIColor.colorSrting("#FFFFFF")

///灰色背景
public let kBackGray = UIColor.colorSrting("#DCDCDC")

///结束灰
public let kEndColor = UIColor.colorSrting("#dddddd")

///浅灰色
public let kLightGrayColor = UIColor.colorSrting("#959595")
///蓝色
public let kBlueColor = UIColor.colorSrting("#0090FF")
///弹出框背景颜色
public let kPopBackColor = UIColor.colorSrting("#000000", alpha: 0.25)

///Placeholder Image
public let kPlaceholderImage = UIImage.imageWithColor(kLightGrayColor)

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
public let JPushAppKey = "30da585013900570e8cbb9bd"

///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
public let iBoxStatuscolors = ["#6DC465", "#E4892E", "#AFB0AF", "#D62E11", "#A95FDC", "#F0379C"]
