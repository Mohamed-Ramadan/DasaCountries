//
//  Country.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

import Foundation

// MARK: - WelcomeElement
struct Country: Codable {
    let name: String
    let capital: String
    let region, subregion: String
    let area: Int
    let nativeName, numericCode: String
    let currencies: [Currency]
    let languages: [Language]
    let flag: String
    let cioc: String
}

// MARK: - Currency
struct Currency: Codable {
    let code, name: String
    let symbol: String?
}

// MARK: - Language
struct Language: Codable {
    let name, nativeName: String

    enum CodingKeys: String, CodingKey {
        case name, nativeName
    }
}
 
typealias CountriesResponse = [Country]

 
