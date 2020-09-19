//
//  SearchAPI.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchAPI {
    
    static func requestSearch(_ term:String, completion: @escaping ([SearchInfo])->Void){
        
        let session = URLSession(configuration:.default)
        let iTunesURL = "https://itunes.apple.com/search?"
        
        var urlComponents = URLComponents(string:iTunesURL)!
        let mediaQuery = URLQueryItem(name: "media", value: "software")
        let entityQuery = URLQueryItem(name: "entity", value: "software")
        let termQuery = URLQueryItem(name: "term", value: term)
        
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            let successRange = 200..<300
            guard error == nil,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    completion([])
                    return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let searchInfos = SearchAPI.parseInfo(data: resultData)
            completion(searchInfos)
        }
        
        dataTask.resume()
    }
    
    static func parseInfo(data: Data) ->[SearchInfo]{
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(APIResponse.self, from: data)
            let searchInfos = response.searchInfos
            return searchInfos
        } catch let error {
            print("--> parsing error: \(error.localizedDescription)")
            return []
        }
    }
    
}
