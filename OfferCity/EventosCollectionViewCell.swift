//
//  EventosCollectionViewCell.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class EventosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var imagFoto: UIImageView!
    @IBOutlet var imagSombra: UIImageView!
    @IBOutlet var labelEvento: UILabel!
    @IBOutlet var labelFecha: UILabel!
    @IBOutlet var labelUbicacion: UILabel!
    @IBOutlet var imagPin: UIImageView!
    @IBOutlet var imagFecha: UIImageView!
    @IBOutlet var labelPrecio: UILabel!
    @IBOutlet weak var viewPrecio: UIView!
    
    // MARK: - Propertys
    
    static let identifier = "eventosCell"

}
