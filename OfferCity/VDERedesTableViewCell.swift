//
//  VDERedesTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class VDERedesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var delegate: RedesSocialesEventosDelegate!
    static let identifier = "VDERedesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        
        self.delegate.abrirRedSocial(index: imagen.tag)
    }
}

extension VDERedesTableViewCell {
    
    func setupCell() {
        
        let color = UIColor(red: 241/255, green: 244/255, blue: 247/255, alpha: 1)
                
        imagen.superview?.backgroundColor = color
    }
}
