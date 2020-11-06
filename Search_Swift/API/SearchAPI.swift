//
//  SearchAPI.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import Alamofire

class SearchAPI {
    
    // 싱글턴 적용
    static let shared = SearchAPI()
    
    // 인터셉터
    let interceptors = Interceptor(interceptors:
        [
            BaseInterceptor()
    ])
    // 로거 설정
    let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]
    
    // 세션 설정
    var session : Session
    
    private init() {
        session = Session(
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }
    
    func requestSearch(searchTerm userInput: String,
                   completion: @escaping ([SearchInfo])->Void){
        
        print("MyAlamofireManager - getPhotos() called userInput : \(userInput)")
        
        self.session
            .request(MySearchRouter.searchData(term: userInput))
            .validate(statusCode: 200..<401)
            .responseJSON { (response) in
                switch response.result{
                case .success(let obj):
                    do {
                        let dataJSOn = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                           
                        let searchInfos = SearchAPI.parseInfo(data: dataJSOn)
                        completion(searchInfos)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    
                }
        }
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
    
    //    static func requestSearch(_ term:String, completion: @escaping ([SearchInfo])->Void){
    //
    //        let session = URLSession(configuration:.default)
    //        let iTunesURL = "https://itunes.apple.com/search?"
    //
    //        var urlComponents = URLComponents(string:iTunesURL)!
    //        let mediaQuery = URLQueryItem(name: "media", value: "software")
    //        let entityQuery = URLQueryItem(name: "entity", value: "software")
    //        let termQuery = URLQueryItem(name: "term", value: term)
    //        let countryQuery = URLQueryItem(name: "country", value: "kr")
    //
    //        urlComponents.queryItems?.append(mediaQuery)
    //        urlComponents.queryItems?.append(entityQuery)
    //        urlComponents.queryItems?.append(termQuery)
    //        urlComponents.queryItems?.append(countryQuery)
    //
    //        let requestURL = urlComponents.url!
    //
    //        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    //            let successRange = 200..<300
    //            guard error == nil,
    //                let statusCode = (response as? HTTPURLResponse)?.statusCode,
    //                successRange.contains(statusCode) else {
    //                    completion([])
    //                    return
    //            }
    //
    //            guard let resultData = data else {
    //                completion([])
    //                return
    //            }
    //
    //            let searchInfos = SearchAPI.parseInfo(data: resultData)
    //            completion(searchInfos)
    //        }
    //
    //        dataTask.resume()
    //    }
    //
    //    static func parseInfo(data: Data) ->[SearchInfo]{
    //        let decoder = JSONDecoder()
    //
    //        do {
    //            let response = try decoder.decode(APIResponse.self, from: data)
    //            let searchInfos = response.searchInfos
    //            return searchInfos
    //        } catch let error {
    //            print("--> parsing error: \(error.localizedDescription)")
    //            return []
    //        }
    //    }
}
