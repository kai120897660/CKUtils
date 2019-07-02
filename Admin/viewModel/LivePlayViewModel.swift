//
//  LivePlayViewModel.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/25.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift

class LivePlayViewModel: BaseViewModel {

    @objc func requestDatas(_ params: Any, prepare: (() -> Void)?, callBack: ((_ obj: Any?) -> Void)?) {
        let url = "httpClient/getVideo"
        MoyaManager.requestDatas(api: .get(params, url), prepare: prepare)
            .subscribe(onNext: { (rst) in
                if rst?.status == 200 {
                   callBack?(rst?.resultObject)
                }
            }).disposed(by: self.disposeBag)
    }
    
    func requestIBOXVideoUrl(_ cameraNum: String) -> Observable<String> {
        let url = "httpClient/getVideo"
        return MoyaManager.requestDatas(api: .get(["deviceSerial": cameraNum], url), prepare: nil)
            .map({ (rst) -> String in
                if rst?.status == 200 {
                    if let dic = rst?.resultObject as? [String: Any] {
                        if dic["code"] as? String == "200", let dataDic = dic["data"] as? [String: Any] {
                            return (dataDic["hdAddress"] as? String) ?? ""
                        }
                    }
                }
                return ""
            })
    }
}
