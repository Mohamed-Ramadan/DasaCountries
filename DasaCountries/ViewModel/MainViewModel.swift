//
//  MainViewModel.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

class MainViewModel: ViewModel {
    static let shared = MainViewModel()
    
    private(set) var countriesArray = [Country]()
     
    var reloadTablwView:()->() = {}
    var showCantAddMoreThan5CountriesError: ()->() = {}
    var updateCountryDetailsNavigationBarButtonToUndo:()->() = {}
    var updateCountryDetailsNavigationBarButtonToAdd:()->() = {}
    
    override init() {
        super.init()
    }
    
    public func reformatData() {
        countriesArray.removeAll()
    }
  
    func addCountry(_ country: Country) {
        // check for only 5 countries in main view
        if countriesArray.count == 5 {
            self.showCantAddMoreThan5CountriesError()
            return
        }
        
        // add this country to main counntries list
        countriesArray.append(country)
        self.reloadTablwView()
        self.updateCountryDetailsNavigationBarButtonToUndo()
    }
    
    func removeCountry(_ country: Country) {
        // get index of this country
        if let index = countriesArray.firstIndex(where: {$0.name == country.name}) {
            countriesArray.remove(at: index)
            self.reloadTablwView()
            self.updateCountryDetailsNavigationBarButtonToAdd()
        }
    }
    
    func loadCountires() {
        let storedCountries = fetchStoredCountries()
        
        if storedCountries.count == 0 {
            // TODO: check location permission to load user country
            // if user did not give access before, then add Egypt as default country
            let egypt = Country(status: 200, message: nil, name: "Egypt", capital: "Cairo", currencies: [Currency(code: "EGP", name: "Egyptian Pound", symbol: "£")])
            self.addCountry(egypt)
        }
        
        self.reloadTablwView()
    }
    
    func fetchStoredCountries() -> [Country] {
        // TODO: fetch countries from storage
        return []
    }
    
    func storeCountry() {
        // TODO: add country to storage
    }
}
