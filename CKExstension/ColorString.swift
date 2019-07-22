//
//  colorString.swift
//  qiqi_ios
//
//  Created by design on 2018/6/6.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit

@objc extension UIColor {
    class func colorSrting(_ string: String) -> UIColor {
        return self.colorSrting(string, alpha: 1.0)
    }
    class func colorSrting(_ string: String, alpha: CGFloat) -> UIColor {
        
        var colorString : String!
        if (string.hasPrefix("#")) {
            
            colorString = String(string.suffix(string.count - 1))
        }
        
        
        if (colorString.count != 6) {
            
            return UIColor.gray
            
        }
        
        
        let rString = String(colorString.prefix(2))
        
        let gIndex = string.index(colorString.startIndex, offsetBy: 2)
        let gStr = String(colorString.suffix(from: gIndex))
        let gString = String(gStr.prefix(2))
        
        let bString = String(colorString.suffix(2))
        
        
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rString).scanHexInt32(&r)
        
        Scanner(string: gString).scanHexInt32(&g)
        
        Scanner(string: bString).scanHexInt32(&b)
        
        
        
        return UIColor(red:CGFloat(r) / 255.0,
                       green:CGFloat(g) / 255.0,
                       blue:CGFloat(b) / 255.0,
                       alpha: alpha)
    }
}
