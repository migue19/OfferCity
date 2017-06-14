//
//  ReservasViewController.swift
//  OfferCity
//
//  Created by ginppian on 13/06/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class ReservasViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var buttonConfirmar: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    
    @IBAction func confirmarAction(_ sender: UIButton) {
        
        print("Confirmar")
    }
    
    
}

// MARK: - Life Cycle

extension ReservasViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Table View Lines
        
        tableView.separatorStyle = .none
        
        // Hide status bar
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        
        // Setup Button Confirmar
        
        setupButtonConfirmar()
        
        // Correct Frame Table View
        
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -40.0, right: 0.0)

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Show status bar
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
    }
}

// MARK: - Data Source

extension ReservasViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 5
        default:
            return 5
        }

    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
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
        newSection.backgroundColor = UIColor.white
        
        let label = UILabel(frame:
            CGRect(x: 0,
                   y: 0,
                   width: newSection.bounds.width,
                   height: newSection.bounds.height))
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
        label.textAlignment = .center
        
        newSection.addSubview(label)
        
        switch section {
        case 0:
            label.text = "RESERVACIÓN"
            return newSection
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 55.0
            case 1:
                return 55.0
            case 2:
                return 55.0
            case 3:
                return 55.0
            case 4:
                return 55.0
            default:
                return 55.0
            }
        default:
            return 55.0
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResFechaTableViewCell",
                                                         for: indexPath) as! ResFechaTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResHoraTableViewCell",
                                                         for: indexPath) as! ResHoraTableViewCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResPeopleTableViewCell",
                                                         for: indexPath) as! ResPeopleTableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResComentsTableViewCell",
                                                         for: indexPath) as! ResComentsTableViewCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ResBirthdayTableViewCell",
                                                         for: indexPath) as! ResBirthdayTableViewCell
                return cell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        // Change Color
        
        let auxView = UIView()
        auxView.backgroundColor = UIColor(red: 100/255.0,
                                          green: 127/255.0,
                                          blue: 164/255.0,
                                          alpha: 0.3)
        
        cell.selectedBackgroundView = auxView
        
        // Change Border to Corner Radious
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: // Fecha
                (cell as! ResFechaTableViewCell).labelFecha.layer.cornerRadius = 3
                (cell as! ResFechaTableViewCell).labelFecha.layer.masksToBounds = true
                
            case 1: // Hora
                (cell as! ResHoraTableViewCell).labelHora.layer.cornerRadius = 3
                (cell as! ResHoraTableViewCell).labelHora.layer.masksToBounds = true
                
            case 2: // People
                (cell as! ResPeopleTableViewCell).labelMenos.layer.cornerRadius = 3
                (cell as! ResPeopleTableViewCell).labelMenos.layer.masksToBounds = true
                
                (cell as! ResPeopleTableViewCell).labelNumero.layer.cornerRadius = 3
                (cell as! ResPeopleTableViewCell).labelNumero.layer.masksToBounds = true
                
                (cell as! ResPeopleTableViewCell).labelMas.layer.cornerRadius = 3
                (cell as! ResPeopleTableViewCell).labelMas.layer.masksToBounds = true
                
            case 3: // Comentarios
                (cell as! ResComentsTableViewCell).labelAnadir.layer.cornerRadius = 21
                (cell as! ResComentsTableViewCell).labelAnadir.layer.masksToBounds = true
                
            case 4: // Birthday
                (cell as! ResBirthdayTableViewCell).labelSi.layer.cornerRadius = 3
                (cell as! ResBirthdayTableViewCell).labelSi.layer.masksToBounds = true
                
                (cell as! ResBirthdayTableViewCell).labelNo.layer.cornerRadius = 3
                (cell as! ResBirthdayTableViewCell).labelNo.layer.masksToBounds = true
                
            default:
                break
            }
        default:
            break
        }
        
    }
    
}

// MARK: - Delegate

extension ReservasViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        // Deselect
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}

// MARK: - View

extension ReservasViewController {
    
    func setupButtonConfirmar() {
        
        self.buttonConfirmar.layer.cornerRadius = 21
    }
}

