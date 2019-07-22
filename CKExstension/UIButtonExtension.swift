//
//  UIButtonExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/7/12.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    ///创建导航栏按钮
    class func ck_item(_ obj: Any?) -> UIButton {
        let btn = UIButton()
        btn.ck_size = CGSize.init(width: kNavHeight, height: kNavHeight)
        if let title = obj as? String {
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
        }else if let image = obj as? UIImage {
            btn.setImage(image, for: .normal)
        }
        
        return btn
    }
    
    class func ck_item(image: String, target: Any?, action: Selector?) -> UIButton {
        let btn = UIButton()
        btn.ck_size = CGSize.init(width: kNavHeight, height: kNavHeight)
        if target != nil && action != nil {
            btn.addTarget(target!, action: action!, for: .touchUpInside)
        }
        btn.setImage(UIImage.CK_Image(image), for: .normal)
        
        return btn
    }
    
    class func ck_item(title: String, target: Any?, action: Selector?) -> UIButton {
        let btn = UIButton()
        if target != nil && action != nil {
            btn.addTarget(target!, action: action!, for: .touchUpInside)
        }
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.sizeToFit()
        btn.ck_size = CGSize.init(width: max(kNavHeight, btn.ck_width), height: kNavHeight)
        return btn
    }
    
    class func ck_button(image: String, target: Any?, action: Selector?) -> UIButton {
        let btn = UIButton()
        let img = UIImage.CK_Image(image)
        btn.ck_size = img.size
        if target != nil && action != nil {
            btn.addTarget(target!, action: action!, for: .touchUpInside)
        }
        btn.setImage(img, for: .normal)
        
        return btn
    }
    
    class func ck_button(title: String, target: Any?, action: Selector?) -> UIButton {
        let btn = UIButton()
        if target != nil && action != nil {
            btn.addTarget(target!, action: action!, for: .touchUpInside)
        }
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.sizeToFit()
//        let btnWidth = btn.ck_width > kNavHeight ? btn.ck_width : kNavHeight
        btn.ck_size = CGSize.init(width: btn.ck_width + 12, height: btn.ck_height + 8)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }
    
    class func ck_button(title: String) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.sizeToFit()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }
    
    class func ck_button(image: String) -> UIButton {
        let btn = UIButton()
        let img = UIImage.CK_Image(image)
        btn.ck_size = img.size
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setImage(img, for: .normal)
        
        return btn
    }
    
    class func ck_button(image: String, selectedImg: String) -> UIButton {
        let btn = UIButton.ck_button(image: image)
        btn.setImage(UIImage.CK_Image(selectedImg), for: .selected)
        
        return btn
    }
}


