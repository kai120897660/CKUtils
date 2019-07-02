//
//  IBoxRandingViewModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class IBoxRandingViewModel: RefreshViewModel {

    enum DataType {
        ///ibox排名
        case iBoxRanding
        ///活跃机构排名
        case activeGroup
        ///魔方任务排名
        case mofangRanding
    }
    
    var type: DataType = .iBoxRanding
    
//    var dataSource = BehaviorRelay<[SectionModel<String, Any>]>.init(value: [SectionModel<String, Any>.init(model: "", items: [])])
    
    override func refreshLoadDatas(_ params: Any?) -> Observable<[SectionModel<String, Any>]> {
        switch self.type {
        case .iBoxRanding:
            return self.iBoxRanding()
        case .activeGroup:
            return self.activeGroups()
        case .mofangRanding:
            return self.mofangRanding()
        }
    }
    
    ///ibox台数排名
    private func iBoxRanding() -> Observable<[SectionModel<String, Any>]> {
        let url = "big/getIboxNum"
        
        return MoyaManager.requestDatas(api: .get(nil, url), prepare: nil)
            .map({ (rst) -> [SectionModel<String, Any>] in
                if rst?.code == 200 {
                    if let array = [IBoxRandingModel].deserialize(from: (rst?.data as! [Any])) {
                        return [SectionModel<String, Any>.init(model: "", items: array as [Any])]
                    }
                }
                return [SectionModel<String, Any>.init(model: "", items: [])]
            })
    }
    
    ///活跃机构排名
    private func activeGroups() -> Observable<[SectionModel<String, Any>]> {
        let url = "big/getActiveRanking"
        
        return MoyaManager.requestDatas(api: .get(nil, url), prepare: nil)
            .map({ (rst) -> [SectionModel<String, Any>] in
                if rst?.code == 200 {
                    if let array = [ActiveGroupModel].deserialize(from: (rst?.data as! [Any])) {
                        return [SectionModel<String, Any>.init(model: "", items: array as [Any])]
                    }
                }
                return [SectionModel<String, Any>.init(model: "", items: [])]
            })
    }
    
    ///魔方任务使用次数排名
    private func mofangRanding() -> Observable<[SectionModel<String, Any>]> {
        let url = "big/getTaskUseCount"
        
        return MoyaManager.requestDatas(api: .get(nil, url), prepare: nil)
            .map({ (rst) -> [SectionModel<String, Any>] in
                if rst?.code == 200 {
                    if let array = [MofangCountModel].deserialize(from: (rst?.data as! [Any])) {
                        return [SectionModel<String, Any>.init(model: "", items: array as [Any])]
                    }
                }
                return [SectionModel<String, Any>.init(model: "", items: [])]
            })
    }
    
}
