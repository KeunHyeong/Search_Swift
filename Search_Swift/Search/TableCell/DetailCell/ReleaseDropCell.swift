//
//  ReleaseDropCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ReleaseDropCell: UITableViewCell {
    
    var time:String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViewDataObj(info:SearchInfo){
        
    }
    
    private func currentTime(updateTime:String) -> String{
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "MM"
        let time = timeFormat.string(from: Date())
        
        return time
    }
    
}
