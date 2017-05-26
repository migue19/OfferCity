//
//  FiltroEventosViewController.swift
//  OfferCity
//
//  Created by ginppian on 23/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class FiltroEventosViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonAplicar: UIButton!
    
    // MARK:- Propertys
    
    let arrayZonas = ["Todo", "Angelópolis", "La Paz", "La Juárez", "El Centro", "Cholula"]
    let arrayComida = ["Todo", "Concierto", "Festival", "Stand Up", "Conferencias", "Teatro", "Arte", "Cine"]
    let arrayComidaImage = [#imageLiteral(resourceName: "city"), #imageLiteral(resourceName: "concierto"), #imageLiteral(resourceName: "festival"), #imageLiteral(resourceName: "standup"), #imageLiteral(resourceName: "conferencias"), #imageLiteral(resourceName: "teatro"), #imageLiteral(resourceName: "arte"), #imageLiteral(resourceName: "cine")]

    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    
    @IBAction func buttonCloseAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    
    @IBAction func buttonAplicarAction(_ sender: UIButton) {
        print("Button Aplicar")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    

}

// MARK: - Life Cycle

extension FiltroEventosViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup Navigation Bar
        
        setupNavigationBar()
        
        // Setup Table View
        
        setupTableView()
        
        // Setup Button aplicar
        
        setupButtonAplicar()
    }
}

// MARK: - View

extension FiltroEventosViewController {
    
    func setupTableView() {
        
        // Table View Transparent
        tableView.backgroundColor = UIColor.clear
    
        // Tableview sin linea entre cells
        
        tableView.separatorStyle = .none
    }
    
    func setupButtonAplicar() {
    
        self.buttonAplicar.layer.cornerRadius = 21
    }
}
// MARK: - Table Data Source

extension FiltroEventosViewController: UITableViewDataSource {
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 34
        case 1:
            return 34
        default:
            return 34
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        let newSection = UIView(frame:
            CGRect(x: 0,
                   y: 0,
                   width: tableView.frame.size.width,
                   height: 34))
        
        newSection.backgroundColor = UIColor.clear
        
        let label = UILabel(frame:
            CGRect(x: 0,
                   y: 0,
                   width: newSection.bounds.width,
                   height: newSection.bounds.height))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        newSection.addSubview(label)
        
        switch section {
        case 0:
            label.text = "ZONA"
            return newSection
        case 1:
            label.text = "TIPO DE COMIDA"
            return newSection
        default:
            return UIView()
        }
    }

    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return tableView.dequeueReusableCell(withIdentifier: FEZonaTableViewCell.identifier,
                                                     for: indexPath)
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return tableView.dequeueReusableCell(withIdentifier: FEComidaTableViewCell.identifier,
                                                     for: indexPath)
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // ZONA
                return 144.0
            default:
                return 144.0
            }
        case 1:
            switch indexPath.row {
            case 0: // TIPO DE COMIDA
                return 233.0
            default:
                return 233.0
            }
        default:
            return 233.0
        }
    }
}

// MARK: - Table Delegate

extension FiltroEventosViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                guard let tableViewCell = cell as? FEZonaTableViewCell else { return }
                // Transparent
                cell.backgroundColor = UIColor.clear
                cell.contentView.backgroundColor = UIColor.clear
                tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                guard let tableViewCell = cell as? FEComidaTableViewCell else { return }
                // Transparent
                cell.backgroundColor = UIColor.clear
                cell.contentView.backgroundColor = UIColor.clear
                tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
            default:
                return
            }
        default:
            return
        }
    }
}

// MARK: - Navigation Bar

extension FiltroEventosViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
}

// MARK: - Collection Data Source

extension FiltroEventosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0:
            return arrayZonas.count
        case 1:
            return arrayComida.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FEZonaCollectionViewCell.identifier,
                                                          for: indexPath) as! FEZonaCollectionViewCell
            cell.label.text = arrayZonas[indexPath.item]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FEComidaCollectionViewCell.identifier,
                                                          for: indexPath) as! FEComidaCollectionViewCell
            cell.imagen.image = arrayComidaImage[indexPath.item]
            cell.label.text = arrayComida[indexPath.item]
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
}

// MARK: - Collection Delegate

extension FiltroEventosViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cv: \(collectionView.tag), item: \(indexPath.item)")
        
        
        switch collectionView.tag {
        case 0:
            let cell = collectionView.cellForItem(at: indexPath) as! FEZonaCollectionViewCell
            if cell.tag == 1 {
                cell.tag = 0
                cell.backgroundColor = UIColor.white
                cell.label.textColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
            } else {
                cell.tag = 1
                cell.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
                cell.label.textColor = UIColor.white
            }

        case 1:
            let cell = collectionView.cellForItem(at: indexPath) as! FEComidaCollectionViewCell
            if cell.tag == 1 {
                cell.tag = 0
                cell.imagen.image = arrayComidaImage[indexPath.item]
            } else {
                cell.tag = 1
                cell.imagen.image = #imageLiteral(resourceName: "azulOffer")
            }
        default:
            return
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        // Bordes redondos
        
        cell.layer.cornerRadius = 21
        
        // Size Font Label
        
        switch collectionView.tag {
        case 0:
            let cell = cell as! FEZonaCollectionViewCell
            if UIScreen.main.bounds.width > 320 {
                
                cell.label.font = UIFont.boldSystemFont(ofSize: 14.0)
            } else {
                
                cell.label.font = UIFont.boldSystemFont(ofSize: 10.0)
            }
        case 1:
            let cell = cell as! FEComidaCollectionViewCell
            if UIScreen.main.bounds.width > 320 {
                
                cell.label.font = UIFont.boldSystemFont(ofSize: 14.0)
            } else {
                
                cell.label.font = UIFont.boldSystemFont(ofSize: 10.0)
            }
        default:
            return
        }

    }
    
    // Cell Size
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 3) - 21
        let height = CGFloat(40)
        
        return CGSize(width: width , height: height)
    }
    
    // Line interspacing
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 13
    }
    
    // Spacing between cells
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
    }
    
}

































