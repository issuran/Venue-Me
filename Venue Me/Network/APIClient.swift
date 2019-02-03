//
//  APIClient.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 17/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    static func getVenues(latitute: Double, longitute: Double) {
        return request(APIRouter.getVenues(lat: latitute, lon: longitute))
    }
    
    private static func request(_ urlConvertible: URLRequestConvertible) {
//        _ = Alamofire.request(urlConvertible).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
//        }
            Alamofire.request(urlConvertible).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
    
                var array = [AnyObject]()
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let innerDict = dict["response"] {
                        if let inDict = innerDict["venues"] {
                            array = inDict as! [AnyObject]
                        }
                    }
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    try? JSONDecoder().decode(Venues.self, from: json as! Data)
                }
    
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
            }
    }
}
