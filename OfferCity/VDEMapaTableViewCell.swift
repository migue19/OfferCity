//
//  VDEMapaTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class VDEMapaTableViewCell: UITableViewCell {
    
    
    
    static let identifier = "VDEMapaTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        print("Clicked...")
    }
}
