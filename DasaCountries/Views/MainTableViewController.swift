//
//  MainTableViewController.swift
//  DasaCountries
//
//  Created by macbook on 7/18/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit
import CoreLocation

class MainTableViewController: UITableViewController {
 
    let countryCellIdentifier = "countryCellIdentifier"
    let locationManager = CLLocationManager()
    var isLocationLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.title = "Countries" 
    
        setupLocationManager()
        setupUI()
        
        // view model callbacks
        getData()
        
        // load countries
        MainViewModel.shared.loadCountires()
    }
  
    func setupLocationManager() {
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
          
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation() 
    }
    
    func setupUI() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(self.didClickSearchButton))
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem 
    }
    
    func getData() {  
        MainViewModel.shared.compleationHandlerWithError = {
            self.tableView.reloadData()
        }
        
        MainViewModel.shared.reloadTablwView = {
            self.tableView.reloadData()
        }
        
        CountriesViewModel.shared.countryByCodeCompleationHandler = { country in
            MainViewModel.shared.addCountry(country)
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
            MainViewModel.shared.removeCountry(MainViewModel.shared.countriesArray[indexPath.row])
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    } 
}

extension MainTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         
        switch status {
        case .notDetermined, .restricted, .denied:
            print("No access")
            // load Egypt Details as a default country
            if MainViewModel.shared.countriesArray.count == 0 {
                CountriesViewModel.shared.getCountyByCode("eg")
            } 
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
 
        if !isLocationLoaded {
            isLocationLoaded = true
        } else {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
                print(placemark.locality ?? "No Locality Founded")
                print(placemark.administrativeArea ?? "No AdministrativeArea Founded")
                print(placemark.country ?? "No Country Name Founded")
                print(placemark.isoCountryCode ?? "No Country Code Founded")
                 
                if MainViewModel.shared.countriesArray.count == 0 {
                    // load country details by country code
                    // if country code no avaliable, then get Egypt details by code "eg"
                    CountriesViewModel.shared.getCountyByCode(placemark.isoCountryCode ?? "eg")
                }
                
                // stop updating location
                self.locationManager.stopUpdatingLocation()
                return
            }
        }
    }
}
