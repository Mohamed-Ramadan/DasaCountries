//
//  CountryRepo.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryRepo: MainRepository {
    
    func getCountryBySearchKey(_ searchKey: String, onComplete: @escaping(_ mapList:[Country]?)->Void ){
        
        let url = Constant.BASE_URL + "name/\(searchKey)"
        
        ApiCalling.request(requestUrl: url , httpMethod: .get, paramter:[:]) {
            (data , responseCode , errMsg) in
            
            if responseCode == 200 {
                do {
                    let jsonDecoder = JSONDecoder()
                    let countriesResponse = try jsonDecoder.decode(CountriesModel.self, from: data as! Data)
                     onComplete(countriesResponse)
                    return
                      
                } catch (let error) {
                    print("Error Parsing Data: \(error.localizedDescription)")
                    onComplete(nil)
                    return
                }
            } 
            
            onComplete(nil)
            return
        }
    }
    
    func getCountryByCode(_ code: String, onComplete: @escaping(_ country:Country?)->Void ){
        
        let url = Constant.BASE_URL + "alpha/\(code)"
        
        ApiCalling.request(requestUrl: url , httpMethod: .get, paramter:[:]) {
            (data , responseCode , errMsg) in
            
            if responseCode == 200 {
                do {
                    let jsonDecoder = JSONDecoder()
                    let countriesResponse = try jsonDecoder.decode(Country.self, from: data as! Data)
                     onComplete(countriesResponse)
                    return
                      
                } catch (let error) {
                    print("Error Parsing Data: \(error.localizedDescription)")
                    onComplete(nil)
                    return
                }
            }
            
            onComplete(nil)
            return
        }
    }
}
