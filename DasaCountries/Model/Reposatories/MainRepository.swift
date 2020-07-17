//
//  MainReposatory.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainRepository {
    
    var completionHandler:()->Void = {}
    var completionHandlerWithError:(_ err:String)->Void = {_ in}
    
    func isValidResponse(response:Any?,getDataFromArrayKey key: String = "data")->(Bool, JSON?){
        DispatchQueue.global(qos: .default).sync { 
            let result = JSON(response ?? "")
            return (true,result)
        } 
    }
    
    func isValidObject(response:Any?,getDataFromArrayKey key: String = "data")->(Bool, JSON?){
        DispatchQueue.global(qos: .default).sync {
            let jsonResponse = JSON(response ?? "")
            let result = JSON(jsonResponse[key].dictionaryValue)
            return (true,result)
        }
    }
}
