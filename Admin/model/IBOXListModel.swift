//
//  IBOXListModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/26.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class IBOXListModel: BaseModel {

    ///摄像头序列号
    var cameraNum: String!
    ///设备名称
    var iboxName: String!
    ///设备状态
    ///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
    var iboxStatus: Int!
    ///学校名称
    var schoolName: String!
    ///抓拍图片地址
    var snapImg: String!
    ///是否正在播放
    var isPlaying = false
    
    lazy var statusString: String = {
        switch self.iboxStatus {
        case 0:
            return "空闲"
        case 1:
            return "忙碌"
        case 2:
            return "离线"
        case 3:
            return "警报"
        case 4:
            return "休眠"
        case 5:
            return "关机"
        default:
            return ""
        }
    }()
}
