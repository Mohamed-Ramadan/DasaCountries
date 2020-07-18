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
    var showAddButton: ()->() = {}
    var hideAddButton:()->() = {}
    
    override init() {
        super.init()
    }
    
    public func reformatData() {
        countriesArray.removeAll()
    }
  
    func addCountry(_ country: Country) {
        countriesArray.append(country)
        self.reloadTablwView()
        
        if countriesArray.count == 5 {
            self.hideAddButton()
        } else {
            self.showAddButton()
        }
        
    }
    
    func removeCountryAtIndex(_ index: Int) {
        countriesArray.remove(at: index)
        self.reloadTablwView()
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
