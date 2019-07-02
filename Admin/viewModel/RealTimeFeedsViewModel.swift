//
//  RealTimeFeedsViewModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RealTimeFeedsViewModel: BaseViewModel {
    
    private var startTime: String!
    
    ///实时动态数据
    var dataSource = BehaviorRelay<[SectionModel<String, Any>]>.init(value: [SectionModel<String, Any>.init(model: "", items: [])])
    var datas: [RealFeedsModel] = []
    
    ///数据请求完成
    var finished: Completed?
    ///需要刷新的rows
    var indexPaths: [IndexPath] = []
    
    private var queue = DispatchQueue.init(label: "realTime")
    
    private var timer: Timer!
    
   
    func beginRefreshFeeds(_ prepare: Prepare?) {
        if self.timer == nil {
            prepare?()
            self.timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: {[weak self] _ in
                ck_print("你麻痹")
                self?.reloadRealTime(nil)
            })
            RunLoop.current.add(self.timer, forMode: .common)
            self.timer.fire()
        }
    }
    
    private func reloadRealTime(_ prepare: Prepare?) {
        self.queue.async {
            self.realTimeFeeds(prepare)
        }
    }
    
    ///实时动态
    private func realTimeFeeds(_ prepare: Prepare?) {
        let url = "big/getDynamicList"
        var params = ["endTime": Date.currentTimeStamp().timestampToTime("yyyy-MM-dd HH:mm:ss")]
        if let beginTime = self.startTime {
            params["startTime"] = beginTime
        }
        return MoyaManager.requestDatas(api: .get(params, url), prepare: prepare)
            .subscribe(onNext: { (rst)  in
                if rst?.code == 200 {
                    if let array = [RealFeedsModel].deserialize(from: rst?.data as? [Any]) {
                        self.indexPaths.removeAll()
                        self.dataSource.accept([SectionModel<String, Any>.init(model: "", items: array as [Any])])
                        let feeds = (array as! [RealFeedsModel]) + self.datas
                        
                        if self.datas.count > 0 {
                            self.datas = feeds
                            for index in 0..<array.count {
                                self.indexPaths.append(IndexPath.init(row: index, section: 0))
                            }
                        }else {
                            self.datas = feeds
                        }
                        self.finished?()
                    }
                    self.startTime = params["endTime"]
//                    UserDefaultsModel.setObjc(objc: params["endTime"], key: self.startTime)
                }
            }).disposed(by: self.disposeBag)
    }
}
