//
//  CustomHeaderSectionTableViewCell.swift
//  ProfileTwitter
//
//  Created by Miguel Mexicano Herrera on 10/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class CustomHeaderSectionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
