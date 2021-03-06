//
//  DetalladaPromosViewController.swift
//  OfferCity
//
//  Created by ginppian on 19/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import ImageSlideshow
import GoogleMaps

class DetalladaPromosViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var contentDescripSlideshow: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonUsar: UIButton!
    
    // MARK: - Propertys

    var imageFromCellToDetall: UIImage!
    var localSource = [ImageSource]()
    
    // MARK: - Constructor

    override func viewDidLoad() {
        super.viewDidLoad()

        loadImageForSlideShow()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        // Change heigh slideshow
        
        slideshow.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height/2.2)
        
        // Setup slideshow
        
        setupSlideShow()
        
        // Setup navigation bar
        
        setupNavigationBar()
        
        // Sin linea entre cells
        
        tableView.separatorStyle = .none
        
        // Setup Button Usar
        
        setupButtonUsar()
        
    }

    @IBAction func buttonUsarAction(_ sender: UIButton) {
        print("boton usar")
    }
}

// MARK: - Vista

extension DetalladaPromosViewController {
    
    func setupButtonUsar() {
        
        self.buttonUsar.layer.cornerRadius = 21
        self.buttonUsar.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))
        self.buttonUsar.titleLabel?.text = "USAR"
        self.buttonUsar.tintColor = UIColor.white

    }
}

// MARK: - Delegate

extension DetalladaPromosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        case 0:
            switch indexPath.row {
            case 0: // DESCRIPCION

                return false
            case 1: // ESTABLECIMIENTO

                return true
            default:
                return true
            }
        case 1: // MAPA
            return false
        default:
            return true
        }
    }
}

// MARK: - Datasource

extension DetalladaPromosViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 3
        }
        
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
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
            case 0: // DESCRIPCION
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDPDescripcionTableViewCell", for: indexPath) as! VDPDescripcionTableViewCell
                return cell
            case 1: // ESTABLECIMIENTO
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDPEstablecimientoTableViewCell", for: indexPath) as! VDPEstablecimientoTableViewCell
                return cell
            default:
                return UITableViewCell()
            }
        case 1: // MAPA
            let cell = tableView.dequeueReusableCell(withIdentifier: "VDPMapasTableViewCell", for: indexPath) as! VDPMapasTableViewCell
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
            case 1: // ESTABLECIMIENTO
                return 55.0
            default: // DEFAULT
                return 55.0
            }
            
        case 1:
            switch indexPath.row {
                
            case 0: // MAPA
                return 144.0
            default:
                return 144.0
            }
        default:
            return 55.0
        }
    }

}

// MARK: - SlideShow Pod

extension DetalladaPromosViewController {
    
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
        
        // Add Gesture
        
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(DetalladaAcercaViewController.didTap))
        
        self.slideshow.addGestureRecognizer(recognizer)
        
        // Add view
        
        putSlideshowHerarchiTop()
    }
    
    func putSlideshowHerarchiTop() {
        
        self.contentDescripSlideshow.layer.zPosition = 1000
    }
    
    func didTap() {
        
        slideshow.presentFullScreenController(from: self)
    }
    
    func loadImageForSlideShow() {
        
        // Array image
        
        self.localSource = [ImageSource(image: self.imageFromCellToDetall), ImageSource(image: #imageLiteral(resourceName: "borrar1"))]
        
        // Load Images in slideshow
        
        self.slideshow.setImageInputs(self.localSource)
        
    }
    
}

// MARK: - Bar Button Item

extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 21.0, height: 21.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

// MARK: - Navigation Bar Storyboard

extension DetalladaPromosViewController {
    
    func setupNavigationBar() {
        
        translucedNavigationBar()
        setupLeftBarButtonItemWithImage()
        setupRighttBarButtonItem()
    }
    
    func translucedNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
    }
    
}


// MARK: - Navigation Bar Programatically

extension DetalladaPromosViewController {
    
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
    
}

// MARK: - Scroll

extension DetalladaPromosViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= (slideshow.bounds.height-50) {
            
            print("white")
            leftBarButtonWhite()
            rightBarButtonAzul()
        } else {
            
            print("azul")
            leftBarButtonAzul()
            rightBarButtonWhite()
        }
    }
}

// MARK: - Bar Button Item Left

extension DetalladaPromosViewController {
    
    func setupLeftBarButtonItemWithImage() {
        
        let newBbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "backWhite"), target: self, action: #selector(DetalladaAcercaViewController.close))
        self.navigationItem.leftBarButtonItem = newBbi
    }
    
    func close() {
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    
    func leftBarButtonAzul() {
        
        let nbbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "backWhite"),
                                            target: self,
                                            action: #selector(DetalladaAcercaViewController.close))
        
        navigationItem.leftBarButtonItem = nbbi
    }
    
    func leftBarButtonWhite() {
        
        let nbbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "backBlue"),
                                            target: self,
                                            action: #selector(DetalladaAcercaViewController.close))
        
        navigationItem.leftBarButtonItem = nbbi
    }
    
}

// MARK: - Bar Button Item Right

extension DetalladaPromosViewController {
    
    func setupRighttBarButtonItem() {
        
        let buttonItem = UIBarButtonItem(title: "Compartir",
                                         style: .plain,
                                         target: self,
                                         action: #selector(DetalladaAcercaViewController.compartir))
        
        
        buttonItem.setTitleTextAttributes([
            NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightHeavy),
            NSForegroundColorAttributeName : UIColor.white],
                                          for: .normal)
        
        
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    func rightBarButtonWhite() {
        
        let buttonItem = UIBarButtonItem(title: "Compartir",
                                         style: .plain,
                                         target: self,
                                         action: #selector(DetalladaAcercaViewController.compartir))
        
        
        buttonItem.setTitleTextAttributes([
            NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightHeavy),
            NSForegroundColorAttributeName : UIColor.white],
                                          for: .normal)
        
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    func rightBarButtonAzul() {
        
        let buttonItem = UIBarButtonItem(title: "Compartir",
                                         style: .plain,
                                         target: self,
                                         action: #selector(DetalladaAcercaViewController.compartir))
        
        
        buttonItem.setTitleTextAttributes([
            NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightHeavy),
            NSForegroundColorAttributeName : UIColor(patternImage: #imageLiteral(resourceName: "azulOffer"))],
                                          for: .normal)
        
        navigationItem.rightBarButtonItem = buttonItem
    }
    
    func compartir() {
        print("Compartir")
        
        displayShareSheet(shareContent: "Descubre los mejores Restaurantes con Offer City")
        
    }
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
}
