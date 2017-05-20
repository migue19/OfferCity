//
//  DetalladaEventosViewController.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetalladaEventosViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var contentDescripSlideshow: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonComprar: UIButton!
    
    // MARK: - Propertys
    
    var imageFromCellToDetall: UIImage!
    var localSource = [ImageSource]()
    
    let arrayRedes = ["twitter", "facebook", "instagram", "web"]
    //    let arrayRedes = ["twitter", "facebook", "instagram"]
    //    let arrayRedes = ["twitter", "facebook"]
    //    let arrayRedes = ["twitter"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNavBarTransluced()
        
        loadImageForSlideShow()
        setupSlideShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Change heigh slideshow
        
        slideshow.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height/2.2)
        
        // Sin linea entre cells
        
        tableView.separatorStyle = .none
        
        // Button Comprar
        
        self.buttonComprar.layer.cornerRadius = 21
        self.buttonComprar.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
        self.buttonComprar.titleLabel?.text = "COMPRAR2"
        self.buttonComprar.tintColor = UIColor.white
    }
    
    
    @IBAction func buttonComprarAction(_ sender: UIButton) {
        print("buttonComprarAction")
    }
    

}

// MARK: - Delegate 

extension DetalladaEventosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        // Deselect Cell
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Print
        
        print("Section : \(indexPath.section), Row: \(indexPath.row)")
    
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
    
    public func tableView(_ tableView: UITableView,
                          shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        switch indexPath.section {
            
        case 0: // SECTION
            switch indexPath.row {
                
            case 0: // DESCRIPCION
                return false
            case 1: // TELEFONO
                return true
            case 2: // HORA
                return false
            default:
                return true
            }
            
        case 1: // SECTION
            switch indexPath.row {
                
            case 0: // REDES SCIALES
                return false
            default:
                return true
            }
            
        case 2: // SECTION
            switch indexPath.row {
                
            case 0: // MAPAS
                return false
            default:
                return true
            }
            
        default:
            return true
        }
    }
}

// MARK: - Datasource

extension DetalladaEventosViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 5
        }
        
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 34
        case 2:
            return 34
        default:
            return 0
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
        case 1:
            label.text = "REDES SOCIALES"
            return newSection
        case 2:
            label.text = "LOCALIZACIÓN"
            return newSection
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDEDescripcionTableViewCell", for: indexPath) as! VDEDescripcionTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDETelefonoTableViewCell", for: indexPath) as! VDETelefonoTableViewCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDEHoraTableViewCell", for: indexPath) as! VDEHoraTableViewCell
                return cell
            default:
                return UITableViewCell()
            }
        case 1: // REDES
            switch self.arrayRedes.count {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDERedesTableViewCell", for: indexPath) as! VDERedesTableViewCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDERedes2TableViewCell", for: indexPath) as! VDERedes2TableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDERedes3TableViewCell", for: indexPath) as! VDERedes3TableViewCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDERedes4TableViewCell", for: indexPath) as! VDERedes4TableViewCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedesTableViewCell", for: indexPath) as! VDRedesTableViewCell
                return cell
            }
        case 2: // MAPA
            let cell = tableView.dequeueReusableCell(withIdentifier: "VDEMapaTableViewCell", for: indexPath) as! VDEMapaTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                
            case 0: // DESCRIPCION
                return 144.0
            case 1: // TELEFONO
                return 55.0
            case 2: // HORA
                return 55.0
            default: // DEFAULT
                return 55.0
            }
            
        case 1:
            switch indexPath.row {
                
            case 0: // REDES SOCIALES
                return 55.0
            default: // DEFAULT
                return 55.0
            }
            
        case 2:
            switch indexPath.row {
                
            case 0: // MAPAS
                return 144.0
            default: // DEFAULT
                return 55.0
            }
        default:
            return 55.0
        }
    }

}

// MARK: - SlideShow Pod

extension DetalladaEventosViewController {
    
    func setupSlideShow() {
        
        // Settings
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.insideScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.white
        slideshow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // Load Images
        
        self.slideshow.setImageInputs(self.localSource)
        
        // Add Gesture
        
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(DetalladaAcercaViewController.didTap))
        
        self.slideshow.addGestureRecognizer(recognizer)
        
        // Add view
        
        descriptionSlideshow()
    }
    
    func descriptionSlideshow() {
        
        self.contentDescripSlideshow.layer.zPosition = 1000
    }
    
    func didTap() {
        
        slideshow.presentFullScreenController(from: self)
    }
    
    func loadImageForSlideShow() {
        
        self.localSource = [ImageSource(image: self.imageFromCellToDetall), ImageSource(image: #imageLiteral(resourceName: "borrar1"))]
    }
    
}

// MARK: - Navigation Bar

extension DetalladaEventosViewController {
    
    func setNavigationBar() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(DetalladaAcercaViewController.done))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func done() {
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    
    func getNavBarTransluced() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(DetalladaAcercaViewController.done))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        
        //navBar.setBackgroundImage(#imageLiteral(resourceName: "borrarBar"), for: .default)
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        //navBar.isTranslucent = true
        
        navBar.tintColor = .white
        
        self.view.addSubview(navBar)
    }
    
    func translucedNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
    }

}
