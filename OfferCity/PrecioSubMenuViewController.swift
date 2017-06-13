//
//  PrecioSubMenuViewController.swift
//  OfferCity
//
//  Created by ginppian on 26/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PrecioSubMenuViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Propertys
    
    let arrayTamano = ["Chicoo", "Mediano", "Grande"]
    let arrayPrecio = ["$55.00", "$65.00", "$75.00"]
    
    var tituloTiempo = String()
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - Lifecycle

extension PrecioSubMenuViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Setup navigation bar
        
        setupNavigationBar()
        
        // Setup title
        
        setupTitle()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
    
}

// MARK: - Data Source

extension PrecioSubMenuViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        return arrayTamano.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PrecioSubMenuTableViewCell.identifier, for: indexPath) as! PrecioSubMenuTableViewCell
        
        cell.labelNombre.text = arrayTamano[indexPath.row]
        cell.labelPrecio.text = arrayPrecio[indexPath.row]
        
        return cell
    }
    
}

// MARK: - Delegate

extension PrecioSubMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect Cell
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        let auxView = UIView()
        auxView.backgroundColor = UIColor(red: 100/255.0,
                                          green: 127/255.0,
                                          blue: 164/255.0,
                                          alpha: 0.3)
        
        cell.selectedBackgroundView = auxView
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}

// MARK: - Navigation Bar

extension PrecioSubMenuViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
    
    func setupTitle() {
        
        self.title = self.tituloTiempo
        
    }
}
