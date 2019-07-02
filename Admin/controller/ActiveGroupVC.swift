//
//  ActiveGroupVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class ActiveGroupVC: IBoxRankingVC {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.titleBtn.setTitle("  活跃机构排名", for: .normal)
    }
    
    override func initData() {
        super.initData()
        self.viewModel.type = .activeGroup
    }
    
}
