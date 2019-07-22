//
//  ImageExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/6/8.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit

@objc extension UIImage {
    ///init image form file
    class func CK_Image(_ imageName: String?) -> UIImage {
//        let imageStr = "\(imageName)@\(Int(kMainScale))x"
//        let path = Bundle.main.path(forResource: imageStr, ofType: "png")
//        let image = UIImage.init(contentsOfFile: path!)
        if imageName == nil || (imageName?.count)! <= 0 {
            return self.imageWithColor(kNoneImageColor)!
        }
        let image = UIImage.init(named: imageName!)
        return image == nil ? self.imageWithColor(kNoneImageColor)! : image!
    }
    
    ///init image form color
    class func imageWithColor(_ color: UIColor) -> UIImage? {
        return self.imageWithColor(color, size: CGSize.init(width: 1.0, height: 1.0))
    }
    ///init image form color, custom image size
    class func imageWithColor(_  color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
    ///image clips to fillet
    func filletImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 2.0)
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsGetCurrentContext()?.addEllipse(in: rect)
        UIGraphicsGetCurrentContext()?.clip()
        
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? nil
        
    }
    
    func resetImageOrientation() -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
//        UIGraphicsGetCurrentContext()?.addEllipse(in: rect)
//        UIGraphicsGetCurrentContext()?.clip()
        
        self.draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? nil
    }
}
