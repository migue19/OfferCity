//
//  SubMenuViewController.swift
//  OfferCity
//
//  Created by ginppian on 26/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class SubMenuViewController: UIViewController {

    // MARK: - Propertys
    
    var tituloTiempo = String()
    var tituloPrecioSubMenu = String()
    
    let arrayPlatillo = ["Capaccio de Res", "Queso Fundido", "Tostadas de atún", "Tacos de pato", "Chalupas", "Ceviche de atún", "Tacoss de marlin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - Lifecycle

extension SubMenuViewController {
    
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

extension SubMenuViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        return arrayPlatillo.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SubmenuTableViewCell.identifier, for: indexPath) as! SubmenuTableViewCell
        
        cell.label.text = arrayPlatillo[indexPath.row]
        
        return cell
    }

}

// MARK: - Delegate

extension SubMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deselect Cell
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.tituloPrecioSubMenu = arrayPlatillo[indexPath.row]
        
        performSegue(withIdentifier: "subMenuPrecioSubMenu", sender: self)
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

extension SubMenuViewController {
    
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

// MARK: - Navigation

extension SubMenuViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subMenuPrecioSubMenu" {
            
            let vc = segue.destination as! PrecioSubMenuViewController
            vc.tituloTiempo = self.tituloPrecioSubMenu

        }
    }
}



