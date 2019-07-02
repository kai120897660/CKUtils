//
//  RealFeedsModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class RealFeedsModel: BaseModel {
    
    var id: String!
    ///附加
    var addition: String!
    ///ibox台数
    var count: String!
    ///操作发生的时间
    var createTime: String!
    ///扩展分
    var expandScore: String!
    ///操作分
    var trainingScore: String!
    ///ibox名称
    var iboxName: String!
    ///身份信息
    var identityInfo: String!
    ///机构名称
    var schoolName: String!
    ///任务c名称
    var taskName: String!
    ///用时
    var timeCost: String!
    ///模板标识
    var template: Int = 0
    
    
    /// 设置实时动态富文本
    ///   - text: 显示内容
    ///   - purpleText: 紫色字体（机构名称）
    ///   - lightGreenText: 浅绿色字体（操作者名称或者IBOX名称）
    ///   - redText: 红色字体（操作）
    ///   - yellowText: 黄色字体（任务名称或者IBOX行为）
    private func setAttributedString(_ text: String, _ purpleText: String, _ lightGreenText: String, _ redText: String, _ yellowText: String) -> NSAttributedString {
        let mutiAttribuStr = NSMutableAttributedString.init(string: text)
        mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#9F9FFB")], range: text.nsRangeString(purpleText))
        mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#03FFEF")], range: text.nsRangeString(lightGreenText))
        mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#E60012")], range: text.nsRangeString(redText))
        mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#F5E826")], range: text.nsRangeString(yellowText))
        
        return mutiAttribuStr
    }
    
    ///显示内容
    lazy var text: NSAttributedString = {
        switch self.template {
        case 1:
            let text = self.schoolName + " " + self.identityInfo + "刚刚发布了任务" + self.taskName  + "  " +  self.createTime
            return self.setAttributedString(text, self.schoolName, self.identityInfo, "发布", self.taskName)
        case 2:
            let text = self.schoolName + " " + self.identityInfo + "刚刚预约了任务" + self.taskName  + "  " +  self.createTime
            return self.setAttributedString(text, self.schoolName, self.identityInfo, "预约", self.taskName)
        case 3:
            let text = self.schoolName + " " + self.identityInfo + "正在完成任务" + self.taskName  + "  " +  self.createTime
            return self.setAttributedString(text, self.schoolName, self.identityInfo, "正在完成", self.taskName)
        case 4:
            let text = self.schoolName + " " + self.identityInfo + "完成任务" + self.taskName + ",历时\(self.timeCost ?? ""), 操作分\(self.expandScore ?? ""),拓展分\(self.trainingScore ?? "")  " + self.createTime
            return self.setAttributedString(text, self.schoolName, self.identityInfo, "完成任务", self.taskName)
            
        case 5:
            let text = self.schoolName + " " + self.identityInfo + "修改 \(self.iboxName ?? "") 自动开关机为" + nilString(self.addition) + "  " + self.createTime
            return self.setAttributedString(text, self.schoolName, self.identityInfo, "修改", "")
        case 6:
            let text = self.schoolName + " 现有\(self.count ?? "")台IBOX," + nilString(self.addition)  + "  " +  self.createTime
            return self.setAttributedString(text, self.schoolName, "", "", self.addition)
        case 7:
            let text = self.schoolName + " \(self.iboxName ?? "")" + nilString(self.addition)  + "  " +  self.createTime
            return self.setAttributedString(text, self.schoolName, self.iboxName, "", "")
        default:
            return NSAttributedString.init(string: "")
        }
    }()
}
