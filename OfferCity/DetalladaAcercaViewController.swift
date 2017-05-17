//
//  DetalladaAcercaViewController.swift
//  OfferCity
//
//  Created by ginppian on 17/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetalladaAcercaViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    // MARK: - Propertys
    
    let localSource = [ImageSource(imageString: "borrarPizza")!]
    let algo = ImageSource(image: #imageLiteral(resourceName: "borrarPizza"))
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        //translucedNavigationBar()
        
        setupSlideShow()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        slideshow.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
    }
    
}

// MARK: - Data Source

extension DetalladaAcercaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDRatingTableViewCell", for: indexPath) as! VDRatingTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDCheckInTableViewCell", for: indexPath) as! VDCheckInTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDDescripcionTableViewCell", for: indexPath) as! VDDescripcionTableViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDTelefonoTableViewCell", for: indexPath) as! VDTelefonoTableViewCell
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDHoraTableViewCell", for: indexPath) as! VDHoraTableViewCell
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDBotonesTableViewCell", for: indexPath) as! VDBotonesTableViewCell
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDRedesTableViewCell", for: indexPath) as! VDRedesTableViewCell
        case 7:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDIconosRedesTableViewCell", for: indexPath) as! VDIconosRedesTableViewCell
        case 8:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDLocalizacionTableViewCell", for: indexPath) as! VDLocalizacionTableViewCell
        case 9:
            cell = tableView.dequeueReusableCell(withIdentifier: "VDMapaTableViewCell", for: indexPath) as! VDMapaTableViewCell
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 55.0
        case 1:
            return 89.0
        case 2:
            return 144.0
        case 3:
            return 55.0
        case 4:
            return 55.0
        case 5:
            return 89.0
        case 6:
            return 55.0
        case 7:
            return 55.0
        case 8:
            return 55.0
        case 9:
            return 89.0
        default:
            return 55.0
        }
    }
    
}

// MARK: - SlideShow Pod

extension DetalladaAcercaViewController {
    
    func setupSlideShow() {
        
        // Settings
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            print("current page:", page)
            
            // Load Images
            
            self.slideshow.setImageInputs(self.localSource)
            
            // Add Gesture
            
            let recognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(DetalladaAcercaViewController.didTap))
            
            self.slideshow.addGestureRecognizer(recognizer)
            
        }
        
    }
    
    func didTap() {
        slideshow.presentFullScreenController(from: self)
    }
    
}

// MARK: - Navigation Bar
extension DetalladaAcercaViewController {
    
    func setNavigationBar() {
        
        //let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        let navBar = translucedNavigationBar()
        
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(DetalladaAcercaViewController.done))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func done() {

        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func translucedNavigationBar() -> UINavigationBar {
        
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        return navBar
        
        
        
        
        /*self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)*/
        //        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (slideshow.bounds.height-50) {
            
            self.navigationController?.navigationBar.tintColor = UIColor.red
            print("more")
            
        } else {
            self.navigationController?.navigationBar.tintColor = UIColor.white
            print("less")
        }
    }
    
}
