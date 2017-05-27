//
//  SubmenuTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 26/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class SubmenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var flecha: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    static let identifier = "SubmenuTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
