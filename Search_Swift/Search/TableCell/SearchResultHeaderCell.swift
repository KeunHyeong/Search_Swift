//
//  SearchResultHeaderCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import Cosmos

class SearchResultHeaderCell: UITableViewCell {

    @IBOutlet weak var appProfileImgView: UIImageView!
    @IBOutlet weak var appTitleLb: UILabel!
    @IBOutlet weak var appSubTitleLb: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBOutlet weak var starRatingLb: UILabel!
    
    @IBOutlet weak var starRatingView: CosmosView!
    
    @IBOutlet weak var userRatingLb: UILabel!
    
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var ageLb_2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appProfileImgView.layer.masksToBounds = true
        appProfileImgView.layer.borderWidth = 1
        appProfileImgView.layer.cornerRadius = 15
        appProfileImgView.layer.borderColor = UIColor.white.cgColor
        
        downloadBtn.layer.masksToBounds = true
        downloadBtn.layer.cornerRadius = 15
        downloadBtn.layer.borderColor = UIColor.clear.cgColor
        downloadBtn.layer.borderWidth = 1
        
        starRatingView.settings.updateOnTouch = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        starRatingView.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellHeight() -> CGFloat{
        return 200
    }
    
    func setViewDataObj(info:SearchInfo) {
        
        appProfileImgView.load(url: info.artworkUrl100!)
        appTitleLb.text = info.title
        appSubTitleLb.text = info.primaryGenreName
        
        starRatingView.rating  = info.averageUserRating!
        
        let str = "\(info.averageUserRating!)"
        
        let endIdx: String.Index = str.index(str.startIndex, offsetBy: 2)
        let decimal = String(str[...endIdx])
        
        starRatingLb.text = decimal
        
        let rating = self.returnUserRating(rating: info.userRatingCount!)
        userRatingLb.text = "\(rating)개의 평가"
        
        ageLb.text = info.trackContentRating!
        ageLb_2.text = "연령"
    }
}

