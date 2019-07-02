//
//  UserProfileViewModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class UserProfileViewModel: BaseViewModel {

    ///用户概况
    func userProfile(_ prepare: Prepare?) -> Observable<[SectionModel<String, Any>]> {
        let url = "big/getUserCount"
        
        return MoyaManager.requestDatas(api: .get(nil, url), prepare: prepare)
            .map({ (rst) -> [SectionModel<String, Any>] in
                if rst?.code == 200 {
                    if let model = UserProfileModel.deserialize(from: (rst?.data as! [String: Any])) {
                        let items = self.setDatas(model)
                        
                        return  [SectionModel<String, Any>.init(model: "", items: items)]
                    }
                }
                return [SectionModel<String, Any>.init(model: "", items: [])]
            })
        
    }
    
    private func setDatas(_ model: UserProfileModel) -> [ItemModel] {
        let imageNames = ["client", "mechanism", "users"]
        let titles = ["大客户", "机构数" , "累计用户"]
        let subtitles = [model.systemCount, model.schoolCount, model.userCount]
        let tips = ["个", "个", "人"]
        var datas: [ItemModel] = []
        for index in 0..<imageNames.count {
            let item = ItemModel.init(titles[index], subtitle: subtitles[index])
            item.imageName = imageNames[index]
            item.tips = tips[index]
            datas.append(item)
        }
        
        return datas
    }
}
