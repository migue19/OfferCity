//
//  ResBirthdayTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 13/06/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ResBirthdayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icono: UIImageView!
    @IBOutlet weak var labelDescripcion: UILabel!
    @IBOutlet weak var labelSi: UILabel!
    @IBOutlet weak var labelNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
