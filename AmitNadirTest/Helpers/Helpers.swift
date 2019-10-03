//
//  Helpers.swift
//  AmitNadirTest
//
//  Created by עמית נדיר on 01/10/2019.
//  Copyright © 2019 AmitLTD. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

let helper = Helpers()

class Helpers {

    func setImage(urlString: String?, imageViewToSet: UIImageView?){
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        if let flagUrl = urlString {
            if flagUrl.count > 0 {
                let imgUrl = URL.init(string: flagUrl)
                imageViewToSet?.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "placeholder"))
            } else {
                imageViewToSet?.image = UIImage.init(named: "placeholder")
            }
        }
    }
}
