//
//  CercadetiViewController.swift
//  OfferCity
//
//  Created by ginppian on 01/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class CercadetiViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Propertys
    
    fileprivate let array = [#imageLiteral(resourceName: "borrar1"), #imageLiteral(resourceName: "borrar2"), #imageLiteral(resourceName: "borrar3"), #imageLiteral(resourceName: "borrar4"), #imageLiteral(resourceName: "borrar5")]
    //fileprivate let array = [UIImage]()

    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupView()
    }

    // MARK: - Setup Views
    
    private func setupView() {
        
        setupMessage()
        updateView()
    }
    
    private func setupMessage() {
        
        imageView.image = #imageLiteral(resourceName: "borrar6")
    }

    private func updateView() {
        
        if array.count > 0 {
        
            imageView.isHidden = true
            
        } else {
            
            collectionView.isHidden = true
        }
    }
    
}

extension CercadetiViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                                numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CercadetiCollectionViewCell.identifier,
                                                      for: indexPath) as! CercadetiCollectionViewCell
        
        cell.imagFoto.image = self.array[indexPath.item]
        cell.imagPin.image = #imageLiteral(resourceName: "borrar7")
        cell.labelNombre.text = "17 ASADOS"
        cell.labelDireccion.text = "Zavaleta"
        
        return cell
    }
}

extension CercadetiViewController: UICollectionViewDelegateFlowLayout {
    
    //Use for size
    
    internal func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = width
        
        return CGSize(width: width , height: height)
    }
    
    //Use for interspacing
    
    internal func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
    }
}







































