//
//  UILabelExtension.swift
//  CKUtils
//
//  Created by APPLE on 2019/8/23.
//  Copyright © 2019 ck.com. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    public func textShadow(_ str: String) {
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize.init(width: 1, height: 1)
        myShadow.shadowColor = UIColor.gray
        
        let attributedStr = NSAttributedString.init(string: str.nilString(), attributes: [NSAttributedString.Key.shadow : myShadow])
        self.attributedText = attributedStr
    }
    
    class public func ck_label(_ fontSize: CGFloat) ->  UILabel {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: fontSize)
        return label
    }
}
