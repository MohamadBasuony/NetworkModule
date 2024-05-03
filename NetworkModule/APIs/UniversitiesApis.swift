//
//  UniversitiesEndPoints.swift
//  InvadeTask
//
//  Created by Mohamad Basuony on 02/05/2024.
//

import Foundation
import Alamofire

public enum UniversitiesApis : BaseRequestBuilder {
   case searchUniversities

    public var path: String {
        switch self {
        case .searchUniversities: return "/search"
        }
    }
    
    public var parameter: [String : Any]? {
        return ["country" : "United Arab Emirates"]
    }

    public var hettpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    public var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }

    public var headers: [String: String] {
        switch self {
        default: return [:]
        }
    }

    public var baseURL: String {
        switch self {
        default:
            return "http://universities.hipolabs.com"
        }
    }
    
}
