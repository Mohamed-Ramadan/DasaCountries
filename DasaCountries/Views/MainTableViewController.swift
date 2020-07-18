//
//  MainTableViewController.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    //let mainViewModel = MainViewModel()
    let countryCellIdentifier = "countryCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Countries" 
    
        setupUI()
        
        // view model callbacks
        getData()
        
        // load countries
        MainViewModel.shared.loadCountires()
    }
    
    func setupUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.didClickSearchButton))
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
        
        self.tableView.isEditing = true
    }
    
    func getData() {  
        MainViewModel.shared.compleationHandlerWithError = {
            self.tableView.reloadData()
        }
        
        MainViewModel.shared.reloadTablwView = {
            self.tableView.reloadData()
        } 
    }
    
    // MARK: - Button Actions
    @objc func didClickSearchButton() {
        if let searchCountriesVC = self.storyboard?.instantiateViewController(withIdentifier: "CountriesTableViewController") as? CountriesTableViewController {
            self.navigationController?.pushViewController(searchCountriesVC, animated: true)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MainViewModel.shared.countriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: countryCellIdentifier)
        }
          
        // Configure the cell...
        cell?.textLabel?.text = MainViewModel.shared.countriesArray[indexPath.row].name
        
        let capital = MainViewModel.shared.countriesArray[indexPath.row].capital ?? ""
        let currency = MainViewModel.shared.countriesArray[indexPath.row].currencies?.first?.name ?? ""
        cell.detailTextLabel?.text = "\(capital), \(currency)"
         
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = MainViewModel.shared.countriesArray[indexPath.row]
        
        if let countryDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController {
            countryDetailsVC.country = selectedCountry
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(countryDetailsVC, animated: true)
            }
        }
    }
     
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            MainViewModel.shared.removeCountry(MainViewModel.shared.countriesArray[indexPath.row])
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    } 
}
