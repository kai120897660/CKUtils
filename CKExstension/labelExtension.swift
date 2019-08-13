//
//  labelExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/8/16.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit

@objc extension UILabel {
    func textShadow(_ str: String) {
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize.init(width: 1, height: 1)
        myShadow.shadowColor = UIColor.gray
        
        let attributedStr = NSAttributedString.init(string: str.nilString(), attributes: [NSAttributedString.Key.shadow : myShadow])
        self.attributedText = attributedStr
    }
    
    class func ck_label(_ fontSize: CGFloat) ->  UILabel {
        let label = UILabel()
        label.textColor = kTextBlack
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    
}
