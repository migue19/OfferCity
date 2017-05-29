//
//  PromocionesUsadasViewController.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 28/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

struct promocion {
    let image: UIImage!
    let titulo: String!
    let descripcion: String!
    let fecha: String!
}


class PromocionesUsadasViewController: UIViewController {
    var promociones = [promocion]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = " "
        
        promociones = [promocion(image: #imageLiteral(resourceName: "Perfil_iconos-3"), titulo: "2X1 en Hamburguesas", descripcion: "BURGER CORNER", fecha: "19/02/2017"), promocion(image: #imageLiteral(resourceName: "Perfil_iconos-3"), titulo: "10% total en la Cuenta", descripcion: "17 ASADOS", fecha: "25/03/2017")]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PromocionesUsadasViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

}

extension PromocionesUsadasViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promociones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = Bundle.main.loadNibNamed("PromocionesTableViewCell", owner: self, options: nil)?.first as! PromocionesTableViewCell
        let indice = indexPath.row
        
        cell.titulo.text = promociones[indice].titulo
        cell.imagen.image = promociones[indice].image
        cell.descripcion.text = promociones[indice].descripcion
        cell.fecha.text = promociones[indice].fecha
        //cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    
}

