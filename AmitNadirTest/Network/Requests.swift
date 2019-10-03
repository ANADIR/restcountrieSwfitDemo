//
//  requests.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Requests : NSObject{
    
    private let kGetAllCountriesUrl = "https://restcountries.eu/rest/v2/all"
    let dataProvider : DataProvider = DataProvider()
    
    func getCountries(completion:@escaping([Country]) -> Void) {
        Alamofire.request(kGetAllCountriesUrl, method: .get, encoding: JSONEncoding.default)
        .responseJSON { response in
            switch response.result {
                case .success(let json):
                    DispatchQueue.main.async {
                        let jsonToParse = json as? NSArray ?? []
                        let countries = self.dataProvider.parseCountries(dataArray: jsonToParse)
                        completion(countries)
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}
