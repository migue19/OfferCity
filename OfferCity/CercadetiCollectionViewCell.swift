//
//  CercadetiCollectionViewCell.swift
//  OfferCity
//
//  Created by ginppian on 09/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class CercadetiCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var imagFoto: UIImageView!
    @IBOutlet var imagSombra: UIImageView!
    @IBOutlet var labelNombre: UILabel!
    @IBOutlet var imagPin: UIImageView!
    @IBOutlet var labelDireccion: UILabel!
    
    // MARK: - Propertys
    
    static let identifier = "cercadetiCell"
    
}
