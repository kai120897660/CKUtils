//
//  CKFunction.swift
//  qiqi_ios
//
//  Created by design on 2018/6/20.
//  Copyright © 2018年 design. All rights reserved.
//

import UIKit
import Photos

func ck_print(_ items: Any?) {
    #if DEBUG
    if items != nil {
        print(items!)
    }
    #endif
}

///当前环境是否是生产环境
func isDistribution() ->  Bool {
    var isDis = true
    #if DEBUG
    isDis = false
    #endif
    return isDis
}

///localized language
func localizedString(_ key: String) -> String {
    
    return ""//LanguageUtils.shared.bundle.localizedString(forKey: key, value: nil, table: "InfoPlist")
}

func localizedGroup(_ key1: String, _ key2: String) -> String {
    let word1 = localizedString(key1)
    let word2 = localizedString(key2)
    return word1 + word2
}

///字体大小
func ck_fontSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

//MARK:  --    以6为标准比例缩放
///width scaled
func kScreenWidthScale(_ num: CGFloat) -> CGFloat {
    return (kScreenWidth / 375.0) * num
}
///height scaled
func kScreenHeightScale(_ num: CGFloat) -> CGFloat{
    return (kScreenHeight / 667.0) * num
}

typealias DoneClosure = (_ index: Int) -> ()

///默认弹出框
func alertViewShow(title: String,leftTitle: String?, rightTitle: String?, doneAction: DoneClosure?) {
    let alertVC = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
    if let leftTitle = leftTitle {
        alertVC.addAction(UIAlertAction.init(title: leftTitle, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(0)
        }))
    }
    if let rightTitle = rightTitle {
        alertVC.addAction(UIAlertAction.init(title: rightTitle, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(1)
        }))
    }
    currentVC().present(alertVC, animated: true, completion: nil)
}

func alertViewShow(title: String, doneAction: DoneClosure?) {
    let alertVC = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
//    alertVC.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.default, handler: { (action) in
//        doneAction?(0)
//    }))
    alertVC.addAction(UIAlertAction.init(title: localizedString("Confirm"), style: UIAlertAction.Style.default, handler: { (action) in
        doneAction?(1)
    }))
    currentVC().present(alertVC, animated: true, completion: nil)
}

///下滑弹出框
func sheetViewShow(textArray: Array<String>, doneAction: DoneClosure?) {
    let alertVC = UIAlertController()//.init(title: "", message: "", preferredStyle: .actionSheet)
    var index = 0
    for text in textArray {
        let action = UIAlertAction.init(title: text, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(textArray.indexObj(action.title!))
        })
        alertVC.addAction(action)
        if text == localizedString("Delete") {
            action.setValue(UIColor.red, forKey: "titleTextColor")
        }
        index += 1
    }
    alertVC.addAction(UIAlertAction.init(title: localizedString("Cancel"), style: .cancel, handler: { (action) in
//        alertVC.dismiss(animated: true, completion: nil)
    }))
    
    currentVC().present(alertVC, animated: true, completion: nil)
}

///相机、相册选项弹出框
func cameraSheetShow(_ doneAction: DoneClosure?) {
    sheetViewShow(textArray: [localizedString("Take Photo"), localizedString("Select from album")], doneAction: doneAction)
}

func currentVC() -> UIViewController {
    var VC = UIApplication.shared.keyWindow?.rootViewController
    
//    VC = VC?.children.first
    if let nav = VC as? UINavigationController {
        VC = nav.children.last
        if let tab = VC as? UITabBarController {
            VC = tab.viewControllers![tab.selectedIndex]
        }
    }else if let tab = VC as? UITabBarController {
        VC = tab.viewControllers![tab.selectedIndex]
        if let nav = VC as? UINavigationController {
            VC = nav.children.last
        }
    }

//    VC = (VC?.navigationController?.viewControllers.last)!
    
    return VC!
}

///弹出框的显示
///成功
func showSuccess(_ text: String) {
//    SVProgressHUD.showSuccess(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}
///错误
func showError(_ text: String) {
//    SVProgressHUD.showError(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}
///信息
func showInfo(_ text: String) {
//    SVProgressHUD.showInfo(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
//    alertViewShow(title: text, doneAction: nil)
}
///文字
func showNone(_ text: String)  {
//    SVProgressHUD.show(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}


///获取设备型号
func deviceModel () -> String? {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    switch identifier {
    //iPhone
    case "iPhone1,1":                 return "iPhone 1G"
    case "iPhone1,2":                 return "iPhone 3G"
    case "iPhone2,1":                 return "iPhone 3GS"
    case "iPhone3,1", "iPhone3,2":    return "iPhone 4"
    case "iPhone4,1":                 return "iPhone 4S"
    case "iPhone5,1", "iPhone5,2":    return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":    return "iPhone 5C"
    case "iPhone6,1", "iPhone6,2":    return "iPhone 5S"
    case "iPhone7,1":                 return "iPhone 6 Plus"
    case "iPhone7,2":                 return "iPhone 6"
    case "iPhone8,1":                 return "iPhone 6s"
    case "iPhone8,2":                 return "iPhone 6s Plus"
    case "iPhone8,4":                 return "iPhone SE"
    case "iPhone9,1", "iPhone9,3":    return "iPhone 7"
    case "iPhone9,2", "iPhone9,4":    return "iPhone 7 Plus"
    case "iPhone10,1", "iPhone10,4":  return "iPhone 8"
    case "iPhone10,2", "iPhone10,5":  return "iPhone 8 Plus"
    case "iPhone10,3", "iPhone10,6":  return "iPhone X"
    case "iPhone11,2":                return "iPhone XS"
    case "iPhone11,4", "iPhone11,6":  return "iPhone XS Max"
    case "iPhone11,8":                return "iPhone XR"
    case "i386", "x86_64":                          return "Simulator"
    default:
        return identifier
    }
}

class CKFunction: NSObject {
    @objc class func ck_localizedString(_ key: String) -> String {
        return localizedString(key)
    }
}
