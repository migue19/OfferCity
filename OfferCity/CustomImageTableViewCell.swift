//
//  CustomImageTableViewCell.swift
//  ProfileTwitter
//
//  Created by Miguel Mexicano Herrera on 10/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class CustomImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatar.layer.borderWidth = 4
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.cornerRadius = 10
        avatar.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
