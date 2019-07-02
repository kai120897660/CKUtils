//
//  IBoxRankingVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class IBoxRankingVC: AdminBaseVC {

    private let cellId = "iBoxRandingCellId"
    private let leftEdge = CGFloat(15)
    private let topEdge = CGFloat(22)
    private let height = CGFloat(20)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.mj_header?.beginRefreshing()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func initUI() {
        self.titleBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kTopHeight + self.topEdge)
            make.height.equalTo(self.height)
            make.left.equalToSuperview().offset(self.height)
        }
        
        let backImgView = UIImageView()
        let image = UIImage.CK_Image("listBigBackImg")
        backImgView.image = image//.resizableImage(withCapInsets: UIEdgeInsets.init(top: pageHeight, left: pageHeight, bottom: pageHeight, right: pageHeight))
        self.view.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.top.equalTo(titleBtn.snp.bottom).offset(self.leftEdge)
            make.bottom.equalToSuperview().offset(-(pageHeight + kBottomHeight))
            make.left.equalToSuperview().offset(self.leftEdge)
            make.right.equalToSuperview().offset(-self.leftEdge)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(backImgView).offset(8)
            make.bottom.equalTo(backImgView).offset(-8)
            make.left.equalToSuperview().offset(pageHeight)
            make.right.equalToSuperview().offset(-pageHeight)
        }
    }
    
    override func initData() {
        self.tableView.rowHeight = 53
        let datas = RxTableViewSectionedReloadDataSource<SectionModel<String, Any>>.init (configureCell: {[weak self] (datas, table, indexPath, model) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: (self?.cellId)!) as! IBoxRandingCell
            cell.firstModel = datas[IndexPath.init(row: 0, section: 0)]
            cell.model = model
            cell.indexPtah = indexPath
            
            return cell
        })
        
        self.viewModel.dataSource
            .bind(to: self.tableView.rx.items(dataSource: datas))
            .disposed(by: self.disposeBag)
        self.viewModel.bindTable(tableView: self.tableView)
        
    }
    

    //MARK:    ---    lazy
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        table.register(UINib.init(nibName: "IBoxRandingCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        self.view.addSubview(table)
        
        return table
    }()
    
    lazy var titleBtn: UIButton = {
        let titleBtn = UIButton.ck_button(image: "iconTag")
        titleBtn.setTitleColor(UIColor.colorSrting("#1074E4"), for: .normal)
        titleBtn.titleLabel?.font = ck_fontSize(18)
        titleBtn.setTitle("  IBOX台数排名", for: .normal)
        self.view.addSubview(titleBtn)
        
        
        return titleBtn
    }()
    
    lazy var viewModel: IBoxRandingViewModel = {
        self.tableView.mj_header = MJRefreshNormalHeader()
        return IBoxRandingViewModel.init(input: (headerRefresh: self.tableView.mj_header.rx.refreshing.asObservable(),
                                                     footerRefresh: nil))
        
    }()

}
