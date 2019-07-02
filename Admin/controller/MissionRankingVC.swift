//
//  MissionRankingVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class MissionRankingVC: IBoxRankingVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleBtn.setTitle("  魔方任务使用次数排名", for: .normal)
    }
    
    override func initData() {
        super.initData()
        self.viewModel.type = .mofangRanding
    }

}
