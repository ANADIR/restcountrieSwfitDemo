//
//  BorderedCountriesViewController.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import MapKit

class BorderedCountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var navigationBar: UINavigationItem!
    let cellIdentifier = "CountryTableViewCell"
    var selectedCountryName = ""
    let cellSize : CGFloat = 50
    var selectedCountries : [Country] = []
    @IBOutlet weak var borderedCountriesTableview: UITableView! {
        didSet {
            let cell = UINib(nibName: cellIdentifier, bundle: nil)
            borderedCountriesTableview.register(cell, forCellReuseIdentifier: cellIdentifier)
            borderedCountriesTableview.delegate = self
            borderedCountriesTableview.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "Bordered Countries with \(self.selectedCountryName)"
        borderedCountriesTableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell {
            let data = selectedCountries[indexPath.row] as Country
            cell.countryNameLbl.text = data.name
            helper.setImage(urlString: data.flag, imageViewToSet: cell.flagImageView)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryData = selectedCountries[indexPath.row] as Country
        showPopupFor(country: countryData)
    }
    
    func showPopupFor(country: Country){
        
        let lat : CLLocationDegrees = country.latlng?[0] as? CLLocationDegrees ?? CLLocationDegrees()
        let long : CLLocationDegrees = country.latlng?[1] as? CLLocationDegrees ?? CLLocationDegrees()
        let flagUrl = URL.init(string: country.flag ?? "")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countryAlertVC = storyboard.instantiateViewController(withIdentifier: "CountryPopUpViewController") as! CountryPopUpViewController
    
        countryAlertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        countryAlertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(countryAlertVC, animated: true, completion: nil)

        countryAlertVC.setupView(name: country.name ?? "", capital: country.capital ?? "", region: country.region ?? "", subRegion: country.subregion ?? "", lat: lat, long: long, imageUrl: flagUrl!)
    }
    
}
