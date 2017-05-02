//
//  HomeViewController.swift
//  OfferCity
//
//  Created by ginppian on 01/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//
/*
 Descripcion: Este Controller implementa el pod CarbonKit el cual permite deslizarnos entre views (slide)
 en este caso entre los controllers: CERCA DE TI, EVENTOS Y PROMOCIONES
 los cuales los obtenemos a traves de un ID STORYBOARDS (tiene el mismo nombre que el controller)
 y los agregamos con mediante su protocolo.
 */

import UIKit
import CarbonKit

class HomeViewController: UIViewController, CarbonTabSwipeNavigationDelegate {

    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let items = ["CERCA DE TI", "EVENTOS", "PROMOCIONES"]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        
        self.style()
    }

    func style() {
        let color: UIColor = UIColor(red: 121.0 / 255, green: 148.0 / 255, blue: 180.0 / 255, alpha: 1)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        
        carbonTabSwipeNavigation.setIndicatorColor(color)
        carbonTabSwipeNavigation.setTabExtraWidth(8)
        
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(UIScreen.main.bounds.width/3, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(UIScreen.main.bounds.width/3, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(UIScreen.main.bounds.width/3 + 5, forSegmentAt: 2)
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.black.withAlphaComponent(0.6))
        carbonTabSwipeNavigation.setSelectedColor(color, font: UIFont.boldSystemFont(ofSize: 14))
        
        
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        
        switch index {
        case 0:
            return self.storyboard!.instantiateViewController(withIdentifier: "CercadetiViewController") as! CercadetiViewController
        case 1:
            return self.storyboard!.instantiateViewController(withIdentifier: "EventosViewController") as! EventosViewController
        case 2:
            return self.storyboard!.instantiateViewController(withIdentifier: "PromocionesViewController") as! PromocionesViewController
        default:
            return self.storyboard!.instantiateViewController(withIdentifier: "CercadetiViewController") as! CercadetiViewController
        }
        
        // return viewController at index
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Hide navigation bar
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
