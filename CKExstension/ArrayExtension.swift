//
//  ArrayExtension.swift
//  qiqi_ios
//
//  Created by design on 2018/7/13.
//  Copyright © 2018年 design. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeObject(_ obj: Element){
        let index = self.indexObj(obj)
        if index <= self.count && index > 0 {
            self.remove(at: index)
        }
        
    }
    
    func indexObj(_  obj: Element) -> Int {
        let index = self.index { (str) -> Bool in
            if (str as AnyObject).isEqual(obj) {
                return true
            }
            return false
        }
        if index == nil {
            return 0
        }
        return index!
    }
    
    func ck_objIndex(_ index: Int) -> Element? {
        if self.isEmpty {
            return nil
        }
        if index < 0 || index >= self.count {
            return self.first
        }
        return self[index]
    }
  
    
//    public static func a() {
//
//        let objIndex = class_getInstanceMethod(self, #selector(remove(at:)))
//    }
    
}

