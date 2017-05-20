//
//  PromosCollectionViewCell.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PromosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var imagFoto: UIImageView!
    @IBOutlet var imagSombra: UIImageView!
    @IBOutlet var labelPromo: UILabel!
    @IBOutlet var labelFecha: UILabel!
    @IBOutlet var labelCityPoints: UILabel!
    @IBOutlet var imagPin: UIImageView!
    
    // MARK: - Propertys
    
    static let identifier = "promosCell"
    
}
