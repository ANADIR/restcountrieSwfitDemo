//
//  CountryTableViewCell.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 26/09/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet var flagImageView: UIImageView! 
    @IBOutlet var countryNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = UIImage.init(named: "placeholder")
    }
    
}
