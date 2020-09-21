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
//    @IBOutlet weak var versionHistoryLb: UIButton!
    var des:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        desLb.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellHeight() -> CGFloat{
        let desHeight = des.height(withConstrainedWidth: desLb.frame.width, font: UIFont.systemFont(ofSize: 14))
        if desHeight > 200 {
            return desHeight + 100
        }
        return 200
    }
    
    func setViewDataObj(info:SearchInfo) {
        des = info.releaseNotes!
        versionLb.text = "버전 " + info.version!
        desLb.text = info.releaseNotes!
        
        let releaseDate = stringToDate(date: info.currentVersionReleaseDate!)
        
        timeAgoLb.text = timeAgoSince(releaseDate)
    }
    
    private func stringToDate(date:String) -> Date{
        let isoDate = date

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)
        return date!
    }
    
    private func timeAgoSince(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) 년 전"
        }
        
        if let year = components.year, year >= 1 {
            return "일년 전"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) 달 전"
        }
        
        if let month = components.month, month >= 1 {
            return "지난 달"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) 주 전"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "지난 주"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) 일 전"
        }
        
        if let day = components.day, day >= 1 {
            return "어제"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) 시간 전"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "1 시간 전"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) 분 전"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "1분 전"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) 초 전"
        }
        return "방금"
    }
}
