//
//  FEZonaTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 23/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class FEZonaTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    static let identifier = "FEZonaTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        // Tranparent Collection View
        
        collectionView.backgroundColor = UIColor.clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension FEZonaTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
    
}
