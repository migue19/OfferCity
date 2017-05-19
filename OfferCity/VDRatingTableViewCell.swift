//
//  VDRatingTableViewCell.swift
//  VistaDetallada
//
//  Created by ginppian on 27/04/17.
//  Copyright © 2017 Nut Systems. All rights reserved.
//

import UIKit

class VDRatingTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var floatRatingView: FloatRatingView!
    
    // MARK: - Constructor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFloatRating()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

// MARK: - Load FloatRatingView

extension VDRatingTableViewCell {
    
    func setupFloatRating() {
        
        // Load Image
        
        floatRatingView.emptyImage = #imageLiteral(resourceName: "emptyStar")
        floatRatingView.fullImage = #imageLiteral(resourceName: "fullStar")
        
        // Delegate
        
        floatRatingView.delegate = self
        
        // Settings
        
        self.floatRatingView.backgroundColor = UIColor.white
        self.floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 2.5
        self.floatRatingView.editable = false
        self.floatRatingView.halfRatings = true
        self.floatRatingView.floatRatings = false
    }
    
}

// MARK: Delegate FloatRatingView

extension VDRatingTableViewCell: FloatRatingViewDelegate {
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        let newRating = NSString(format: "%.2f", self.floatRatingView.rating) as String
        print(newRating)
        print("🐔")
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        let rating = NSString(format: "%.2f", self.floatRatingView.rating) as String
        print(rating)
        print("🐶")
    }
    
}
