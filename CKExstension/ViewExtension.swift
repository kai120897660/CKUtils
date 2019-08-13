//
//  ViewExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/6/6.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation
import UIKit


//MARK:   --    frame分类设置
extension UIView {
    public var ck_x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    public var ck_y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    public var ck_centerX: CGFloat{
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    public var ck_centerY: CGFloat{
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    public var ck_width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var ck_height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var ck_size: CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    public var ck_origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
}

//MARK:   --    分类设置
@objc extension UIView {
    
//    public var bageNum: Int {
//        set {
//            self.bageNumLabel.text = "\(newValue)"
//            self.bageNumLabel.alpha = CGFloat(newValue)
//        }get {
//            return Int(numString(self.bageNumLabel.text))
//        }
//    }
    
    ///设置圆角
    public func addRoundedCorners(corners: UIRectCorner, radii: CGSize, viewRect: CGRect) {
        let path = UIBezierPath.init(roundedRect: viewRect, byRoundingCorners: corners, cornerRadii: radii)
        let layer = CAShapeLayer()
        layer.frame = viewRect
        layer.path = path.cgPath
        
        self.layer.mask = layer
    }
    
    //MARK:    --   func
    ///设置视图阴影
    public func setShadow() {
        self.layer.shadowColor = kTextGray.cgColor
        self.layer.shadowOpacity = 0.35
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
    }
    
    public func setBlueShadow() {
        self.layer.shadowColor = kNavColor.cgColor
        self.layer.shadowOpacity = 0.35
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
    }
    
    ///设置显示模式
    public func setShowMode(_ mode:  UIView.ContentMode) {
        self.clipsToBounds = true
        self.contentMode = mode
    }
    
    ///视图转图片
    public func viewToImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.ck_size, false, kMainScale)
//        UIGraphicsBeginImageContext(self.ck_size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    ///开始loading
    public func loadingShow() {
        self.loadingShow("加载中……")
    }
    
    public func loadingSending() {
        self.loadingShow("发送中……")
    }
    
    ///开始loading
    ///text: loading描述
    public func loadingShow(_ text:  String) {
//        DispatchQueue.main.async {
//            var hudView = MBProgressHUD(for: self)
//            if hudView == nil {
//                MBProgressHUD.showAdded(to: self, animated: true)
//                hudView = MBProgressHUD(for: self)
//
//            }
//            hudView?.label.text = text
//            self.bringSubviewToFront(hudView!)
//        }
    }
    ///结束loading
    public func loadingDimiss() {
//        DispatchQueue.main.async {
//            MBProgressHUD.hide(for: self, animated: true)
//        }
    }
    
    /// 添加渐变色图层
    public func gradientColor(_ colors: [Any]) {
        self.removeGradientLayer()
        self.superview?.layoutIfNeeded()
        if self.ck_width <= 0 || self.ck_height <= 0 {
            return
        }
        
        let layer = CAGradientLayer()
        
        layer.frame = self.bounds
        
        ///设置颜色
        
        layer.colors = colors//[color("61ccc8").cgColor,color("61ccc8").cgColor,kRGBColorAlpha(r: 97, g: 204, b: 200, alpha: 0.1).cgColor]
        
        ///设置颜色渐变的位置 （我这里是横向 中间点开始变化）
        
        layer.locations = [0,1]
        
        ///开始的坐标点
        
        layer.startPoint = CGPoint(x: 0, y: 0)
        
        ///结束的坐标点
        
        layer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(layer)
        
    }
    
    /// 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    

}
