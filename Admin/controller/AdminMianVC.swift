 //
//  AdminMianVC.swift
//  zhizhumofang
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

 let pageHeight = CGFloat(30)
 
class AdminMianVC: AdminBaseVC {

    private let cellId = "AdminCellId"
    private let vcArray = [UserProfileVC(), IBoxRankingVC(), ActiveGroupVC(), MofangDistribuedVC(), MissionRankingVC(), RealTimeFeedsVC(), IBoxListMonitorVC()]
    
    private weak var popView: CustomPopView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "知筑魔方IBOX大数据"
        // Do any additional setup after loading the view.
        self.rightItem(UIImage.CK_Image("dian"))
            .subscribe(onNext: {[weak self] _ in
                self?.popViewShow()
            }).disposed(by: self.disposeBag)
    }
    
    override func initUI() {
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.pageControl.snp.top)
        }
        self.pageControl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomHeight)
            make.height.equalTo(pageHeight)
        }
    }
    
    override func initData() {
        let datas = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Any>>.init (configureCell: {[weak self] (_, collection, indexPath, model) -> UICollectionViewCell in
            let cell = collection.dequeueReusableCell(withReuseIdentifier: (self?.cellId)!, for: indexPath)
            for subView in cell.contentView.subviews {
                subView.removeFromSuperview()
            }
            if let vc = model as? UIViewController {
                cell.contentView.addSubview(vc.view)
            }
            
            
            return cell
        })
        
        self.dataSource.bind(to: self.collectionView.rx.items(dataSource: datas))
            .disposed(by: self.disposeBag)
    }
    
    override func addOthers() {
        self.collectionView.rx.didEndDecelerating.asObservable()
            .map({[weak self] _ in
                let index = Int((self?.collectionView.contentOffset.x)! / kScreenWidth)
                if index == (self?.vcArray.count)! - 1 {
                    self?.title = "IBOX视频监控"
                }else {
                    self?.title = "知筑魔方IBOX大数据"
                }
                return index
            })
            .bind(to: self.pageControl.rx.currentPage)
            .disposed(by: self.disposeBag)

//        self.pageControl.addTarget(self, action: #selector(pageValueChange), for: .valueChanged)
//    }
//
//    @objc func pageValueChange(_ sender: Any) {
//        self.collectionView.setContentOffset(CGPoint.init(x: kScreenWidth * CGFloat(self.pageControl.currentPage), y: 0), animated: true)
    }
    
    //MARK:    ---    private func
    private func popViewShow() {
        guard let popView = self.popView else {
            let popWidth = CGFloat(200)
            let pop = CustomPopView.init(frame: CGRect.init(x: kScreenWidth - (popWidth + 20), y: kTopHeight, width: popWidth, height: kNavHeight))
            pop.items = ["首页", "IBOX台数排名", "活跃机构排名", "魔方任务分布", "魔方任务使用次数排名", "实时动态", "IBOX视频监控", "退出"]
            pop.show(self.view)
            pop.selectedItem.subscribe(onNext: self.popSelected())
            .disposed(by: self.disposeBag)
            self.popView = pop
            return
        }
        popView.dismiss()
    }
    
    private func popSelected() -> (Int) -> Void {
        return {[weak self] index in
            if index < (self?.children.count)! {
                self?.collectionView.setContentOffset(CGPoint.init(x: kScreenWidth * CGFloat(index), y: 0), animated: true)
                self?.pageControl.currentPage = index
                return
            }
            UserInfoModel.sharedInstance.isLogin = false
        }
    }
    
    //MARK:    ---   lazy
    private lazy var dataSource: BehaviorRelay<[SectionModel<String, Any>]> = {
       
        
        var index = 0
        for vc in self.vcArray {
            vc.view.backgroundColor = UIColor.colorSrting("#FFFFFF", alpha: CGFloat(index) / 10)
            vc.backView.isHidden = true
            self.addChild(vc)
            index += 1
        }
        return BehaviorRelay<[SectionModel<String, Any>]>.init(value: [SectionModel<String, Any>.init(model: "", items: self.children)])
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: self.view.ck_width, height: self.view.ck_height - (pageHeight + kBottomHeight))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellId)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.clear
        self.view.addSubview(collection)
        
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
//        page.backgroundColor = UIColor.red
        page.currentPage = 0
        page.numberOfPages = self.vcArray.count
        
        self.view.addSubview(page)
        
        return page
    }()

}
