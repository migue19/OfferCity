//
//  VDRedesTableViewCell.swift
//  VistaDetallada
//
//  Created by ginppian on 27/04/17.
//  Copyright © 2017 Nut Systems. All rights reserved.
//

import UIKit

class VDRedesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var imagen: UIImageView!
    
    var delegate: RedesSocialesAcercaDelegate!

    
    // MARK: - Constructor
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Actions
    
    @IBAction func button1Actions(_ sender: UIButton) {
        
        self.delegate.abrirRedSocial(index: imagen.tag)
    }
}

extension VDRedesTableViewCell {
    
    func setupCell() {
        
        let color = UIColor(red: 241/255, green: 244/255, blue: 247/255, alpha: 1)
        
        imagen?.superview?.backgroundColor = color
    }
}
