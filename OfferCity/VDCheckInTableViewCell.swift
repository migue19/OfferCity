//
//  VDCheckInTableViewCell.swift
//  VistaDetallada
//
//  Created by ginppian on 27/04/17.
//  Copyright © 2017 Nut Systems. All rights reserved.
//

import UIKit
import BEMCheckBox

class VDCheckInTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var checkbox: BEMCheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupCheckbox()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Setup

extension VDCheckInTableViewCell {
    
    func setupCheckbox() {
        
        checkbox.on = true
        
//        checkbox.onFillColor = .blue
//        checkbox.tintColor = .red
//        checkbox.onTintColor = .green
//        checkbox.onCheckColor = .yellow

                checkbox.onFillColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
                checkbox.tintColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
                checkbox.onTintColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
                checkbox.onCheckColor = .white

        
        checkbox.onAnimationType = .fill
        checkbox.offAnimationType = .fill
        
        // Delegate
        checkbox.delegate = self
    }
}

// MARK: - Delegate

extension VDCheckInTableViewCell: BEMCheckBoxDelegate {
    
    public func didTap(_ checkBox: BEMCheckBox) {
        
        print("Tap...")
    }
    public func animationDidStop(for checkBox: BEMCheckBox) {
        
        print("End tapping")
    }
}
