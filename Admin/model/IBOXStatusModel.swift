//
//  IBOXStatusModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/26.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class IBOXStatusModel: BaseModel {

    var count: Int!
    ///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
    var iboxStatus: Int!
}
