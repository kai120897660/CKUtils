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
    if !isDistribution() && items != nil {
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
//    let word = Bundle.main.loadNibNamed(key, owner: "", options: nil) as? String
    let word = NSLocalizedString(key, comment: "")
    return word
}

func localizedGroup(_ key1: String, _ key2: String) -> String {
    let word1 = localizedString(key1)
    let word2 = localizedString(key2)
    return word1 + word2
}

///filter nil string
func nilString(_ str: String?) -> String {
    return String.nilString(str)
}

func numString(_ str: String?) -> CGFloat {
    if str == nil || str == "(null)" || str == "null" || (str?.isEmpty)! {
        return 0
    }
    if let num = Float(str!) {
        return CGFloat(num)
    }
    return 0
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
    alertVC.addAction(UIAlertAction.init(title: localizedString("Cancel"), style: UIAlertAction.Style.default, handler: { (action) in
        doneAction?(0)
    }))
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
    sheetViewShow(textArray: [localizedString("Album"), localizedString("Take Photo")], doneAction: doneAction)
}

func currentVC() -> UIViewController {
    let window = UIApplication.shared.keyWindow
    var VC = window?.rootViewController
    if (VC?.isKind(of: MainScrollVC.self))! {
        VC = VC?.children.first
        if (VC?.isKind(of: UINavigationController.self))! {
            let nav = VC as? UINavigationController
            VC = nav?.children.last
            if (VC?.isKind(of: UITabBarController.self))! {
                let tab = VC as? UITabBarController
                VC = tab?.viewControllers![(tab?.selectedIndex)!]
            }
        }
    }
    
    return VC!
}

///获取图片完整url
func getImageUrl(_ url: String) -> String {
    return getImageHost + "/\(url)"
}

///弹出框的显示
///成功
func showSuccess(_ text: String) {
    SVProgressHUD.showSuccess(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}
///错误
func showError(_ text: String) {
    SVProgressHUD.showError(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}
///信息
func showInfo(_ text: String) {
    SVProgressHUD.showInfo(withStatus: text)
//    SVProgressHUD.dismiss(withDelay: 2.0)
}
///文字
func showNone(_ text: String)  {
    SVProgressHUD.show(withStatus: text)
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
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "iPhone X"//"Simulator"
    default:
        return identifier
    }
}
