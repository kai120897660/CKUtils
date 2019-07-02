//
//  IBoxRandingCell.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class IBoxRandingCell: UITableViewCell {

    @IBOutlet weak var indexBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var backProgressView: UIView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    @IBOutlet weak var backProgressWidth: NSLayoutConstraint!
    
    
    
    private let colors = [UIColor.colorSrting("#46FEC8"), UIColor.colorSrting("#25ABDA"), UIColor.colorSrting("#0F74E6"), UIColor.colorSrting("#006AB4")]
    
    private var count = CGFloat(0)
    
    private var maxCount = CGFloat(1)
    
    private var contentWidth = (kScreenWidth - 50)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backProgressView.layer.masksToBounds = true
        self.backProgressView.layer.cornerRadius = 6
        self.progressView.layer.masksToBounds = true
        self.progressView.layer.cornerRadius = 6
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        self.progressWidth.constant = self.backProgressView.ck_width * (self.count / self.maxCount)
        self.contentView.layoutIfNeeded()///40c7a5  1b7713
        var colors = [UIColor.colorSrting("#073d81").cgColor, UIColor.colorSrting("#1d7575").cgColor]
        if self.indexPtah.row < 3 {
            colors = [UIColor.colorSrting("#0f74e6").cgColor, UIColor.colorSrting("#46fec8").cgColor]
        }
        self.progressView.gradientColor(colors)
    }
    
    //MARK:    --   set
    var model: Any! {
        didSet {
            self.subtitleLbl.text = ""
            if let item = self.model as? ItemModel {
                self.titleLbl.text = item.title
            }
            if let randingModel = self.model as? IBoxRandingModel {
                self.titleLbl.text = randingModel.provinceName
                self.countLbl.text = randingModel.count + "台"
                self.count = numString(randingModel.count)
                self.backProgressWidth.constant = self.contentWidth - 200
            }
            if let activeModel = self.model as? ActiveGroupModel {
                self.titleLbl.text = activeModel.schoolName
                self.countLbl.text = activeModel.userCount + "人次"
                self.subtitleLbl.text = activeModel.iboxCount + "台"
                self.count = numString(activeModel.userCount)
                self.backProgressWidth.constant = self.contentWidth - 250
            }
            if let mofangModel = self.model as? MofangCountModel {
                self.titleLbl.text = mofangModel.taskName
                self.countLbl.text = mofangModel.count + "次"
                self.count = numString(mofangModel.count)
                self.backProgressWidth.constant = self.contentWidth - 240
            }
            
        }
    }
    
    var indexPtah: IndexPath! {
        didSet {
            if let idxPath = self.indexPtah {
                let index = min(idxPath.row, self.colors.count - 1)
                self.indexBtn.setTitleColor(self.colors[index], for: .normal)
                self.indexBtn.setBackgroundImage(UIImage.CK_Image("index\(index + 1)"), for: .normal)
                self.indexBtn.setTitle("\(idxPath.row + 1)", for: .normal)
            }
        }
    }
    
    var firstModel: Any! {
        didSet {
            if let randingModel = self.firstModel as? IBoxRandingModel {
                self.maxCount = numString(randingModel.count)
            }
            if let activeModel = self.firstModel as? ActiveGroupModel {
                self.maxCount = numString(activeModel.userCount)
            }
            if let mofangModel = self.firstModel as? MofangCountModel {
                self.maxCount = numString(mofangModel.count)
            }
            self.maxCount = max(self.maxCount, 1)
        }
    }
    
    
    
}
