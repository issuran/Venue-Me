//
//  Venue.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 15/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import Foundation

struct Venues: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    let categories: Categories
}

struct Location: Codable {
    let address: String
    let crossStreet: String
    let latitute: Double
    let longitute: Double
    let distance: Int
    let city: String
    let state: String
    let country: String
}

struct Categories: Codable {
    let category: [Category]
}

struct Category: Codable {
    let name: String
}
