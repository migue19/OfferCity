//
//  ViewController.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 15/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import CoreData

class WelcomeViewController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate, UIScrollViewDelegate  {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Propertys
    
    var timer: Timer!
    var updateCounter: Int!
    var settings: [Settings] = []
    let settingsDAO = SettingsDAO()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.setNavigationBarHidden(true, animated: false)

    
        updateCounter = 0
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector( WelcomeViewController.updateTimer), userInfo: nil, repeats: true)
        
        
        
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(4)), height: scrollView.frame.size.height )
        
        scrollView.delegate = self
        
        
    }
    
    //MARK: - Page Control
    
    internal func updateTimer()
    {
        
        if(updateCounter <= 3)
        {
            pageControl.currentPage = updateCounter
            
            let image: String = "Inicio" + String(updateCounter)
            imageView.image = UIImage(named: image)
            
            updateCounter = updateCounter + 1
        }
        else{
            updateCounter = 0
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCounter = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        pageControl.currentPage = updateCounter
        let image: String = "Inicio" + String(updateCounter)
        imageView.image = UIImage(named: image)
        
        
    }
    
    // MARK: - Login Facebook
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Salio de Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Logueado Correctamente Con Facebook")
    }
    
    @IBAction func CustomLoginFB(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self){
            (result,error) in
            if error != nil{
                print("Error al loguearse: \(String(describing: error))")
                return
            }
            /*if(result!.token.tokenString! != nil){
             print("\(result?.token.tokenString!)")
             }*/
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id,name,email,first_name,last_name"]).start{
                (connetion,result,error) in
                if error != nil{
                    print("error al obtener los parametros del perfil")
                    return
                }
                
                var userID = ""
                var name = ""
                var firstName = ""
                var lastName = ""
                var email = ""
                var facebookProfileUrl = ""
                
                if let data = result as? [String:Any] {
                     userID = data["id"] as! String
                     name = data["name"] as! String
                     firstName = data["first_name"] as! String
                     lastName = data["last_name"] as! String
                     email = data["email"] as! String
                     facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                }
                
                
                self.settingsDAO.insertUserInDB(name: name, firstName: firstName, lastName: lastName, email: email, urlImage: facebookProfileUrl)
                
                let urlimage = URL(string: facebookProfileUrl)
                
                self.downloadImage(url: urlimage!)
                
                self.settingsDAO.getData()
                
                self.performSegue(withIdentifier: "showCiudad", sender: self)
            }
            
        }
    }
    
    // MARK: - Login Google
    
    @IBAction func CustomGoogleSingIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print("Error al Loggearse con google: \(error)")
            return
        }
        
        print("Logueo Google Correcto", user)
        
        
        let name = user.profile.name ?? ""
        let firstName = user.profile.givenName ?? ""
        let lastName = user.profile.familyName ?? ""
        let email = user.profile.email ?? ""
        let urlimage = user.profile.imageURL(withDimension: 400)!
        
        settingsDAO.insertUserInDB(name: name, firstName: firstName, lastName: lastName, email: email, urlImage: String(describing: urlimage))
        
       downloadImage(url: urlimage)
   
        settingsDAO.getData()
        
        self.performSegue(withIdentifier: "showCiudad", sender: self)
        
    }
    
    
    // MARK: - Descargar Imagen y Guardarla en DB
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            
            self.settingsDAO.InsertImageDB(data: data)
            print("Download Finished")
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    
}

