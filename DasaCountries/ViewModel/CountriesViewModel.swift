//
//  CountriesViewModel.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

class CountriesViewModel: ViewModel {
    static let shared = CountriesViewModel()
    
    private(set) var countriesArray = [Country]()
    
    var countriesCompleationHandler:()->() = {}
    var countryByCodeCompleationHandler:(Country)->() = {_ in}
    
    override init() {
        super.init()
    }
    
    public func reformatData() {
        countriesArray.removeAll()
    }
  
    func getCountries(searchKey: String){
        let coutriesRepo = CountryRepo()
         
        coutriesRepo.getCountryBySearchKey(searchKey , onComplete: {
            countryList in
            
            if countryList != nil {
                self.countriesArray = countryList ?? []
                self.countriesCompleationHandler()
                return
            } else {
                // there is an error or search return with no countries
                self.countriesArray.removeAll()
                self.compleationHandlerWithError()
            } 
        })
    }
    
    func getCountyByCode(_ code: String){
        let coutriesRepo = CountryRepo()
         
        coutriesRepo.getCountryByCode(code , onComplete: {
            country in
            
            if let country = country {
                self.countryByCodeCompleationHandler(country)
                return
            } else {
                // there is an error or search return with no countries
                self.compleationHandlerWithError()
            }
        })
    }
}
