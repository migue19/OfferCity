//
//  VDPEstablecimientoTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 23/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class VDPEstablecimientoTableViewCell: UITableViewCell {

    static let identifier = "VDPEstablecimientoTableViewCell"
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
