//
//  DetailCommonCell.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class DetailCommonCell: UITableViewCell {

    @IBOutlet weak var commTitle: UILabel!
    @IBOutlet weak var setStr: UILabel!
    var des:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellHeight() -> CGFloat{
        let desHeight = des.height(withConstrainedWidth: setStr.frame.width, font: UIFont.systemFont(ofSize: 15))
        if desHeight > 60{
            return desHeight
        }
        return 60
    }
    
    func setViewDataObj(type:String,info:SearchInfo){
        if type == "크기" {
            
            let bytes = info.fileSizeBytes!
            setStr.text = Units(bytes: Int64(bytes)!).getReadableUnit()
        } else if type == "카테고리" {
            
            setStr.text = info.primaryGenreName!
            
        } else if type == "언어" {
            
        } else if type == "저작권" {
            setStr.text = "@\(info.corpName!)"
        } else if type == "연령 등급"{
            let adv: String = info.advisories!.joined(separator: "\n")
            setStr.text = adv
        }
        
        commTitle.text = type
    }
}

public struct Units {
  
  public let bytes: Int64
  
  public var kilobytes: Double {
    return Double(bytes) / 1_024
  }
  
  public var megabytes: Double {
    return kilobytes / 1_024
  }
  
  public var gigabytes: Double {
    return megabytes / 1_024
  }
  
  public init(bytes: Int64) {
    self.bytes = bytes
  }
  
  public func getReadableUnit() -> String {
    
    switch bytes {
    case 0..<1_024:
      return "\(bytes) bytes"
    case 1_024..<(1_024 * 1_024):
      return "\(String(format: "%.2f", kilobytes)) KB"
    case 1_024..<(1_024 * 1_024 * 1_024):
      return "\(String(format: "%.2f", megabytes)) MB"
    case (1_024 * 1_024 * 1_024)...Int64.max:
      return "\(String(format: "%.2f", gigabytes)) GB"
    default:
      return "\(bytes) bytes"
    }
  }
}
