//
//  ScreenShotTableCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ScreenShotTableCell: UITableViewCell {

    
    @IBOutlet weak var screenShotLargeCell: UICollectionView!
    
    var info:SearchInfo!
    var imgList:[URL]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        screenShotLargeCell.delegate = self
        screenShotLargeCell.dataSource = self
        screenShotLargeCell.register(UINib(nibName: "ScreenShotCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCollectionCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setViewDataObj(info:SearchInfo) {
        self.info = info
        self.imgList = info.screenshotUrls!
    }
    
    static func cellHeight()->CGFloat{
        return 769
    }
}

extension ScreenShotTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCollectionCell", for: indexPath) as? ScreenShotCollectionCell else{
            return UICollectionViewCell()
        }
        cell.setViewDataObj(img: self.imgList[indexPath.row])
        return cell
    }
}

extension ScreenShotTableCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return ScreenShotCollectionCell.cellSize()
    }
}
