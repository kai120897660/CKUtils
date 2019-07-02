//
//  RealTimeFeedsCell.swift
//  BigDataAdmin
//
//  Created by 1 on 2019/6/24.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit

class RealTimeFeedsCell: BaseTableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.lineView.backgroundColor = UIColor.colorSrting("#01A2F8")
        self.lineView.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        self.contentView.layoutIfNeeded()
        self.selectionStyle = .none
    }

    var model: Any! {
        didSet {
            if let feeds = self.model as? RealFeedsModel {
                self.textLbl.attributedText = feeds.text
//                let mutiAttribuStr = NSMutableAttributedString.init(string: text)
//                mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#9F9FFB")], range: text.nsRangeString(feeds.groupName))
//                mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#03FFEF")], range: text.nsRangeString(feeds.userName))
//                mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#E60012")], range: text.nsRangeString("发布"))
//                mutiAttribuStr.addAttributes([.foregroundColor : UIColor.colorSrting("#F5E826")], range: text.nsRangeString(feeds.missionName))
//                self.textLbl.attributedText = mutiAttribuStr
            }
        }
    }
    
}
