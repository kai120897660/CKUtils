//
//  FontExtension.swift
//  CKUtils
//
//  Created by APPLE on 2019/8/22.
//  Copyright © 2019 ck.com. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    public class func ck_font(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    public class func ck_fontBold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}
