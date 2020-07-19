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
    
    let mainViewModel = MainViewModel()
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Model Callbacks
        getData()
        
         
        if let country = self.country {
            // navigation bar title
            self.title = country.name
            
            capitalLabel.text = country.capital
            
            let currenyName = country.currencies?.first?.name
            let currencyCode = country.currencies?.first?.code
            currencyLabel.text = "\(currenyName ?? "") (\(currencyCode ?? ""))"
            
            if !MainViewModel.shared.countriesArray.contains(where: { $0.name == country.name }) {
                self.addAddToMainButton()
            } else {
                self.addRemoveFromMainButton()
            }
        }
    }
    
    func getData() {
        MainViewModel.shared.showCantAddMoreThan5CountriesError = {
            let alert = UIAlertController(title: "Attention", message: "You can add only 5 countries to Main View", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        MainViewModel.shared.updateCountryDetailsNavigationBarButtonToAdd = {
            self.addAddToMainButton()
        }
        
        MainViewModel.shared.updateCountryDetailsNavigationBarButtonToUndo = {
            self.addRemoveFromMainButton()
        } 
    }
    
    func addAddToMainButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.didClickAddButton))
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
    }
    
    func addRemoveFromMainButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(self.didClickRemoveButton))
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
    }
    
    // MARK: - Button Actions
    @objc func didClickAddButton() {
        if let country = self.country { 
            MainViewModel.shared.addCountry(country)
        } 
    }
    
    @objc func didClickRemoveButton() {
        if let country = self.country {
            MainViewModel.shared.removeCountry(country)
        }
    }
}
