//
//  EventosViewController.swift
//  OfferCity
//
//  Created by ginppian on 01/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class EventosViewController: UIViewController {
    
    // MARK: - Propertys
    var imageFromCellToDetall: UIImage!
    
    let arrayImage = [#imageLiteral(resourceName: "borrarEvento1"), #imageLiteral(resourceName: "borrarEvento2"), #imageLiteral(resourceName: "borrarEvento3"), #imageLiteral(resourceName: "borrarEvento4")]
    let arrayEvento = ["Marc Anthony ", "LOS ANGELES AZULES", "Mijares", "Sofía Niño de Rivera"]
    let arrayFecha = ["16 de mayo", "26 DE MAYO", "24 junio", "15 de junio"]
    let arrayUbicacion = ["Complejo cultural universitario", "Auditorio metropolitano", "Auditorio del C.C.U.", "Auditorio del C.C.U."]
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventosDetalladaEventos" {
            
            let vc = segue.destination as! DetalladaEventosViewController
            
            if self.imageFromCellToDetall == nil {
                
                vc.imageFromCellToDetall = #imageLiteral(resourceName: "placeholder")
            } else {
                
                vc.imageFromCellToDetall = self.imageFromCellToDetall
            }
            
        }
    }

}

// MARK: - Data Source

extension EventosViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return arrayImage.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventosCollectionViewCell.identifier, for: indexPath) as! EventosCollectionViewCell

        
        cell.imagFoto.image = arrayImage[indexPath.item]
        cell.labelEvento.text = arrayEvento[indexPath.item]
        cell.labelFecha.text = arrayFecha[indexPath.item]
        cell.labelUbicacion.text = arrayUbicacion[indexPath.item]
        
        return cell
    }
    
}

// MARK: - Delegate

extension EventosViewController {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        let cell = collectionView.cellForItem(at: indexPath) as! EventosCollectionViewCell
        self.imageFromCellToDetall = cell.imagFoto.image
        
        performSegue(withIdentifier: "eventosDetalladaEventos", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        let newCell = cell as! EventosCollectionViewCell
        
        newCell.viewPrecio.layer.shadowColor = UIColor.lightGray.cgColor
        newCell.viewPrecio.layer.shadowOffset = CGSize(width: 5.0, height: 3.0)
        newCell.viewPrecio.layer.shadowRadius = 5
        newCell.viewPrecio.layer.shadowOpacity = 0.8
    }
}

// MARK: - FlowLayOut

extension EventosViewController: UICollectionViewDelegateFlowLayout {
    
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
