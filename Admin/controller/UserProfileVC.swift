//
//  UserProfileVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class UserProfileVC: AdminBaseVC {

    private let leftEdge = CGFloat(15)
    private let cellId = "userProfileCellId"
    private let viewModel = UserProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "知筑魔方IBOX大数据"
        self.view.loadingShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.reload()
    }
    
    override func initUI() {

        self.webView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(kScreenWidth)
        }
        self.infoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.webView.snp.bottom)
            make.bottom.equalToSuperview().offset(-(pageHeight + kBottomHeight))
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8 + kNavHeight)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(pageHeight)
            make.right.equalToSuperview().offset(-pageHeight)
        }
        
    }
    
    
    override func initData() {
        let datas = RxTableViewSectionedReloadDataSource<SectionModel<String, Any>>.init (configureCell: {[weak self] (datas, table, a, model) -> UITableViewCell in
            let cell = table.dequeueReusableCell(withIdentifier: (self?.cellId)!) as! UserProfileCell
            cell.model = model
//            cell.lineView
            
            return cell
        })
        
        self.viewModel.userProfile { }
            .bind(to: self.tableView.rx.items(dataSource: datas))
            .disposed(by: self.disposeBag)
    }
    
    //MARK:    ---     lazy
    private lazy var webView: UIWebView = {
        let web = UIWebView()
        web.backgroundColor = UIColor.clear
        web.isOpaque = false
        web.scrollView.isScrollEnabled = false
        web.delegate = self
        let url = URL.init(string: httpHost + "#/appmap")
        let request = URLRequest.init(url: url!)
        web.loadRequest(request)
        self.view.addSubview(web)
        
        return web
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        
        let titleBtn = UIButton.ck_button(image: "iconTag")
        titleBtn.setTitleColor(UIColor.colorSrting("#1074E4"), for: .normal)
        titleBtn.titleLabel?.font = ck_fontSize(18)
        titleBtn.setTitle("  用户概况", for: .normal)
        view.addSubview(titleBtn)
        titleBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(kNavHeight)
            make.left.equalToSuperview().offset(20)
        }
        
        let backImgView = UIImageView()
        backImgView.image = UIImage.CK_Image("listBackImg")//.resizableImage(withCapInsets: UIEdgeInsets.init(top: pageHeight, left: pageHeight, bottom: pageHeight, right: pageHeight))
        view.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.top.equalTo(titleBtn.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(self.leftEdge)
            make.right.equalToSuperview().offset(-self.leftEdge)
        }
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .plain)
        table.separatorStyle = .none
        table.backgroundColor = UIColor.clear
        table.rowHeight = 53
        table.register(UINib.init(nibName: "UserProfileCell", bundle: nil), forCellReuseIdentifier: self.cellId)
        self.infoView.addSubview(table)
        
        return table
    }()
}

extension UserProfileVC: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.view.loadingDimiss()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.view.loadingDimiss()
    }
}
