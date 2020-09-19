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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appProfileImgView.layer.cornerRadius = 9
        appProfileImgView.layer.masksToBounds = true
        appProfileImgView.layer.borderColor = UIColor.white.cgColor
        appProfileImgView.layer.borderWidth = 1
        
        screenShot_1.layer.cornerRadius = 30
        screenShot_2.layer.cornerRadius = 30
        screenShot_3.layer.cornerRadius = 30
        
        screenShot_1.clipsToBounds = true
        screenShot_2.clipsToBounds = true
        screenShot_3.clipsToBounds = true
        
        screenShot_1.layer.borderColor = UIColor.white.cgColor
        screenShot_2.layer.borderColor = UIColor.white.cgColor
        screenShot_3.layer.borderColor = UIColor.white.cgColor
        
        screenShot_1.layer.borderWidth = 1
        screenShot_2.layer.borderWidth = 1
        screenShot_3.layer.borderWidth = 1
        
        openBtn.layer.cornerRadius = 16

        starRatingView.didFinishTouchingCosmos = { rating in }
        starRatingView.didTouchCosmos = { rating in }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        starRatingView.prepareForReuse()
    }
    
    func setViewDataObj(info:SearchInfo) {
        
        appTitleLb.text = info.title
        //        genreTitleLb.text = info.primaryGenreName
        
        appProfileImgView.load(url: info.artworkUrl60!)
        
        screenShot_1.load(url: info.screenshotUrls![0])
        screenShot_2.load(url: info.screenshotUrls![1])
        screenShot_3.load(url: info.screenshotUrls![2])
        
        //        starRatingView.rating = info.averageUserRating!
    }
    
    static func cellHeight() -> CGFloat {
        return 300
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

