//
//  ResenasViewController.swift
//  OfferCity
//
//  Created by ginppian on 24/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ResenasViewController: UIViewController {
    
    // Propertys
    
    let arrayNombre = ["Miguel López", "Alejandra Nuño", "Victor Hernández", "Fany Ramos", "Alma Cano"]
    let arrayFecha = ["15/03/2017", "01/04/2017", "21/12/2016", "08/10/2016", "06/29/2016"]
    let arrayTitulo = ["Bueno", "Servicio estupendo", "¡Muy bueno!", "Cool 👍🏻", "the best 😎"]
    let arrayDescripcion = ["Me gusto el postre", "Nos atendieron rápido", "Sabia bien 🍕", "Volvería a ir", "Buenas platicas 🙋"]
    let arrayRating = [4.0, 4.5, 5.0, 3.5, 4.0]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - Life Cycle

extension ResenasViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Setup navigation bar
        
        setupNavigationBar()
        
        // Setup barbutton right
        
        setupRightBarButtonItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
}

// MARK: - View 

extension ResenasViewController {
    
    
}

// MARK: - Data Source

extension ResenasViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        return arrayNombre.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResenasTableViewCell.identifier,
                                                 for: indexPath) as! ResenasTableViewCell
        
        cell.nombre.text = arrayNombre[indexPath.row]
        cell.fecha.text = arrayFecha[indexPath.row]
        cell.titulo.text = arrayTitulo[indexPath.row]
        cell.descripcion.text = arrayDescripcion[indexPath.row]
        cell.floatRating.rating = Float(arrayRating[indexPath.row])
        
        return cell
    }
    
}

// MARK: - Delegate

extension ResenasViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 144
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
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
}

// MARK: - Navigation Bar

extension ResenasViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
    
    func setupRightBarButtonItem() {
        
        let newBbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "addResena"), target: self, action: #selector(ResenasViewController.agregarResena))
        self.navigationItem.rightBarButtonItem = newBbi
    }
    
    func agregarResena() {
        
        performSegue(withIdentifier: "resenaAgregarResena", sender: self)
    }
}


