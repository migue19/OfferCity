//
//  MenuViewController.swift
//  OfferCity
//
//  Created by ginppian on 26/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Propertys
    var tituloTiempo = String()
    
    let arrayMenu = ["ENTRADAS", "PALTO FUERTE", "POSTRES", "BEBIDAS"]
    let arrayImage = [#imageLiteral(resourceName: "entradas"), #imageLiteral(resourceName: "platoFuerte"), #imageLiteral(resourceName: "postres"), #imageLiteral(resourceName: "bebidas")]
    
    // MARK: - Constructor

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

// MARK: - Life Cycle

extension MenuViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Setup navigation bar
        
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
}


// MARK: - Data Source

extension MenuViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        
        return arrayMenu.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
            
            fatalError("Unexpected IndexPath")
        }
        
        // Fill
        
        cell.imagen.image = arrayImage[indexPath.item]
        cell.label.text = arrayMenu[indexPath.item]

        return cell
    }
}

// MARK: - Delegate

extension MenuViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MenuCollectionViewCell
        self.tituloTiempo = cell.label.text!
        
        performSegue(withIdentifier: "menuSubMenu", sender: self)
    }
}

// MARK: - FlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    //Use for size
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height/2
        
        return CGSize(width: width , height: height)

    }
    
    //Use for interspacing
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
//    internal func collectionView(_ collectionView: UICollectionView,
//                                 layout collectionViewLayout: UICollectionViewLayout,
//                                 insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
//    }
}

// MARK: - Navigation Bar

extension MenuViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
}

// MARK: - Navigation

extension MenuViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuSubMenu" {
            
            let vc = segue.destination as! SubMenuViewController
            vc.tituloTiempo = self.tituloTiempo
        }
    }
}




































