//
//  MyLogger.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/11/06.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor {
    
    let queue = DispatchQueue(label: "MyLogger")
    
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume()")
        debugPrint(request)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("MyLogger - request.didParseResponse()")
        debugPrint(response)
    }
    
    
}
