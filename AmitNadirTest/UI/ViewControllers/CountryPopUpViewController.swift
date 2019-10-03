//
//  CountryPopUpViewController.swift
//  AmitNadirTest
//
//  Created by Amit on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import MapKit

class CountryPopUpViewController: UIViewController {
    
    @IBOutlet var alertView: CountryAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.blue.withAlphaComponent(0.5)
        self.alertView.delegate = self
    }
    
    func setupView(name: String, capital: String, region: String, subRegion: String, lat: CLLocationDegrees, long: CLLocationDegrees, imageUrl: URL){
        self.alertView.nameLbl.text = name
        self.alertView.capitalLbl.text = capital
        self.alertView.regionLbl.text = region
        self.alertView.subRegionLbl.text = subRegion
        self.alertView.setUpFlagImage(imageUrl: imageUrl)
        self.alertView.setupMap(lat: lat,long: long)
    }
}

extension CountryPopUpViewController : CountryAlertViewCloseDelegate {
    func closeAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}
