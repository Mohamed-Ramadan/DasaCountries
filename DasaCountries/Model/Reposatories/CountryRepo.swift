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
    
    func getReomte(searchKey: String, onComplete: @escaping(_ mapList:[Country]?)->Void ){
        
        let url = Constant.BASE_URL + "name/\(searchKey)"
        
        ApiCalling.request(requestUrl: url , httpMethod: .get, paramter:[:]) {
            (response , responseCode , errMsg) in
            
            if responseCode == 200 {
                var countriesArr = [Country]()
                
                if let result = self.isValidResponse(response: response) as? (Bool,JSON),result.0 == true {
                    for ele in result.1 {
                        guard let s = CodableHandler.decodeClass(Country.self, classJsonData:ele.1)  as? Country else {
                            onComplete(nil)
                            return}
                        
                        countriesArr.append(s)
                    }
                }
                
                onComplete(countriesArr)
            } 
            
            onComplete(nil)
            return
        }
    }
}
