//
//  ScreenShotCollectionCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ScreenShotCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
    }
    
    static func cellSize() -> CGSize{
        return CGSize(width: 392, height: 696)
    }
    
    func setViewDataObj(img:URL) {
        print("img-->\(img)")
        imgView.load(url: img)
    }

}
