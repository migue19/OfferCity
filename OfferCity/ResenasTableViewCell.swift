//
//  ResenasTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 24/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ResenasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var floatRating: FloatRatingView!
    
    static let identifier = "ResenasTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFloatRating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

// MARK: - Load FloatRatingView

extension ResenasTableViewCell {
    
    func setupFloatRating() {
        
        // Load Image
        
        floatRating.emptyImage = #imageLiteral(resourceName: "emptyStar")
        floatRating.fullImage = #imageLiteral(resourceName: "fullStar")
        
        // Delegate
        
        floatRating.delegate = self
        
        // Settings
        
        self.floatRating.backgroundColor = UIColor.white
        self.floatRating.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRating.maxRating = 5
        self.floatRating.minRating = 1
        self.floatRating.rating = 2.5
        self.floatRating.editable = false
        self.floatRating.halfRatings = true
        self.floatRating.floatRatings = false
    }
    
}

// MARK: Delegate FloatRatingView

extension ResenasTableViewCell: FloatRatingViewDelegate {
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        let newRating = NSString(format: "%.2f", self.floatRating.rating) as String
        print(newRating)
        print("🐔")
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        let rating = NSString(format: "%.2f", self.floatRating.rating) as String
        print(rating)
        print("🐶")
    }
    
}
