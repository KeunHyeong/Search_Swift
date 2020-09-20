//
//  desDropTableCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class DesDropTableCell: UITableViewCell {

    @IBOutlet weak var desLb: UILabel!
    @IBOutlet weak var corpLb: UILabel!
    @IBOutlet weak var moreLb: UILabel!
    var des:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        desLb.numberOfLines = 0
        moreLb.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            moreLb.text = ""
        }
    }
    
    func cellHeight() -> CGFloat{
        let desHeight = des.height(withConstrainedWidth: desLb.frame.width, font: UIFont.systemFont(ofSize: 15))
        return desHeight
    }
    
    func setViewDataObj(info:SearchInfo) {
        des = info.description!
        
        desLb.text = info.description
        corpLb.text = info.corpName
    }
}
