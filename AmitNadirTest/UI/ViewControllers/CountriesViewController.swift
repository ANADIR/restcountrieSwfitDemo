//
//  ViewController.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var navigationBar: UINavigationItem!
    let cellIdentifier = "CountryTableViewCell"
    let borderedVCIdentifier = "goToBorderedCountriesVC"
    let cellSize : CGFloat = 50
    
    let requestManager : Requests = Requests()
    let provider : DataProvider = DataProvider()
    var countries : [Country] = [] {
        didSet {
            countriesTableView.reloadData()
        }
    }
    var selectedCountries : [Country] = []
    var selectedCountryName = ""
    @IBOutlet var countriesTableView: UITableView! {
        didSet {
            let cell = UINib(nibName: cellIdentifier, bundle: nil)
            countriesTableView.register(cell, forCellReuseIdentifier: cellIdentifier)
            countriesTableView.delegate = self
            countriesTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "All Countries"
        setupData()
    }
    
    func setupData(){
        requestManager.getCountries { data in
            self.countries = data
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell {
            
            let data = countries[indexPath.row] as Country
            cell.countryNameLbl.text = data.name
            helper.setImage(urlString: data.flag, imageViewToSet: cell.flagImageView)

            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CountryTableViewCell
        cell.flagImageView.sd_cancelCurrentImageLoad()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row] as Country
        self.selectedCountryName = selectedCountry.name ?? ""
        let selectedCountriesBorders = selectedCountry.borders as! [String]
        self.selectedCountries = provider.getCountryByCodes(countryCodes: selectedCountriesBorders, countriesArray: self.countries)
        if self.selectedCountries.count > 0 {
            self.performSegue(withIdentifier: self.borderedVCIdentifier, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BorderedCountriesViewController {
            vc.selectedCountries = self.selectedCountries
            vc.selectedCountryName = self.selectedCountryName
            print(vc.selectedCountryName)
        }
    }

}

