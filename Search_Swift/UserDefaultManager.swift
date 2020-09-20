//
//  UseDefaultManager.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class UserDefaultManager {
    
    var recentSearchTermList = [String]()
    
    init(recentSearchTermList:[String]) {
        self.recentSearchTermList = recentSearchTermList
    }
    
    static func setRecentSearchTermList(recentList:[String]){
        let defaults = UserDefaults.standard
        defaults.set(recentList, forKey: "recentSearchTermList")
    }
    
    static func getRecentSearchTermList() -> [String]{
        
        
        let defaults = UserDefaults.standard
//        resetDefaults()
        guard let array = defaults.array(forKey: "recentSearchTermList") as? [String] else { return [] }
        
        return array
    }
    
    static func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

}
