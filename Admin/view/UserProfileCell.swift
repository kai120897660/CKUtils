//
//  UserProfileCell.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class UserProfileCell: BaseTableViewCell {

    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.lineView.backgroundColor = UIColor.colorSrting("#01A2F8")
        self.lineView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        self.contentView.layoutIfNeeded()
        self.selectionStyle = .none
    }

    var model: Any! {
        didSet {
            if let item = self.model as? ItemModel {
                self.titleBtn.setImage(UIImage.CK_Image(item.imageName), for: .normal)
                self.titleBtn.setTitle("  " + item.title, for: .normal)
                let text = item.subtitle + item.tips
                let attStr = NSMutableAttributedString.init(string: text)
                attStr.addAttributes([NSAttributedString.Key.font : ck_fontSize(25), .foregroundColor: UIColor.colorSrting("#EA7E6D")], range: text.nsRangeString(item.subtitle))
                self.textLbl.attributedText = attStr
            }
        }
    }
}
