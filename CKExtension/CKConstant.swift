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

//MARK:   --    通用闭包
///begin request data
typealias Prepare = () -> Void
///request data success
///request data failur
typealias Failure = (_ error: Error?) -> Void
///finished something call back
typealias Completed = () -> Void
///带参数的回调
typealias CallBackClosure = (_ obj: Any?) -> Void

