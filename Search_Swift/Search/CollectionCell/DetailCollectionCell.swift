//
//  DetailCollectionCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class DetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
    }
    
    static func cellSize() -> CGSize{
        return CGSize(width: 200, height: 500)
    }
    
    func setViewDataObj(img:URL) {
        imgView.load(url: img)
    }
}
