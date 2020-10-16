//
//  SearchDetailCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import Cosmos

class SearchDetailCell: UITableViewCell {

    @IBOutlet weak var appProfileImgView: UIImageView!
    @IBOutlet weak var appTitleLb: UILabel!
    @IBOutlet weak var subTitleLb: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var openBtn: UIButton!
    
    @IBOutlet weak var screenShot_1: UIImageView!
    @IBOutlet weak var screenShot_2: UIImageView!
    @IBOutlet weak var screenShot_3: UIImageView!
    
    let cache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        appProfileImgView.layer.cornerRadius = 9
        appProfileImgView.layer.masksToBounds = true
        appProfileImgView.layer.borderColor = UIColor.lightGray.cgColor
        appProfileImgView.layer.borderWidth = 0.5
        
        screenShot_1.layer.cornerRadius = 12
        screenShot_2.layer.cornerRadius = 12
        screenShot_3.layer.cornerRadius = 12
        
        screenShot_1.clipsToBounds = true
        screenShot_2.clipsToBounds = true
        screenShot_3.clipsToBounds = true
        
        screenShot_1.layer.borderColor = UIColor.lightGray.cgColor
        screenShot_2.layer.borderColor = UIColor.lightGray.cgColor
        screenShot_3.layer.borderColor = UIColor.lightGray.cgColor
        
        screenShot_1.layer.borderWidth = 0.5
        screenShot_2.layer.borderWidth = 0.5
        screenShot_3.layer.borderWidth = 0.5
        
        openBtn.layer.cornerRadius = 16

        starRatingView.settings.updateOnTouch = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        starRatingView.prepareForReuse()
    }
    
    func setViewDataObj(info:SearchInfo) {
        
        appTitleLb.text = info.title
        subTitleLb.text = info.primaryGenreName
        
        appProfileImgView.load(urlString: info.artworkUrl60!)
//        appProfileImgView.load(url: info.artworkUrl60!,cache: self.cache)

        if info.screenshotUrls?.count == 1{
            screenShot_1.load(urlString: info.screenshotUrls![0])
        }else if info.screenshotUrls?.count == 2{
            screenShot_1.load(urlString: info.screenshotUrls![0])
            screenShot_1.load(urlString: info.screenshotUrls![1])
        }else{
            screenShot_1.load(urlString: info.screenshotUrls![0])
            screenShot_2.load(urlString: info.screenshotUrls![1])
            screenShot_3.load(urlString: info.screenshotUrls![2])
        }

        starRatingView.rating = info.averageUserRating!
        
        starRatingView.text = self.returnUserRating(rating: info.userRatingCount!)
    }
    
    static func cellHeight() -> CGFloat {
        return 320
    }
}



