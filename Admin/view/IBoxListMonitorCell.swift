//
//  IBoxListMonitorCell.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/20.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift

class IBoxListMonitorCell: UITableViewCell {

    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    ///0:空闲1:忙碌2:离线 3警报 4休眠 5关机
    private let colors = ["#6DC465", "#E4892E", "#AFB0AF", "#D62E11", "#A95FDC", "#F0379C", ]
    
    private let aotuDimissQueue = DispatchQueue.init(label: "aotuDimiss")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        self.contentView.layoutIfNeeded()
        self.selectionStyle = .none
        
        self.statusLabel.layer.cornerRadius = 7
        self.statusLabel.layer.borderWidth = 1
        
        self.iconImgView.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.contentView.addGestureRecognizer(tap)
//        tap.rx.event.subscribe(onNext: { _ in
//
//        }).disposed(by: self.disposeBag)
    }

    @objc func tapAction() {
        if let ibox = self.model as? IBOXListModel, ibox.isPlaying {
            self.playBtn.isHidden = !self.playBtn.isHidden
            if !self.playBtn.isHidden {
                //                    self.aotuDimiss()
            }
        }
    }
    
    func aotuDimiss() {
        self.aotuDimissQueue.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3)) {
            DispatchQueue.main.async {
                self.playBtn.isHidden = true
            }
        }
//        UIView.animate(withDuration: 0.25, delay: 3, options: .curveEaseInOut, animations: {
//            
//        }) { _ in
//            
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }

    var model: Any! {
        didSet {
            if let iboxModel = self.model as? IBOXListModel {
                self.statusLabel.text = iboxModel.statusString
                let text = iboxModel.schoolName + "-" + iboxModel.iboxName
                let attribuedStr = NSMutableAttributedString.init(string: text)
                attribuedStr.addAttributes([.font : ck_fontSize(14)], range: text.nsRangeString(iboxModel.iboxName))
                self.nameLabel.attributedText = attribuedStr
                if nilString(iboxModel.snapImg).count > 0 {
                    self.iconImgView.ck_setImage(iboxModel.snapImg)
                }else {
                    self.iconImgView.image = UIImage.CK_Image("mofang")
                }
                self.playBtn.isSelected = iboxModel.isPlaying
                self.playBtn.isHidden = iboxModel.isPlaying
                
                let color = UIColor.colorSrting(self.colors[iboxModel.iboxStatus])
                self.statusLabel.layer.borderColor = color.cgColor
                self.statusLabel.textColor = color
            }
        }
    }
    
}
