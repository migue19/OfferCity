//
//  VDERedes3TableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class VDERedes3TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagen1: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    @IBOutlet weak var imagen3: UIImageView!
    
    var delegate: RedesSocialesEventosDelegate!
    static let identifier = "VDERedes3TableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func button1Action(_ sender: UIButton) {
        
        self.delegate.abrirRedSocial(index: imagen1.tag)
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        
        self.delegate.abrirRedSocial(index: imagen2.tag)
    }
    
    @IBAction func button3Action(_ sender: UIButton) {
        
        self.delegate.abrirRedSocial(index: imagen3.tag)
    }

}

extension VDERedes3TableViewCell {
    
    func setupCell() {
        
        let color = UIColor(red: 241/255, green: 244/255, blue: 247/255, alpha: 1)
        
        imagen1.superview?.superview?.backgroundColor = color

        imagen1.superview?.backgroundColor = color
        imagen2.superview?.backgroundColor = color
        imagen3.superview?.backgroundColor = color
        
    }
}
