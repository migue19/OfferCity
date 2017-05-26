//
//  PrecioSubMenuTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 26/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PrecioSubMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelPrecio: UILabel!
    
    static let identifier = "PrecioSubMenuViewController"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
