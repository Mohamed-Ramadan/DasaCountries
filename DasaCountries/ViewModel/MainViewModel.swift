//
//  MainViewModel.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import Cache

class MainViewModel: ViewModel {
    static let shared = MainViewModel()
    
    private(set) var countriesArray = [Country]()
     
    var reloadTablwView:()->() = {}
    var showCantAddMoreThan5CountriesError: ()->() = {}
    var updateCountryDetailsNavigationBarButtonToUndo:()->() = {}
    var updateCountryDetailsNavigationBarButtonToAdd:()->() = {}
    
    let countriesStoredKey = "countriesStoredKey"
    let diskConfig = DiskConfig(name: "Floppy")
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
    
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
        self.refreshStoredCountries()
        self.refreshStoredCountries()
    }
    
    func removeCountry(_ country: Country) {
        // get index of this country
        if let index = countriesArray.firstIndex(where: {$0.name == country.name}) {
            countriesArray.remove(at: index)
            self.reloadTablwView()
            self.updateCountryDetailsNavigationBarButtonToAdd()
            self.refreshStoredCountries()
        }
    }
    
    func refreshStoredCountries() {
        // store countries into Cache
        let storage = try? Storage (
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [Country].self))
        do {
            try storage?.setObject(self.countriesArray, forKey: countriesStoredKey)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func loadCountires() {
        let storage = try? Storage(
          diskConfig: diskConfig,
          memoryConfig: memoryConfig,
          transformer: TransformerFactory.forCodable(ofType: [Country].self)
        )
 
        storage?.async.object(forKey: countriesStoredKey) { result in
            switch result {
            case .value(let countries):
                DispatchQueue.main.async {
                    self.countriesArray = countries
                    self.handleStoredData()
                }
            case .error(let error):
                print(error)
            }
        }
        
        fetchStoredCountries { (countries) in
        }
    }
    
    func handleStoredData() {
        if self.countriesStoredKey.count == 0 {
            // TODO: check location permission to load user country
            // if user did not give access before, then add Egypt as default country
            let egypt = Country(status: 200, message: nil, name: "Egypt", capital: "Cairo", currencies: [Currency(code: "EGP", name: "Egyptian Pound", symbol: "£")])
            DispatchQueue.main.async {
                self.addCountry(egypt)
            }
        }
        
        DispatchQueue.main.async {
            self.reloadTablwView()
        }
    }
    
    func fetchStoredCountries(_ complation:@escaping (([Country])->Void)) {
        // fetch countries from storage
        let storage = try? Storage(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [Country].self))

        storage?.async.object(forKey: countriesStoredKey) { result in
            switch result {
            case .value(let countries):
                complation(countries)
            case .error(let error):
                print(error)
                complation([])
            }
        }
    }
}
