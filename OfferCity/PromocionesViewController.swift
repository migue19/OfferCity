//
//  PromocionesViewController.swift
//  OfferCity
//
//  Created by ginppian on 01/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PromocionesViewController: UIViewController {
    
    // MARK: - Propertys
    
    let arrayImage = [#imageLiteral(resourceName: "borrarPromo1"), #imageLiteral(resourceName: "borrarPromo2"), #imageLiteral(resourceName: "borrarPromo3"), #imageLiteral(resourceName: "borrarPromo4")]
    let arrayPromo = ["VILLA RICA", "THE TAVERN", "LOS PESCADORES", "VALENTINA"]
    let arrayFecha = ["¡TODOS LOS DIAS!", "MARTES Y JUEVES", "DE JUEVES A DOMINGO", "DE LUNES A VIERNES"]
    
    var imageFromCellToDetall: UIImage!

    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PromocionesDetalladaPromos" {
            
            let nav = segue.destination as? UINavigationController
            let vc = nav?.topViewController as? DetalladaPromosViewController
            
            //let vc = segue.destination as! DetalladaAcercaViewController
            if self.imageFromCellToDetall == nil {
                
                vc?.imageFromCellToDetall = #imageLiteral(resourceName: "placeholder")
            } else {
                
                vc?.imageFromCellToDetall = self.imageFromCellToDetall
            }
            
        }
    }
}

// MARK: - Life Cycle

extension PromocionesViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        // Setup Navigation Bar
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
}

// MARK: - Data Source

extension PromocionesViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return arrayImage.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromosCollectionViewCell.identifier,
                                                      for: indexPath) as! PromosCollectionViewCell
        
        cell.imagFoto.image = arrayImage[indexPath.item]
        cell.labelPromo.text = arrayPromo[indexPath.item]
        cell.labelFecha.text = arrayFecha[indexPath.item]
        cell.labelCityPoints.text = "80"
        
        return cell
    }
    
}

// MARK: - Delegate

extension PromocionesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! PromosCollectionViewCell
        self.imageFromCellToDetall = cell.imagFoto.image
        
        performSegue(withIdentifier: "PromocionesDetalladaPromos", sender: self)
    }
}

// MARK: - FlowLayOut

extension PromocionesViewController: UICollectionViewDelegateFlowLayout {
    
    //Use for size
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = width
        
        return CGSize(width: width , height: height+55)
        
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
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Navigation Bar

extension PromocionesViewController {


    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
}
