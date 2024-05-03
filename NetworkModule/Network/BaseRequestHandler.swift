//
//  BaseRequestHandler.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Alamofire
import Foundation

public typealias ResponseResult<T> = (ResultStatus<T>) -> Void

public protocol BaseRequestHandler {
    func request<T: Codable>(data _: T.Type, completion: @escaping ResponseResult<T>)
}

extension BaseRequestHandler where Self: URLRequestConvertible {
    public func request<T: Codable>(data _: T.Type, completion: @escaping ResponseResult<T>) {
        AF.request(self).debugLog().validate().responseJSON { response_ in
            print(response_.result)

            //=======================================================
            let parse = RequstParsing()
            parse.handleResponse(response_, completion: completion)
            //========================================================
        }
    }
}

///
public extension Request {
    func debugLog() -> Self {
        #if DEBUG
            debugPrint("=======================================")
            debugPrint(self)
            debugPrint("=======================================")
        #endif
        return self
    }
}
