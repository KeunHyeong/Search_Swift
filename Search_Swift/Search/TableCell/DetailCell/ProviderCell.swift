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
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func cellHeight() -> CGFloat{
        return 100
    }
    
    func setViewDataObj(info:SearchInfo){
        corpName.text = info.corpName!
    }
}

