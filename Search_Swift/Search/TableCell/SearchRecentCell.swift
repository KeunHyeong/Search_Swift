//
//  SearchRecentCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchRecentCell: UITableViewCell {

    @IBOutlet weak var recentLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func cellHeight() -> CGFloat{
        return 44
    }
    
    func setViewDataObj(info:SearchTermInfo){
        recentLb.text = info.term
    }
}
