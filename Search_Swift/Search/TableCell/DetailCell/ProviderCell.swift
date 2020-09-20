//
//  ProviderCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ProviderCell: UITableViewCell {

    @IBOutlet weak var corpName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellHeight() -> CGFloat{
        return 100
    }
    
    func setViewDataObj(info:SearchInfo){
        corpName.text = info.corpName!
        
    }
    
}

