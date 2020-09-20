//
//  SearchRelatedCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchRelatedCell: UITableViewCell {

    @IBOutlet weak var keywordLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellHeight() -> CGFloat{
        return 44
    }
    
    func setViewDataObj(info:SearchInfo) {
        
        keywordLb.text = info.title
    }
    
    func setViewDataObj(info:String) {
        
        keywordLb.text = info
    }
    
}
