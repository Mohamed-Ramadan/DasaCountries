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
    let status: Int?
    let message: String?
    let name: String?
    let capital: String?
    let currencies: [Currency]?
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case name, capital, currencies
    }
}

// MARK: - Currency
struct Currency: Codable {
    let code, name: String?
    let symbol: String?
    
    enum CodingKeys: String, CodingKey { 
        case name, symbol, code
    }
}


typealias CountriesModel = [Country]

 
