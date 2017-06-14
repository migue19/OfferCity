//
//  ResPeopleTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 13/06/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ResPeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icono: UIImageView!
    @IBOutlet weak var labelDescripcion: UILabel!
    
    @IBOutlet weak var labelMenos: UILabel!
    @IBOutlet weak var labelNumero: UILabel!
    @IBOutlet weak var labelMas: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
