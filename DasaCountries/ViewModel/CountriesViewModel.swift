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
 
    
    override init() {
        super.init()
    }
    
    public func reformatData() {
        countriesArray.removeAll()
    }
  
    func getCountries(searchKey: String){
        let coutriesRepo = CountryRepo()
         
        coutriesRepo.getReomte(searchKey: searchKey , onComplete: {
            countryList in
            if countryList != nil {
                self.countriesArray = countryList ?? []
                self.countriesCompleationHandler()
                return
            }
            self.compleationHandlerWithError()
        })
    } 
}
