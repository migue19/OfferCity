//
//  WebViewSocialViewController.swift
//  OfferCity
//
//  Created by ginppian on 25/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class WebViewSocialViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    // MARK: - Propertys
    
    var enlance = String()

    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Page
        
        print("Enlace: \(self.enlance)")
        let url = URL (string: self.enlance)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj)
    }

}

// MARK: - Life Cycle

extension WebViewSocialViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Setup navigation bar
        
        setupNavigationBar()
        
        // Setup Activity
        
        setupActivity()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
}

// MARK: - Navigation Bar

extension WebViewSocialViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
}

extension WebViewSocialViewController: UIWebViewDelegate {
    
    func setupActivity() {
        
        self.webView.delegate = self
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        self.activity.isHidden = false
        self.activity.startAnimating()
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.activity.stopAnimating()
        self.activity.isHidden = true
    }
}
