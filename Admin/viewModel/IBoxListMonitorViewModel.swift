//
//  IBoxListMonitorViewModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/25.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class IBoxListMonitorViewModel: RefreshViewModel {

    var monitorModel: IBOXListMonitorModel!
    
    override func refreshLoadDatas(_ params: Any?) -> Observable<[SectionModel<String, Any>]> {
        let url = "big/getIboxInfos"
        
        return MoyaManager.requestDatas(api: .get(params, url), prepare: nil)
            .map({ (rst) -> [SectionModel<String, Any>] in
                if rst?.code == 200 {
                    if let model = IBOXListMonitorModel.deserialize(from: rst?.data as? [String: Any]) {
                        self.monitorModel = model
                        self.reloadItems()
                        return [SectionModel<String, Any>.init(model: "", items: self.monitorModel.iboxInfoList ?? [])]
                    }
                }
                return [SectionModel<String, Any>.init(model: "", items: [])]
            })
    }
    
    func reloadItems()  {
        let titles = ["总数", "忙碌", "空闲", "休眠", "警报", "关机", "离线"]
        ///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
        var array = [-1, 1, 0, 4, 3, 5, 2]//self.monitorModel.iboxStatusList.sorted(by: { return $0.iboxStatus > $1.iboxStatus })
        let totalCount = self.monitorModel.iboxStatusList.compactMap({$0.count }).reduce(0, { $0 + $1 })
//        let statusModel = IBOXStatusModel()
//        statusModel.count = totalCount
//        array.insert(statusModel, at: 0)
        for index in 0..<array.count {
            let status = array[index]
            let item = self.headerItems[index]
            let count = status == -1 ? totalCount : self.monitorModel.iboxStatusList.filter({ $0.iboxStatus == status }).first?.count
            let coutStr = "\(count ?? 0)"
            let title = "  " + titles[index] + "  " + coutStr
            let attStr = NSMutableAttributedString.init(string: title, attributes: [.foregroundColor : UIColor.white])
            attStr.addAttributes([.font: ck_fontSize(19), .foregroundColor: item.textColor], range: title.nsRangeString(coutStr))
            item.attribuedText.accept(attStr)
        }
    }
    
    ///设置所需数据，头部是图显示
    lazy var headerItems: [ItemModel] = {

        let imageNames = ["iBoxTotal", "iBoxBusy", "iBoxFree", "iBoxSleep", "iBoxWarning", "iBoxOff", "iBoxOffline"]
        let titles = ["总数", "忙碌", "空闲", "休眠", "警告", "关机", "离线"]
        
        var items: [ItemModel] = []
        for index in 0..<imageNames.count {
            let title = "  " + titles[index] + "  "
            let item = ItemModel.init(title, imageName: imageNames[index])
            let attStr = NSMutableAttributedString.init(string: title, attributes: [.foregroundColor : UIColor.white])
//            attStr.addAttributes([.font: ck_fontSize(19), .foregroundColor: item.textColor], range: title.nsRangeString(item.subtitle))
            item.attribuedText.accept(attStr)
            
            item.textColor = UIColor.colorSrting("#008BF9")
            items.append(item)
        }
        
        return items
        
    }()
    
    
    
//    ///ibox列表
//    func iBoxLists() -> Observable<[SectionModel<String, Any>]> {
//        
//        
//        var datas: [ItemModel] = []
//        for index in 0..<100 {
//            let item = ItemModel.init("iBox\(index)", subtitle: nil)
//            datas.append(item)
//        }
//        
//        return Observable<[SectionModel<String, Any>]>.just([SectionModel<String, Any>.init(model: "", items: datas)])
//    }

}
