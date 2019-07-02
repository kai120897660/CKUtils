//
//  MofangDistribuedVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class MofangDistribuedVC: AdminBaseVC {

    private let edge = CGFloat(30)
    private let leftEdge = CGFloat(15)
    private let height = CGFloat(20)
    private let topEdge = CGFloat(22)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.webView.reload()
    }
    
    override func initUI() {
        self.titleBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kTopHeight + self.topEdge)
            make.height.equalTo(self.height)
            make.left.equalToSuperview().offset(self.height)
        }
        
        let backImgView = UIImageView()
        let image = UIImage.CK_Image("listBigBackImg")
//        image.resizableImage(withCapInsets: UIEdgeInsets.init(top: self.edge, left: self.edge, bottom: self.edge, right: self.edge))
        backImgView.image = image//UIImage.CK_Image("listBackImg")
        self.view.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.top.equalTo(titleBtn.snp.bottom).offset(self.leftEdge)
            make.bottom.equalToSuperview().offset(-(pageHeight + kBottomHeight))
            make.left.equalToSuperview().offset(self.leftEdge)
            make.right.equalToSuperview().offset(-self.leftEdge)
        }
        self.webView.snp.makeConstraints { (make) in
            make.top.equalTo(backImgView).offset(8)
            make.bottom.equalTo(backImgView).offset(-8)
            make.left.equalToSuperview().offset(self.edge)
            make.right.equalToSuperview().offset(-self.edge)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let url = URL.init(string: httpHost + "#/appchart")
        let request = URLRequest.init(url: url!)
        self.webView.loadRequest(request)
    }
    

    //MARK:    ---    lazy
    private lazy var webView: UIWebView = {
        let web = UIWebView()
        web.backgroundColor = UIColor.clear
        web.isOpaque = false
        web.scrollView.isScrollEnabled = false
        
        self.view.addSubview(web)
        
        return web
    }()

    private lazy var titleBtn: UIButton = {
        let titleBtn = UIButton.ck_button(image: "iconTag")
        titleBtn.setTitleColor(UIColor.colorSrting("#1074E4"), for: .normal)
        titleBtn.titleLabel?.font = ck_fontSize(18)
        titleBtn.setTitle("  魔方任务分布", for: .normal)
        self.view.addSubview(titleBtn)
        
        
        return titleBtn
    }()
}
