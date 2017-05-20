//
//  VDRedes2TableViewCell.swift
//  
//
//  Created by ginppian on 18/05/17.
//
//

import UIKit

class VDRedes2TableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var imagen1: UIImageView!
    @IBOutlet weak var imagen2: UIImageView!
    
    // MARK: - Constructor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Actions
    
    @IBAction func button1Action(_ sender: UIButton) {
        print("button1")
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        print("button2")
    }
    
}

extension VDRedes2TableViewCell {
    
    func setupCell() {
        
        let color = UIColor(red: 241/255, green: 244/255, blue: 247/255, alpha: 1)
        
        imagen1.superview?.superview?.backgroundColor = color
        
        imagen1.superview?.backgroundColor = color
        imagen2.superview?.backgroundColor = color
    }
}
