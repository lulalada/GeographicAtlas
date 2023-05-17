//
//  CountryModel.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-12.
//

import Foundation
struct CountryModel: Decodable {
    let continents: [String]
    let flags: Flags
    let capital: [String]?
    let population: Int
    let currencies: [String: Currency]?
    let name: Name
    let area: Double?
    let timezones: [String]
    let cca2: String
    let subregion: String?
    let capitalInfo: Coordinates?
    let maps: Map
}
struct Flags: Codable {
    let png: String
}
struct Name: Codable {
    let common: String
}
struct Currency: Decodable {
    let name: String
    let symbol: String?
}

struct Coordinates: Codable {
    let latlng: [Double]?
}
struct Map: Codable {
    let openStreetMaps: String?
}
