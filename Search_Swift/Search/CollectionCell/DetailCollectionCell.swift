//
//  DetailCollectionCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import Kingfisher

class DetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    let cache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.borderWidth = 0.5
    }
    
    static func cellSize() -> CGSize{
        return CGSize(width: 200, height: 450)
    }
    
    func setViewDataObj(img:String) {
        imgView.load(urlString: img)
//        imgView.load(url: img,cache: cache)
        
    }
}
