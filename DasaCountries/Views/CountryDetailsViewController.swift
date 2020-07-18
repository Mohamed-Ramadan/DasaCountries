//
//  CountryDetailsViewController.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let country = self.country {
            // navigation bar title
            self.title = country.name
            
            capitalLabel.text = country.capital
            
            let currenyName = country.currencies?.first?.name
            let currencyCode = country.currencies?.first?.code
            currencyLabel.text = "\(currenyName ?? "") (\(currencyCode ?? ""))"
        }
    }  
}
