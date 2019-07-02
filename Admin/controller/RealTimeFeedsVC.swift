//
//  RealTimeFeedsVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class RealTimeFeedsVC: IBoxRankingVC {

    private let vm = RealTimeFeedsViewModel()
    private let cellId = "realTimeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleBtn.setTitle("  实时动态", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.vm.beginRefreshFeeds {[weak self] in
            self?.view.loadingShow()
        }
    }
    
    override func initData() {
        self.tableView.register(UINib.init(nibName: "RealTimeFeedsCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        self.tableView.estimatedRowHeight = 53
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func addOthers() {
        self.vm.finished = {[weak self] in
            self?.view.loadingDimiss()
            if (self?.vm.indexPaths.count)! > 0 {
                self?.tableView.insertRows(at: (self?.vm.indexPaths)!, with: .left)
            }else {
                self?.tableView.reloadData()
            }
//            self?.tableView.reloadData()
        }
    }

}

extension RealTimeFeedsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! RealTimeFeedsCell
        let model = self.vm.datas[indexPath.row]
        cell.model = model
        
        return cell
    }
    
    
}
