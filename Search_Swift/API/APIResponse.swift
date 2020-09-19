//
//  APIResponse.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class APIResponse: Codable {
    let resultCount : Int
    let searchInfos :[SearchInfo]
    
    enum CodingKeys: String, CodingKey{
        case resultCount
        case searchInfos = "results"
    }

}
