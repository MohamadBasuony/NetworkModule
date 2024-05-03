//
//  RequstParsing.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Response

struct Response {
    var reponse: HTTPURLResponse?
    var error: Error?
    var data: Data?

    var statusCode: Int {
        return reponse?.statusCode ?? 500
    }
}

public protocol BaseResponseHandler {
    func handleResponse<T>(_ response: AFDataResponse<Any>, completion: @escaping ResponseResult<T>) where T: Codable
}

open class RequstParsing: NSObject {}

extension RequstParsing: BaseResponseHandler {
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    public func handleResponse<T>(_ response: AFDataResponse<Any>, completion: @escaping ResponseResult<T>) where T: Codable {
        let _response = Response(reponse: response.response, error: response.error, data: response.data)

        if !isConnectedToInternet() {
            var error = NoInternetError()
            error.isNoInternet = true
            completion(ResultStatus<T>.failure(error))
            return
        }

        guard let _ = response.response else {
            completion(ResultStatus<T>.failure(BadURLError()))
            return
        }

        switch _response.statusCode {
        case 200 ... 205:
            handleSuccess(response, completion: completion)
        case 401:
            completion(ResultStatus<T>.failure(ValidationError(data: _response.data)))
        case 400 ... 499:
            completion(ResultStatus<T>.failure(ValidationError(data: _response.data)))
        case 500 ... 511:
            completion(ResultStatus<T>.failure(InternalServerError()))
        case -1009:
            var error = NoInternetError()
            error.isNoInternet = true
            completion(ResultStatus<T>.failure(error))
        case -999:
            completion(ResultStatus<T>.failure(CancelledError()))
        case -1022:
            completion(ResultStatus<T>.failure(BadURLError()))

        default: break
        }
    }

    private func handleSuccess<T>(_ response: AFDataResponse<Any>, completion: @escaping ResponseResult<T>) where T: Codable {
        if let json = response.data {
            do {
                let decoder = JSONDecoder()
                let modules = try decoder.decode(T.self, from: json)
                completion(ResultStatus<T>.success(modules))
            } catch {
                print(error)
                completion(ResultStatus<T>.failure(error))
            }
        }
    }
}
