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
    let cache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        imgView.isUserInteractionEnabled = true
        
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.borderWidth = 0.5
    }
    
    static func cellSize() -> CGSize{
        return CGSize(width: 300, height: 600)
    }
    
    func setViewDataObj(img:String) {
        imgView.load(url: img,cache: self.cache)
    }

}
