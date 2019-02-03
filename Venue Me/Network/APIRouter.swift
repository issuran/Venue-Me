//
//  APIRouter.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 17/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getVenues(lat: Double, lon: Double)
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.Server.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getVenues:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getVenues:
            return "venues/search"
        }
    }

    private var parameters: Parameters? {
        switch self {
        case .getVenues(let latitute, let longitute):
            let lat = String(latitute)
            let lon = String(longitute)
            let date = Date()
            return [
                Constants.Parameters.locale : "\(lat),\(lon)",
                Constants.Parameters.clientId: Constants.Keys.clientId,
                Constants.Parameters.clientSecret: Constants.Keys.clientSecret,
                Constants.Parameters.version: date.foursquareVersion()
            ]
        }
    }
}

extension Date {
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "DD"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: self)
    }
    
    func foursquareVersion() -> String {
        return year + month + day
    }
}
