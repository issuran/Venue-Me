//
//  Constants.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 17/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import Foundation

struct Constants {

    struct Server {
        static let baseURL = "https://api.foursquare.com/v2/"
    }

    struct Path {
        static let searchVenue = "venues/search"
    }

    struct Keys {
        static let clientId = "Y5KXFPRM4R4AO3VR44RYED2LOEH1Q0V31EDHQORTWFBBAFOP"
        static let clientSecret = "THVYGNTSKZ2VGDUUGIXM5VWWCMBJYY31I4PD2VQWEYWYHWTU"
    }

    struct Parameters {
        static let locale = "ll"
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let version = "v"
    }

    enum HttpHeaderField: String {
        case contentType = "Content-Type"
        case acceptType = "Accept"
    }

    enum ContentType: String {
        case json = "application/json"
    }
}
