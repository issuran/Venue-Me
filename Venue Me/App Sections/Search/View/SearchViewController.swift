//
//  SearchViewController.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 15/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import MapKit

private let reuseIdentifier = "Cell"

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    
    var resultArray: [Venue]?
    var filteredResultArray: [Venue]?
    var isUserSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultArray = createMockVenue()
        
        setupTableView()
        setupSearchView()
        setupLocationManager()
    }
    
    func performRequest() {
        print("Perform Request")
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isUserSearching {
            return filteredResultArray?.count ?? 1
        }
        return resultArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
        
        if isUserSearching {
            let venue = filteredResultArray?[indexPath.row]
            cell.render(venue!)
        } else {
            let venue = resultArray?[indexPath.row]
            cell.render(venue!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func setupSearchView() {
        self.searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isUserSearching = true
        filterResults("")
        _ = shouldRequestLocationPermission()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isUserSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isUserSearching = false
        filterResults("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isUserSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterResults(searchText)
    }
    
    func filterResults(_ searchText: String) {
        filteredResultArray = resultArray?.filter({ (text) in
            return text.bindAddress().lowercased().contains(searchText.lowercased())
        })
        
        if filteredResultArray?.count == 0 {
            self.isUserSearching = false
        } else {
            self.isUserSearching = true
        }
        
        self.tableView.reloadData()
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        
        if shouldRequestLocationPermission() {
            return
        }
        locationManager.startUpdatingLocation()
    }
    
    func shouldRequestLocationPermission() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                requestPermission()
                requestLocationService()
            case .authorizedAlways, .authorizedWhenInUse:
                requestVenues()
                return false
            default:
                requestLocationService()
            }
        } else {
            requestLocationService()
        }
        
        return true
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        return
    }

    func requestLocationService() {
        let alert = UIAlertController(title: "Location Service Disabled",
                                      message: "Please allow the app permission to access your location",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: { _ in
                                        if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            self.locationManager.stopUpdatingLocation()
            let region = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            print("Latitude: \(region.latitude) || Longitude: \(region.longitude)")
            
            APIClient.getVenues(latitute: region.latitude, longitute: region.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func requestVenues() {
        locationManager.requestLocation()
    }
}

extension SearchViewController {
    func createMockVenue() -> [Venue] {
        return [
            {
                Venue(
                    id: "1",
                    name: "Mc Donalds",
                    location: Location(
                        address: "Address1",
                        crossStreet: "CrossStreet1",
                        latitute: 46.0,
                        longitute: -37.0,
                        distance: 16,
                        city: "City 1",
                        state: "SP",
                        country: "Country 1"),
                    categories: Categories(
                        category: [
                            {
                                Category(
                                    name: "Restaurant1")
                            }()
                        ])
                )
            }(),
            {
                Venue(
                    id: "2",
                    name: "Burguer King",
                    location: Location(
                        address: "Address2",
                        crossStreet: "CrossStreet2",
                        latitute: 46.0,
                        longitute: -37.0,
                        distance: 169,
                        city: "City 2",
                        state: "SP",
                        country: "Country 2"),
                    categories: Categories(
                        category: [
                            {
                                Category(
                                    name: "Restaurant2")
                            }()
                        ])
                )
            }()]
    }
}
