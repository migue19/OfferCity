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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        self.getData()
    
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
                
                
                self.InsertSetting(descripcion: "Name", valor: name)
                self.InsertSetting(descripcion: "FirstName", valor: firstName)
                self.InsertSetting(descripcion: "LastName", valor: lastName)
                self.InsertSetting(descripcion: "Email", valor: email)
                self.InsertSetting(descripcion: "ImageURL", valor: facebookProfileUrl)
                
                let urlimage = URL(string: facebookProfileUrl)
                
                self.downloadImage(url: urlimage!)
                
                
                self.getData()
                
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
        
     
       self.InsertSetting(descripcion: "Name", valor: user.profile.name)
       self.InsertSetting(descripcion: "FirstName", valor: user.profile.givenName)
       self.InsertSetting(descripcion: "LastName", valor: user.profile.familyName)
       self.InsertSetting(descripcion: "Email", valor: user.profile.email)
        
       let urlimage = user.profile.imageURL(withDimension: 400)
        
       self.InsertSetting(descripcion: "ImageURL", valor: String(describing: urlimage!))
        
        
       downloadImage(url: urlimage!)
        
       //saveImage(tempImage, path: fileInDocumentsDirectory("tempImage"))
   
        getData()
        
        self.performSegue(withIdentifier: "showCiudad", sender: self)
        
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            settings = try context.fetch(Settings.fetchRequest())
            
            if settings.count > 0 {
                for setting in settings{
                    print(setting.descripcion ?? "")
                    print(setting.valor ?? "")
                    print("")
                }
            }else{
                 print("No Hay Datos Para Mostrar")
            }
        }
        catch{
            print("Failed feching")
        }
        
    }
    
    func InsertSetting(descripcion: String, valor: String){
        let context = AppDelegate.viewContext
        
        let request: NSFetchRequest<Settings> = Settings.fetchRequest()
        
        request.predicate = NSPredicate(format: "descripcion = %@", descripcion)
        
        do{
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0{
                print("Updateando Setting")
                UpdateSettingCoreData(setting: fetchResult[0], descripcion: descripcion, valor: valor)
            
            }else{
                print("Insertando Setting")
                let userData = Settings(context: context)
                
                userData.descripcion = descripcion
                userData.valor = valor
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
        }
        catch{
           print("No se pudo hacer la conexion con la DB")
        
        }
    }
    
    
    func deleteSettingCoreData(setting: Settings){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(setting)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
    func UpdateSettingCoreData(setting: Settings,descripcion: String, valor: String) {
        setting.setValue(descripcion, forKey: "descripcion")
        setting.setValue(valor, forKey: "valor")
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    func findAndUpdateSettings(descripcion: String, valor: String){
        let context = AppDelegate.viewContext
        
        let request: NSFetchRequest<Settings> = Settings.fetchRequest()
        
        request.predicate = NSPredicate(format: "descripcion = %@", descripcion)
        
            do{
                let settings2 = try context.fetch(request)
                if settings2.count > 0 {
                    for setting in settings2{
                        self.UpdateSettingCoreData(setting: setting, descripcion: descripcion, valor: valor)
                    }
                }else{
                     print("No Hay Datos Para Updatear")
                }
            }
            catch{
                print("Failed feching")
            }
    }
    
    
    func findAndDeleteSettings(descripcion: String) {
        let context = AppDelegate.viewContext
        
        let request: NSFetchRequest<Settings> = Settings.fetchRequest()
        
        request.predicate = NSPredicate(format: "descripcion = %@", descripcion)
        
        do{
            let settings2 = try context.fetch(request)
            
            if settings2.count > 0 {
                for setting in settings2{
                    deleteSettingCoreData(setting: setting)
                }
            }
            else{
                print("No Hay Datos Para Borrar")
            }
        }
        catch{
            print("Failed feching")
        }

        
    }
    
    
    func deleteAllSettings(){
        let array = ["Email","Name","FirstName","LastName","ImageURL"]
        
        for description in array {
            self.findAndDeleteSettings(descripcion: description)
        }
    }
    
    
    //////Descargar Imagen y Guardarla Asyncronamente
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            
            
            
            guard let data = data, error == nil else { return }
            let context = AppDelegate.viewContext
            
            let userData = Imagen(context: context)
            
            userData.imagen = data as NSData
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            /*DispatchQueue.main.async() { () -> Void in
                self.imageView.image = UIImage(data: data)
            }*/
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    
}

