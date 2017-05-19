//
//  VDBotonesTableViewCell.swift
//  VistaDetallada
//
//  Created by ginppian on 27/04/17.
//  Copyright © 2017 Nut Systems. All rights reserved.
//

import UIKit

class VDBotonesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var viewResenas: UIView!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewPromos: UIView!
    
    @IBOutlet weak var labelResenas: UILabel!
    @IBOutlet weak var labelMenu: UILabel!
    @IBOutlet weak var labelPromos: UILabel!
    
    
    // MARK: - Constructor
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    
    @IBAction func resenasAction(_ sender: UIButton) {
        print("Reseñas 👤")
    }
    
    @IBAction func menuAction(_ sender: UIButton) {
        print("Menú 🍕")
    }
    
    @IBAction func promosAction(_ sender: UIButton) {
        print("Promos 🎫")
    }

}

// MARK: - Setup 

extension VDBotonesTableViewCell {
    
    func setupViews(){
        
        viewResenas.superview?.backgroundColor = .white
        viewMenu.superview?.backgroundColor = .white
        viewPromos.superview?.backgroundColor = .white
        
        viewResenas.layer.cornerRadius = 21
        viewMenu.layer.cornerRadius = 21
        viewPromos.layer.cornerRadius = 21
        
        labelResenas.text = "Reseñas"
        labelMenu.text = "Menú"
        labelPromos.text = "Promociones"
        
        labelResenas.textColor = .white
        labelMenu.textColor = .white
        labelPromos.textColor = .white
        
        if UIScreen.main.bounds.width > 320 {
            
            labelResenas.font = UIFont.boldSystemFont(ofSize: 14.0)
            labelMenu.font = UIFont.boldSystemFont(ofSize: 14.0)
            labelPromos.font = UIFont.boldSystemFont(ofSize: 14.0)
            
        } else {
            
            labelResenas.font = UIFont.boldSystemFont(ofSize: 10.0)
            labelMenu.font = UIFont.boldSystemFont(ofSize: 10.0)
            labelPromos.font = UIFont.boldSystemFont(ofSize: 10.0)
        }
        
    }
}


















