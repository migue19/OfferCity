//
//  ResComentsTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 13/06/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ResComentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icono: UIImageView!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var labelAnadir: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        labelAnadir.layer.cornerRadius = 21
//        labelAnadir.layer.masksToBounds = true
//        labelAnadir.layer.backgroundColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
