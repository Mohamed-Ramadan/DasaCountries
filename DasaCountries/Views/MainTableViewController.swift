//
//  MainTableViewController.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let mainViewModel = MainViewModel()
    let countryCellIdentifier = "countryCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Countries"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    
        // view model callbacks
        getData()
        
        // load countries
        mainViewModel.loadCountires() 
    }
    
    func getData() {  
        mainViewModel.compleationHandlerWithError = {
            self.tableView.reloadData()
        }
        
        mainViewModel.reloadTablwView = {
            self.tableView.reloadData()
        }
        
        mainViewModel.showAddButton = {
            let addButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.didClickSearchButton))
            self.navigationItem.setRightBarButtonItems([addButton], animated: true)
        }
        
        mainViewModel.hideAddButton = {
            
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
        return mainViewModel.countriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: countryCellIdentifier)
        }
          
        // Configure the cell...
        cell?.textLabel?.text = mainViewModel.countriesArray[indexPath.row].name
        
        let capital = mainViewModel.countriesArray[indexPath.row].capital ?? ""
        let currency = mainViewModel.countriesArray[indexPath.row].currencies?.first?.name ?? ""
        cell.detailTextLabel?.text = "\(capital), \(currency)"
         
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = mainViewModel.countriesArray[indexPath.row]
        
        if let countryDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController {
            countryDetailsVC.country = selectedCountry
            self.navigationController?.pushViewController(countryDetailsVC, animated: true)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
