//
//  CountriesTableViewController.swift
//  DasaCountries
//
//  Created by macbook on 7/17/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    let countriesVM = CountriesViewModel()
    let countryCellIdentifier = "countryCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Countries" 
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
 
        // setup table view
        setupUI()
        
        // view model callbacks
        getData() 
    }
    
    func setupUI() {
        // register default table view cell
        tableView.keyboardDismissMode = .onDrag
        self.setPleceholderMessageForEmptyCountriesList()
        
        // set search bar delegte
        self.searchBar.delegate = self
    }

    func setPleceholderMessageForEmptyCountriesList() {
        tableView.setEmptyMessage("There is no search result.", image: #imageLiteral(resourceName: "no_search_result"))
    }
    
    func getData() {
        countriesVM.countriesCompleationHandler = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        countriesVM.compleationHandlerWithError = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countriesVM.countriesArray.count > 0 {
            tableView.restore()
        } else {
            self.setPleceholderMessageForEmptyCountriesList()
        }
         
        return countriesVM.countriesArray.count
    }

     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: countryCellIdentifier)
        }
          
        // Configure the cell...
        cell?.textLabel?.text = countriesVM.countriesArray[indexPath.row].name
        
        let capital = countriesVM.countriesArray[indexPath.row].capital ?? ""
        let currency = countriesVM.countriesArray[indexPath.row].currencies?.first?.name ?? ""
        cell.detailTextLabel?.text = "\(capital), \(currency)"
         
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countriesVM.countriesArray[indexPath.row]
        
        if let countryDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController {
            countryDetailsVC.country = selectedCountry
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(countryDetailsVC, animated: true)
            } 
        }
    }
}

extension CountriesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            countriesVM.reformatData()
            self.tableView.reloadData()
            return
        }
        
        countriesVM.getCountries(searchKey: searchText)
    }
}
