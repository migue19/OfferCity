//
//  ViewController.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 15/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,FBSDKLoginButtonDelegate,GIDSignInUIDelegate,GIDSignInDelegate, UIScrollViewDelegate  {
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //var arrayImage = ["fb-logo","google-logo","seleccionar"]
    var timer: Timer!
    var updateCounter: Int!
    var settings: [Settings] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        ///////Core Data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        let user = Settings(context: context)
        
        user.descripcion = "User"
        user.valor = "Miguel"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //Regresar a una vista anterior
        //navigationController?.popViewController(animated: true)
        
        getData()
        
        
        updateCounter = 0
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector( ViewController.updateTimer), userInfo: nil, repeats: true)
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(4)), height: scrollView.frame.size.height )
        
        scrollView.delegate = self
    }
    
    
   /* override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 20 //whatever height you want
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - height)
        
    }*/
    
    
    //MARK: - Funciones Page Control
    
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
    
    /////////////////Fin
    
    
    
    
    //MARK: - Login Facebook
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("has salido de facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("felicidades te logueaste con facebook")
    }
    
    
    @IBAction func CustomLoginFB(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self){
            (result,error) in
            if error != nil{
                print("Error al loguearse: \(error)")
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
    
    /////////Fin
    
    
    // MARK: - Login Google
    @IBAction func CustomGoogleSingIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print("Error al Loggearse con google: \(error)")
            return
        }
        print("Logueo con Google Correcto", user)
        
        guard let idtoken = user.authentication.idToken else {return}
        guard let accestoken = user.authentication.accessToken else {return}
        
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idtoken, accessToken: accestoken)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil{
                print("error al crear el firebase user  con la cuenta de Google: \(error)")
                return
            }
            
            guard let uid = user?.uid else{return}
            print("Login completo con Google en Firebase id: ", uid)
        })
        
        self.performSegue(withIdentifier: "showCiudad", sender: self)
        print(user.profile.email)
        print(user.profile.imageURL(withDimension: 400))
        print(user.profile.name)
        print(user.profile.givenName)
        print(user.profile.familyName)
        
}
//////////Fin
    
    
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

