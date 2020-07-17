//
//  ViewModel.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import Foundation

class ViewModel {
    var compleationHandler:()->() = {}
    var compleationHandlerWithError:()->() = {}
    var completionHandlerWithError:(_ errCode:String, _ errorMsg:String)->Void = {_,_  in}
}
