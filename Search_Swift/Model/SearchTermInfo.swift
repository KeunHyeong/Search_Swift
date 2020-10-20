//
//  SearchTermInfo.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/10/20.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchTermInfo: Codable {
    let term:String
    let timeStamp:TimeInterval
    
    init(term:String) {
        self.term = term
        self.timeStamp = Date().timeIntervalSince1970.rounded()
    }
}
