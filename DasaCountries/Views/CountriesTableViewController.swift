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
        self.title = "Countries"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
 
        // setup table view
        setupUI()
        
        // view model callbacks
        getData()
        
        countriesVM.getCountries(searchKey: "egypt")
    }
    
    func setupUI() {
        // register default table view cell
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: countryCellIdentifier)
        
        // set search bar delegte
        self.searchBar.delegate = self
    }

    
    func getData() {
        countriesVM.countriesCompleationHandler = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        let capital = countriesVM.countriesArray[indexPath.row].capital
        let currency = countriesVM.countriesArray[indexPath.row].currencies.first?.name
        cell.detailTextLabel?.text = "\(capital), \(currency ?? "")"
         
        return cell
    }
     
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension CountriesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countriesVM.getCountries(searchKey: searchText)
    }
}
