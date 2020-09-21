//
//  DetailTableCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell{
    
    @IBOutlet var screenShotCell: UICollectionView!
    @IBOutlet weak var deviceCheckLb: UILabel!
    
    var info:SearchInfo!
    var imgList:[String]!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        screenShotCell.delegate = self
        screenShotCell.dataSource = self
        screenShotCell.register(UINib(nibName: "DetailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setViewDataObj(info:SearchInfo) {
        self.info = info
        self.imgList = info.screenshotUrls!
        if UIDevice.current.userInterfaceIdiom == .phone {
            deviceCheckLb.text = "iPhone"
        }else if UIDevice.current.userInterfaceIdiom == .pad{
            deviceCheckLb.text = "iPad"
        }
    }
    
    static func cellHeight()->CGFloat{
        return 550
    }
}

extension DetailTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as? DetailCollectionCell else{
            return UICollectionViewCell()
        }
        cell.setViewDataObj(img: self.imgList[indexPath.row])
        return cell
    }
}

extension DetailTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return DetailCollectionCell.cellSize()
    }
}
