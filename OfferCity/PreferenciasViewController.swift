//
//  ViewController.swift
//  UICollectionView
//
//  Created by Miguel Mexicano Herrera on 03/02/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PreferenciasViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var preferenciasCollection: UICollectionView!
    var imei = "000354597072001669"
    var nombres:[String] = ["Puebla",
                                 "Ciudad de México",
                                 "Monterrey",
                                 "Guadalajara",
                                 "Querétaro",
                                 "Oaxaca"
                               ]
    var imagenes:[String] = ["Puebla",
                            "Ciudad-de-Mexico",
                            "Monterrey",
                            "Guadalajara",
                            "Queretaro",
                            "Oaxaca"
    ]
    
    var ciudad = -1
    
    //var array: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferenciasCollection.dataSource = self
        preferenciasCollection.delegate = self
        
        //navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //preferenciasCollection.la
        
        //self.preferenciasCollection.register(PreferenciasCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //preferenciasCollection.setCollectionViewLayout(<#T##layout: UICollectionViewLayout##UICollectionViewLayout#>, animated: <#T##Bool#>)
        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 50 //whatever height you want
        let bounds = self.navigationController!.navigationBar.bounds
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(nombres.count)
        
        return nombres.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        ///cell.backgroundColor = UIColor.black
        
        //cell.backgroundColor = UIColor.red
        let imageView = cell.viewWithTag(100) as! UIImageView
        let labelView = cell.viewWithTag(50) as! UILabel
        labelView.text = nombres[indexPath.row]
        //imageView.image = UIImage(named: preferencias[indexPath.row])
        imageView.image = UIImage(named: imagenes[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let subView = cell.viewWithTag(400)! as UIView
        let select = cell.viewWithTag(300) as! UIImageView
        
        if ciudad != indexPath.row{
           
            if ciudad == -1 {
                select.isHidden = false
                subView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
                ciudad = indexPath.row
            }
            else
            {
             let indPath2 = IndexPath(row: ciudad, section: 0)
               let cell2 = collectionView.cellForItem(at: indPath2)!
               let subView2 = cell2.viewWithTag(400)! as UIView
               let select2 = cell2.viewWithTag(300) as! UIImageView
               select2.isHidden = true
               subView2.backgroundColor = nil
                
                select.isHidden = false
                subView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
                ciudad = indexPath.row
            }
        }
        else{
            select.isHidden = true
            subView.backgroundColor = nil
            ciudad = -1
        }
        
        
        print("La Ciudad es: ", ciudad)
        /*let subView = cell.viewWithTag(400)! as UIView
        let select = cell.viewWithTag(300) as! UIImageView
        
    
        //subView.backgroundColor = UIColor.init(red: 299.0/255.0, green: 135.0/255.0, blue: 34.0/255.0, alpha: 0.6)
        
        if(subView.backgroundColor == nil)
        {
            //subView.backgroundColor = UIColor.init(red: 299.0/255.0, green: 135.0/255.0, blue: 34.0/255.0, alpha: 0.6)
            select.isHidden = false
            subView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
            //array.append(indexPath.row+1)
            //ImprimirArray()
            
        }
        else{
            select.isHidden = true
            subView.backgroundColor = nil
            //deleteElementArray(elemento: indexPath.row+1)
            //ImprimirArray()
        }*/
    }
    
    
    
    
  
    
    //Use for size
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = self.view.frame.width/2.0
        let sizelandscape = self.view.frame.width/4.0
        
        switch UIDevice.current.orientation{
        case .portrait:
            return CGSize(width: size, height: size)
        case .portraitUpsideDown:
            return CGSize(width: size, height: size)
        case .landscapeLeft:
            return CGSize(width: sizelandscape, height: sizelandscape)
        case .landscapeRight:
            return CGSize(width: sizelandscape, height: sizelandscape)
        default:
            return CGSize(width: size, height: size)
        }
    }
    //Use for interspacing
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Hola")
        preferenciasCollection.reloadData()
    }
    
    
    
    /*func ImprimirArray(){
        print("imprimiendo array: ")
        array.sort()
        
        for index in array{
            print(index)
        }
        
    }
    
    func deleteElementArray(elemento: Int){
        
        for  i in 0 ..< array.count
        {
            if array[i] == elemento
            {
                array.remove(at: i)
                break
            }
        }
        
    }*/
    
    
    //MARK: TASKS
     /*class PreferenceTask: AsyncTask{
        
        var params:Dictionary<String, AnyObject>!
        
        override func doInBackground(_ object: Any?) -> (result: Any?, error: NSError?) {
            params = object as! Dictionary<String, AnyObject>
            
            let rest = RestService()
            
           // let number = params["celular"] as! String
            
            //params.removeValue(forKey: "celular")
            
            print(params)
            
            let result = rest.SendPreference(params: params)
            return ( result.result, result.error )
        }
        
        
       override func postExecute(_ result: Any?, error: NSError?) {
            if error != nil {
                Utils.alert(context, title: "Exito",message: "Ocurrio un error.")
                return
            }
            
            print("resultado: \(result)")
            
            
            
            if (result! as! String == "true")
            {
                let storyboard : UIStoryboard = UIStoryboard( name: "Main", bundle: nil)
                let tabBarViewController: TabBarViewController = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! TabBarViewController
                /*validationViewController.previousName = nombre
                 validationViewController.previousLada = iso
                 validationViewController.previousPhone = celular
                 validationViewController.step = Int(step)*/
                
                context.navigationController?.pushViewController(tabBarViewController, animated: true)
            }
            else{
                print("Error")
                
            }
        }
        
        
        func convertToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
        
    }*/
    
    
    @IBAction func sendPreference(_ sender: Any) {
        
        if (ciudad == -1){
            let alert = UIAlertController(title: "Aviso",
                                          message: "Debe Seleccionar Una Ciudad",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        
        }
        
        else{
            print("Enviar Preferencias al Servicio")
            
            
            self.performSegue(withIdentifier: "PreferenciasToTabBar", sender: self)
            
            //Creacion de la instancia anidada de AsyncTask
            /*let preferenceTask = PreferenceTask( context: self )
            let params:Dictionary<String, AnyObject> = ["preferencias": array as AnyObject,
                                                        "imei": "000354597072001669" as AnyObject
            ]
            
            
            preferenceTask.execute(params)*/
        
        }
        
        
    }
    
    
   
    
    /* func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     
     
     return CGSize(width: 400, height: 200);
     }*/
    
}




