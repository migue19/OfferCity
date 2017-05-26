//
//  DetalladaAcercaViewController.swift
//  OfferCity
//
//  Created by ginppian on 17/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import ImageSlideshow
import GoogleMaps

class DetalladaAcercaViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentDescripSlideshow: UIView!
    @IBOutlet weak var contentButtonReservar: UIView!
    @IBOutlet weak var labelReservar: UILabel!
    
    // MARK: - Propertys
    
    var imageFromCellToDetall: UIImage!
    var localSource = [ImageSource]()
    
    // ⚠️ arrayOrdenRedes y arrayRedes deben coincidir
    // ya que el primero se usa para posiciona la imagen
    // y el segundo envia la informacion del link al web view
    // la cantidad puede ser de 1 red social a 4 (3 redes sociales mas web)
    
//    let arrayOrdenRedes = ["f", "i", "w", "t"]
//    
//    let arrayRedes = ["https://www.facebook.com/",
//                      "https://www.instagram.com/",
//                      "http://offercity.mx/",
//                      "https://twitter.com/"]
    
    let arrayOrdenRedes = ["t", "f", "i", "w"]

    let arrayRedes = ["https://twitter.com/",
                      "https://www.facebook.com/",
                      "https://www.instagram.com/",
                      "http://offercity.mx/"]
    
    var enlace = "http://offercity.mx/"
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageForSlideShow()
    }
    
    // MARK: - Actions
    
    @IBAction func buttonReservarAction(_ sender: UIButton) {
        print("Button Reservar")
    }
    
}

// MARK: - Lifecycle

extension DetalladaAcercaViewController {

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
        
        // Tableview sin linea entre cells
        
        tableView.separatorStyle = .none
        
        // Setup Button Reservar
        
        setupButtonReservar()
        
    }
    
}


// MARK: - Vista

extension DetalladaAcercaViewController {
    
    func setupButtonReservar() {
        
        contentButtonReservar.layer.cornerRadius = 21
        labelReservar.text = "RESERVAR"
        
        // iPhone SE or iPhone 7
        
        if UIScreen.main.bounds.width > 320 {
            
            labelReservar.font = UIFont.boldSystemFont(ofSize: 14.0)
        } else {
            
            labelReservar.font = UIFont.boldSystemFont(ofSize: 10.0)
        }
    }
}

// MARK: - Data Source

extension DetalladaAcercaViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 6
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 8
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRatingTableViewCell", for: indexPath) as! VDRatingTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDCheckInTableViewCell", for: indexPath) as! VDCheckInTableViewCell
                  cell.parentViewController = self
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDDescripcionTableViewCell", for: indexPath) as! VDDescripcionTableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDTelefonoTableViewCell", for: indexPath) as! VDTelefonoTableViewCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDHoraTableViewCell", for: indexPath) as! VDHoraTableViewCell
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDBotonesTableViewCell", for: indexPath) as! VDBotonesTableViewCell
                return cell
            default:
                return UITableViewCell()
            }
        case 1: // REDES
            switch self.arrayRedes.count {
            case 1:
                
                // Obtenemos celda
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedesTableViewCell", for: indexPath) as! VDRedesTableViewCell
                
                // Cargamos imagen
                switch self.arrayOrdenRedes[0] {
                case "t":
                    cell.imagen.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen.image = #imageLiteral(resourceName: "web")
                }
                
                // Indice de la red en arrayRedes que tomara
                cell.button1.tag = 1
                cell.button1.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                
                return cell
            case 2:
                
                // Obtenemos celda
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedes2TableViewCell", for: indexPath) as! VDRedes2TableViewCell
               
                // Cargamos imagen1
                switch self.arrayOrdenRedes[0] {
                case "t":
                    cell.imagen1.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen1.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen1.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen2
                switch self.arrayOrdenRedes[1] {
                case "t":
                    cell.imagen2.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen2.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen2.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                }
                
                // Indice de la red en arrayRedes que tomara
                cell.button1.tag = 1
                cell.button2.tag = 2
                cell.button1.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button2.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                
                return cell
            case 3:
                
                // Obtenemos celda
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedes3TableViewCell", for: indexPath) as! VDRedes3TableViewCell
                
                // Cargamos imagen1
                switch self.arrayOrdenRedes[0] {
                case "t":
                    cell.imagen1.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen1.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen1.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen2
                switch self.arrayOrdenRedes[1] {
                case "t":
                    cell.imagen2.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen2.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen2.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen3
                switch self.arrayOrdenRedes[2] {
                case "t":
                    cell.imagen3.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen3.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen3.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen3.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen3.image = #imageLiteral(resourceName: "web")
                }
                
                // Indice de la red en arrayRedes que tomara
                cell.button1.tag = 1
                cell.button2.tag = 2
                cell.button3.tag = 3
                cell.button1.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button2.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button3.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)

                return cell
            case 4:
                
                // Obtenemos la celda
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedes4TableViewCell", for: indexPath) as! VDRedes4TableViewCell
                
                // Cargamos imagen1
                switch self.arrayOrdenRedes[0] {
                case "t":
                    cell.imagen1.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen1.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen1.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen1.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen2
                switch self.arrayOrdenRedes[1] {
                case "t":
                    cell.imagen2.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen2.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen2.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen2.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen3
                switch self.arrayOrdenRedes[2] {
                case "t":
                    cell.imagen3.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen3.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen3.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen3.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen3.image = #imageLiteral(resourceName: "web")
                }
                
                // Cargamos imagen4
                switch self.arrayOrdenRedes[3] {
                case "t":
                    cell.imagen4.image = #imageLiteral(resourceName: "twitter")
                case "f":
                    cell.imagen4.image = #imageLiteral(resourceName: "facebook")
                case "i":
                    cell.imagen4.image = #imageLiteral(resourceName: "instagram")
                case "w":
                    cell.imagen4.image = #imageLiteral(resourceName: "web")
                default:
                    cell.imagen4.image = #imageLiteral(resourceName: "web")
                }
                
                // Indice de la red en arrayRedes que tomara
                cell.button1.tag = 1
                cell.button2.tag = 2
                cell.button3.tag = 3
                cell.button4.tag = 4
                
                cell.button1.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button2.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button3.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)
                cell.button4.addTarget(self, action: #selector(DetalladaAcercaViewController.abrirRedSocial(_:)), for: .touchUpInside)

                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "VDRedesTableViewCell", for: indexPath) as! VDRedesTableViewCell
                return cell
            }
        case 2: // MAPA
            let cell = tableView.dequeueReusableCell(withIdentifier: "VDMapaTableViewCell", for: indexPath) as! VDMapaTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
                
            case 0: // RATING
                return 55.0
            case 1: // CHECK IN
                return 55.0
            case 2: // DESCRIPCION
                return 144.0
            case 3: // TELEFONO
                return 55.0
            case 4: // HORA
                return 55.0
            case 5: // BOTONES
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

// MARK: - Delegate

extension DetalladaAcercaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        // Prin Section and Row
        
        print("Section: \(indexPath.section), Row: \(indexPath.row)")
        
        // Deselect Cell
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
            
        case 0: // SECTION
            switch indexPath.row {
                
            case 0: // RATING
                break
            case 1: // CHECK IN
                break
            case 2: // DESCRIPCION
                break
            case 3: // TELEFONO
                
                let cell = tableView.cellForRow(at: indexPath) as! VDTelefonoTableViewCell
                    if let phoneCallURL = URL(string: "tel://\(Int(cell.label.text!)!)") {
                        let application:UIApplication = UIApplication.shared
                        if (application.canOpenURL(phoneCallURL)) {
                            application.open(phoneCallURL, options: [:], completionHandler: nil)
                        }
                    }
                break
            case 4: // HORA
                break
            case 5: // BOTONES
                break
            default:
                return
            }
            
        case 1: // SECTION
            switch indexPath.row {
                
            case 0: // REDES SCIALES
                break
            default:
                return
            }
            
        case 2: // SECTION
            switch indexPath.row {
            case 0: // MAPAS
                break
            default:
                return
            }
            
        default:
            return
        }
        
        //performSegue(withIdentifier: "asdf", sender: self)
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
                
            case 0: // RATING
                return true
            case 1: // CHECK IN
                return false
            case 2: // DESCRIPCION
                return false
            case 3: // TELEFONO
                return true
            case 4: // HORA
                return false
            case 5: // BOTONES
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

// MARK: - SlideShow Pod

extension DetalladaAcercaViewController {
    
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

// MARK: - Scroll

extension DetalladaAcercaViewController {

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

extension DetalladaAcercaViewController {

    func setupLeftBarButtonItemWithImage() {
        
        let newBbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "close"), target: self, action: #selector(DetalladaAcercaViewController.close))
        self.navigationItem.leftBarButtonItem = newBbi
    }
    
    func close() {
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("Dismiss 👀")
    }
    
    func leftBarButtonAzul() {
        
        let nbbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "close"),
                                            target: self,
                                            action: #selector(DetalladaAcercaViewController.close))
        
        navigationItem.leftBarButtonItem = nbbi
    }
    
    func leftBarButtonWhite() {
        
        let nbbi = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "closeAzul"),
                                            target: self,
                                            action: #selector(DetalladaAcercaViewController.close))
        
        navigationItem.leftBarButtonItem = nbbi
    }

}

// MARK: - Bar Button Item Right

extension DetalladaAcercaViewController {
    
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

// MARK: - Navigation Bar Storyboard

extension DetalladaAcercaViewController {
    
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

extension DetalladaAcercaViewController {

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

// MARK: - Go Redes Sociales

extension DetalladaAcercaViewController {
 
    func abrirRedSocial(_ sender:UIButton!) {
        
        self.performSegue(withIdentifier: "detalladaWebViewSocial", sender: sender)
    }
}

// MARK: - Navigation

extension DetalladaAcercaViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "detalladaWebViewSocial" {
//            
//            let wvs = segue.destination as! WebViewSocialViewController
//            wvs.enlance = self.enlace
//        }

        if let wvs = segue.destination as? WebViewSocialViewController {
            
            if let button:UIButton = sender as! UIButton? {
                print(button.tag)

                
                switch button.tag {
                case 1:
                    wvs.enlance = self.arrayRedes[0]
                case 2:
                    wvs.enlance = self.arrayRedes[1]
                case 3:
                    wvs.enlance = self.arrayRedes[2]
                case 4:
                    wvs.enlance = self.arrayRedes[3]
                default:
                    wvs.enlance = "http://offercity.mx/"
                }
                
                
            
            }
        }
    }
}
















