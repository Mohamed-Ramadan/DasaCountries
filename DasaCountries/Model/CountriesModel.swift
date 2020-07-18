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
class Country: Codable {
    let status: Int?
    let message: String?
    let name: String?
    let capital: String?
    let currencies: [Currency]?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
        currencies = try values.decodeIfPresent([Currency].self, forKey: .currencies)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}

// MARK: - Currency
class Currency: Codable {
    let code, name: String?
    let symbol: String?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
    }
}


typealias CountriesModel = [Country]

 
