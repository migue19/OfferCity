//
//  CustomInfoWindow.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 21/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var extra: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.width/16
        self.layer.borderColor = UIColor.init(red: 99/255.0, green: 126/255.0, blue: 165/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 3.0
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
