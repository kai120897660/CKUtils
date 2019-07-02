//
//  IBoxListMonitorVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class IBoxListMonitorVC: AdminBaseVC {

    private let leftEdge = CGFloat(15)
    private let topEdge = CGFloat(12)
    ///按钮显示高度
    private let btnHeight = kNavHeight
    ///按钮边距
    private let btnEdge = CGFloat(35)
    
    private let cellId = "listMonitorCellId"
    
    
    private var playCell: IBoxListMonitorCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.mj_header.beginRefreshing()
    }
    
    
    override func initUI() {
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(kTopHeight)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(self.topEdge)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomHeight)
        }
    }

    override func initData() {
        
        let datas = RxTableViewSectionedReloadDataSource<SectionModel<String, Any>>.init (configureCell: {[weak self] (_, table, _, model) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: (self?.cellId)!) as! IBoxListMonitorCell
            cell.model = model
            cell.playBtn.rx.tap
                .subscribe(onNext: {_ in
                    if let iboxModel = model as? IBOXListModel {
                        if iboxModel.isPlaying {
                            self?.livePlayer.destoryPlayer()
                            cell.playBtn.isSelected = false
                            self?.livePlayer.removeFromSuperview()
                            iboxModel.isPlaying = false
                        }else {
                            self?.livePlayer.isHidden = false
                            if self?.playCell != nil {
                                self?.playCell.playBtn.isSelected = false
                                self?.playCell.playBtn.isHidden = false
                                (self?.playCell.model as! IBOXListModel).isPlaying = false
                            }
                            cell.aotuDimiss()
                            self?.playCell = cell
                            iboxModel.isPlaying = true
                            cell.playBtn.isSelected = !cell.playBtn.isSelected
                            cell.playerView.addSubview((self?.livePlayer)!)
                            self?.livePlayer.frame = cell.playerView.bounds
                            
                            self?.livePlayer.cameraNum = iboxModel.cameraNum
                            
                        }
                        
                    }
                    
                }).disposed(by: cell.disposeBag)
            if let iboxModel = model as? IBOXListModel, iboxModel.isPlaying {
                self?.livePlayer.isHidden = false
                cell.playerView.addSubview((self?.livePlayer)!)
                self?.livePlayer.frame = cell.playerView.bounds
//                self?.livePlayer.snp.makeConstraints({ (make) in
//                    make.edges.equalToSuperview()
//                })
            }else {
                if cell.playerView.subviews.count > 1 {
                    self?.livePlayer.isHidden = true
                }
                
            }
            
            return cell
        })
        
        self.viewModel.dataSource
            .map({[weak self] in
                self?.realoadIBoxStatus()
                return $0
            }).bind(to: self.tableView.rx.items(dataSource: datas))
            .disposed(by: self.disposeBag)
        
        self.viewModel.bindTable(tableView: self.tableView)
    }
    
    
    private func realoadIBoxStatus() {
        let backImgView = UIImageView()
        backImgView.image = UIImage.CK_Image("listBackImg").resizableImage(withCapInsets: UIEdgeInsets.init(top: pageHeight, left: pageHeight, bottom: pageHeight, right: pageHeight))
        self.headerView.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.topEdge)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(self.leftEdge)
            make.right.equalToSuperview().offset(-self.leftEdge)
        }
        let items = self.viewModel.headerItems
        var index = 0
        for item in items {
            let btn = UIButton.ck_button(image: item.imageName)
//            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = ck_fontSize(14)
            btn.contentHorizontalAlignment = .left
//            btn.contentVerticalAlignment = .center
//            let attStr = NSMutableAttributedString.init(string: item.title, attributes: [.foregroundColor : UIColor.white])
//            attStr.addAttributes([.font: ck_fontSize(19), .foregroundColor: item.textColor], range: item.title.nsRangeString(item.subtitle))
//            btn.setAttributedTitle(attStr, for: .normal)
            item.attribuedText.bind(to: btn.rx.attributedTitle()).disposed(by: self.disposeBag)
            self.headerView.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(self.leftEdge + CGFloat(index / 2) * self.btnHeight)
                make.left.equalTo(backImgView).offset(self.btnEdge + (kScreenWidth - self.btnHeight) * 0.5 * CGFloat(index % 2))
                make.width.equalTo(kScreenWidth * 0.5 - self.btnHeight)
                make.height.equalTo(self.btnHeight)
                if index == items.count - 1 {
                    make.bottom.equalToSuperview().offset(-self.leftEdge)
                }
            }
            index += 1
        }
    }
    
    //MARK:     ----     lazy
    private lazy var headerView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        table.register(UINib.init(nibName: "IBoxListMonitorCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        table.estimatedRowHeight = kNavHeight
        self.view.addSubview(table)
        
        return table
    }()

    private lazy var livePlayer: LivePlayerView = {
        let live = LivePlayerView()
        
        return live
    }()
    
    private lazy var viewModel: IBoxListMonitorViewModel = {
        self.tableView.mj_header = MJRefreshNormalHeader()
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        return IBoxListMonitorViewModel.init(input: (headerRefresh: self.tableView.mj_header.rx.refreshing.asObservable(),
                                                     footerRefresh: self.tableView.mj_footer.rx.refreshing.asObservable()))
    }()
    
}
