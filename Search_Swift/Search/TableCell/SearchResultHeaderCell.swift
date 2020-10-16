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
    
    @IBOutlet weak var genreLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var ageLb_2: UILabel!
    
    let cache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appTitleLb.numberOfLines = 2
        appProfileImgView.layer.masksToBounds = true
        appProfileImgView.layer.borderWidth = 0.5
        appProfileImgView.layer.cornerRadius = 15
        appProfileImgView.layer.borderColor = UIColor.lightGray.cgColor
        
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
    
    override func layoutSubviews() {
          super.layoutSubviews()
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func cellHeight() -> CGFloat{
        return 200
    }
    
    func setViewDataObj(info:SearchInfo) {
        
        appProfileImgView.load(urlString:info.artworkUrl100!)
//        appProfileImgView.setImage(with: info.artworkUrl100!)
//        appProfileImgView.load(url: info.artworkUrl100!,cache: self.cache)
        appTitleLb.text = info.title
        appSubTitleLb.text = info.corpName
        
        starRatingView.rating  = info.averageUserRating!
        
        let str = "\(info.averageUserRating!)"
        
        let endIdx: String.Index = str.index(str.startIndex, offsetBy: 2)
        let decimal = String(str[...endIdx])
        
        starRatingLb.text = decimal
        
        let rating = self.returnUserRating(rating: info.userRatingCount!)
        userRatingLb.text = "\(rating)개의 평가"
        
        ageLb.text = info.trackContentRating!
        ageLb_2.text = "연령"
        genreLb.text = info.genres![0]
    }
}

