//
//  DataProvider.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataProvider: NSObject {
    
    func parseCountries(dataArray: NSArray) -> [Country] {
        let countries : NSMutableArray = []
        
        for object in dataArray {
            let country = parseCountry(data: object as? [String:Any] ?? [:])
            countries.add(country as Any)
        }
        
        return countries as! [Country]
    }
    
    func parseCountry(data: [String:Any]) -> Country?{
        let country : Country = Country()
        
        country.name = data["name"] as? String ?? ""
        country.flag = data["flag"] as? String ?? ""
        country.capital = data["capital"] as? String ?? ""
        country.region = data["region"] as? String ?? ""
        country.subregion = data["subregion"] as? String ?? ""
        country.latlng = data["latlng"] as? NSArray ?? []
        country.borders = data["borders"] as? NSArray ?? []
        country.countryCode = data["cioc"] as? String ?? ""
        
        return country
    }
    
    func getCountryByCodes(countryCodes: [String], countriesArray: [Country]) -> [Country]{
        var countries : [Country] = []
        for countryCode in countryCodes {
            let country = getCountryFromCountries(byCode: countryCode, countriesArray: countriesArray)
            if  country.countryCode != nil{
                countries.append(country)
            }
        }
        return countries
    }
    
    func getCountryFromCountries(byCode: String, countriesArray: [Country]) -> Country{
        for country in countriesArray {
            if country.countryCode == byCode {
                return country
            }
        }
        return Country()
    }
}
