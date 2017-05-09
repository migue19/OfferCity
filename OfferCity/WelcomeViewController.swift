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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let context = AppDelegate.viewContext
        
        let user = Settings(context: context)
        
        user.descripcion = "User"
        user.valor = "Miguel"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        getData()
        
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
                
                self.performSegue(withIdentifier: "showCiudad", sender: self)
                print(result!)
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
        
        self.performSegue(withIdentifier: "showCiudad", sender: self)
        print(user.profile.email)
        print(user.profile.imageURL(withDimension: 400))
        print(user.profile.name)
        print(user.profile.givenName)
        print(user.profile.familyName)
        
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            settings = try context.fetch(Settings.fetchRequest())
            print(settings)
        }
        catch{
            print("Failed feching")
        }
        
    }
    
    
    func deleteUserCoreData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let user = settings[0]
        
        context.delete(user)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
}

