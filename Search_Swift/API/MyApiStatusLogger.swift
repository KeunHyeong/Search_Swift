//
//  MyApiStatusLogger.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/11/06.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation
import Alamofire

final class MyApiStatusLogger : EventMonitor {
    
    let queue = DispatchQueue(label: "MyApiStatusLogger")
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        
        guard let statusCode = request.response?.statusCode else { return }
        
        print("MyApiStatusLogger - request.didParseResponse() / statusCode : \(statusCode)")
        
        
//        debugPrint(response)
    }
}
