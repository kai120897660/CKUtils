//
//  labelExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/8/16.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreLocation

@objc extension UILabel {
    func textShadow(_ str: String) {
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize.init(width: 1, height: 1)
        myShadow.shadowColor = UIColor.gray
        
        let attributedStr = NSAttributedString.init(string: nilString(str), attributes: [NSAttributedString.Key.shadow : myShadow])
        self.attributedText = attributedStr
    }
    
    class func ck_label(_ fontSize: CGFloat) ->  UILabel {
        let label = UILabel()
        label.textColor = kTextBlack
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
//    class func lable(frame: CGRect, font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
//        
//        return UILabel()
//    }
}

//UILabel的Rx扩展
extension Reactive where Base: UILabel {
    //实现CLLocationCoordinate2D经纬度信息的绑定显示
    var coordinates: Binder<CLLocationCoordinate2D> {
        return Binder(base) { label, location in
            label.text = "经度: \(location.longitude)\n纬度: \(location.latitude)"
        }
    }
    
    //实现CLLocation地址信息的绑定显示
    var loacionAddress: Binder<CLLocation> {
        return Binder(base) { label, location in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (plackMark, error) in
                if error == nil {
                    let mark = plackMark?.first
                    let markDic = mark?.addressDictionary
                    let name = (markDic!["FormattedAddressLines"] as? [String])?.first
                    let country = markDic!["Country"] as! String
                    label.text = name?.replacingOccurrences(of: country, with: "") ?? ""
                    ck_print(name)
                }else {
                    label.text = "定位失败"
                    ck_print(error)
                }
            }
            
        }
    }
    
    
}
