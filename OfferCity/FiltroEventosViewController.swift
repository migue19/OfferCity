//
//  FiltroEventosViewController.swift
//  OfferCity
//
//  Created by ginppian on 23/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class FiltroEventosViewController: UIViewController {

    // MARK:- Propertys
    
    @IBOutlet weak var buttonClose: UIButton!
    
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

}

// MARK: - Life Cycle

extension FiltroEventosViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup Navigation Bar
        
        setupNavigationBar()
    }
}

// MARK: Navigation Bar

extension FiltroEventosViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
}
