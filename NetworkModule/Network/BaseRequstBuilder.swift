//
//  BaseRequstBuilder.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Foundation
import Alamofire

// MARK: - Body Protocol

/// Using this protocol to implemment sending data
public protocol BodyParamter {
    var body: [String: Any] { get }
}

public protocol BaseRequestBuilder: URLRequestConvertible, BaseRequestHandler {
    /// Path
    var baseURL: String { get }
    var path: String { get }

    /// Paramter
    var parameter: [String: Any]? { get }

    /// Headers
    var headers: [String: String] { get }

    /// Http Method
    var hettpMethod: HTTPMethod { get }

    ///
    var urlRequest: URLRequest { get }
    var encoding: ParameterEncoding { get }
}

extension BaseRequestBuilder {
    /// ---------Path
    var baseURL: String {
        let testURl = "http://universities.hipolabs.com"
        return testURl
    }

    /// Paramter
    public var parameter: [String: Any]? {
        return nil
    }

    var multipartParmter: [String: Any] {
        return parameter!
    }

    // Headers
    var headers: [String: String] {
        return [:]
    }

    /// Http Method
    var hettpMethod: HTTPMethod {
        return .get
    }

    //=================================================
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var urlRequest: URLRequest {
        let _urlPath = (baseURL + path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        guard let _url = URL(string: _urlPath) else {
            fatalError("Invalid url ............")
        }
        var request = URLRequest(url: _url)
        request.httpMethod = hettpMethod.rawValue
        request.allHTTPHeaderFields = headers

        return request
    }

    // MARK: - URLRequestConvertible

    public func asURLRequest() throws -> URLRequest {
        print("Url :\(String(describing: urlRequest.url)) parm:\(String(describing: parameter))  Headers:\(String(describing: headers))")

        return try encoding.encode(urlRequest, with: parameter)
    }
}
