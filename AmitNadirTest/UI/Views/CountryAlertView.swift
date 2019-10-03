//
//  CountryAlertView.swift
//  AmitNadirTest
//
//  Created by Amit on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
import SDWebImageSVGCoder

class CountryAlertView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var capitalLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var subRegionLbl: UILabel!
    @IBOutlet weak var countryMapView: MKMapView!
    var delegate : CountryAlertViewCloseDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        Bundle.main.loadNibNamed("CountryAlertView", owner: self, options: nil)
        self.addSubview(self.contentView);
    }
    
    func setUpFlagImage(imageUrl: URL){
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        countryFlagImageView?.sd_setImage(with: imageUrl)
    }

    func setupMap(lat: CLLocationDegrees, long: CLLocationDegrees){
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: location, span: span)
        countryMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.nameLbl.text
        countryMapView.addAnnotation(annotation)
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        delegate?.closeAlert()
    }
    
}

protocol CountryAlertViewCloseDelegate{
    func closeAlert()
}
