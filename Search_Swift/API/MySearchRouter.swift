//
//  MySearchRouter.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/11/06.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation
import Alamofire

// 검색관련 api
enum MySearchRouter: URLRequestConvertible {
    
    case searchData(term: String)

    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }

    var method: HTTPMethod {
        switch self {
        case .searchData:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .searchData:
            return "search/"
        }
    }
    
    var parameters : [String: String] {
        
        switch self {
        case let .searchData(term):
            return ["media" : "software",
                    "entity" : "software",
                    "term" : term,
                    "country" : "kr"]
        }
   
    }

    func asURLRequest() throws -> URLRequest {
        
        let url = baseURL.appendingPathComponent(endPoint)
        
        print("MySearchRouter - asURLRequest() url : \(url)")
        
        var request = URLRequest(url: url)
        
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
        return request
    }
}
