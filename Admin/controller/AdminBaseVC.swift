//
//  AdminBaseVC.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/7/1.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit


let httpHost = "http://172.16.1.165/ibox/"

class AdminBaseVC: BaseViewController {

    
    override func viewDidLoad() {
        _ = self.backImgView
        super.viewDidLoad()
        self.backView.backgroundColor = UIColor.colorSrting("#0A1545")
    }
    
    private lazy var backImgView: UIImageView = {
        let imgView = UIImageView.init(frame: self.view.bounds)
        imgView.image = UIImage.CK_Image("backImg")
        self.view.addSubview(imgView)
        
        return imgView
    }()
}
