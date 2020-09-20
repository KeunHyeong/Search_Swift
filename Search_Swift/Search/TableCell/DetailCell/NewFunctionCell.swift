//
//  NewFunctionCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class NewFunctionCell: UITableViewCell {

    @IBOutlet weak var versionLb: UILabel!
    @IBOutlet weak var timeAgoLb: UILabel!
    @IBOutlet weak var desLb: UILabel!
    @IBOutlet weak var versionHistoryLb: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
