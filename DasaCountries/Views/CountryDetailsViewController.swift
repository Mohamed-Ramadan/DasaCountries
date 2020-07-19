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
            self.backToMainView()
        }
        
        MainViewModel.shared.updateCountryDetailsNavigationBarButtonToUndo = {
            self.addRemoveFromMainButton()
            self.backToMainView()
        }
    }
    
    func addAddToMainButton() {
        let addToMainBtn = UIBarButtonItem(title: "Add To Main", style: .plain, target: self, action: #selector(self.didClickAddButton))
        self.navigationItem.setRightBarButtonItems([addToMainBtn], animated: true)
    }
    
    func addRemoveFromMainButton() {
        let removeToMainBtn = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(self.didClickRemoveButton))
        self.navigationItem.setRightBarButtonItems([removeToMainBtn], animated: true)
    }
    
    func backToMainView() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc.isKind(of: MainTableViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
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
