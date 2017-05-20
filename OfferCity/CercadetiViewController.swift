//
//  CercadetiViewController.swift
//  OfferCity
//
//  Created by ginppian on 01/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import CoreData
import SDWebImage

/*NOTA:
    ⚠️ Hace falta el caso de que si llega un UPDATE
    ⚠️ Guardar imagenes en CoreData
 */

class CercadetiViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Propertys
    
    var imageFromCellToDetall: UIImage!
    
    fileprivate var restaurantes : [Restaurantes] = {
        
        var _restaurantes = [Restaurantes]()
        
        if !Reachability.isConnectedToNetwork() {
            
            let context = AppDelegate.viewContext
            let fetch = NSFetchRequest<Restaurantes>(entityName: "Restaurantes")
            
            do {
                _restaurantes = try context.fetch(fetch)
                
            } catch {
                fatalError("Failed to fetch: \(error)")
            }
            
        }
    
        return _restaurantes
    
    }()
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() {
            
            getData()
        }
        
        updateView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "acercadetiDetalladaAcerca" {
            
            let nav = segue.destination as? UINavigationController
            let vc = nav?.topViewController as? DetalladaAcercaViewController
            
            //let vc = segue.destination as! DetalladaAcercaViewController
            if self.imageFromCellToDetall == nil {
                
                vc?.imageFromCellToDetall = #imageLiteral(resourceName: "placeholder")
            } else {
                
                vc?.imageFromCellToDetall = self.imageFromCellToDetall
            }
            
        }
    }
    
}

// MARK: - Views

extension CercadetiViewController {
    
    fileprivate func setupView() {
        
    }
    
    fileprivate func setupMessage() {
        
    }
    
    fileprivate func updateView() {
        
        let existenRestaurantes = restaurantes.count > 0
        
        if existenRestaurantes {
            
            self.collectionView.isHidden = false
            self.imageView.isHidden = true
            self.label.isHidden = true
        } else {
        
            self.collectionView.isHidden = true
            self.imageView.isHidden = false
            self.label.isHidden = false
            self.view.backgroundColor = UIColor.white
            self.activityIndicator.isHidden = true
            self.contentView.backgroundColor = UIColor.white
        }
        

        
        
    }
    
}

// MARK: - Core Data

extension CercadetiViewController {
    
    func isExist(id_establecimiento: Int) -> Bool {
        
        let fetchRequest = NSFetchRequest<Restaurantes>(entityName: "Restaurantes")
        fetchRequest.predicate = NSPredicate(format: "id_establecimiento = \(id_establecimiento)", argumentArray: nil)
        
        let res = try! AppDelegate.viewContext.fetch(fetchRequest)
        if res.count > 0 {
            
            return true
        } else {
            
            return false
        }
    }
    
    func getData() {
        
        DispatchQueue.global(qos: .default).async {
            print("This is run on the background queue")
            
            Alamofire.request(Url.mostrarEstablecimiento(), method: .post, parameters: Params.mostrarEstablecimiento(), encoding: Encoding.default(), headers: Headers.default())
                
                .responseObject { (response: DataResponse<EdoardoMapper>) in
                    
                    let edoardo = response.result.value
                    print(edoardo?.arrayRes ?? "valio barriga")
                    
                    if let restaurantes = edoardo?.arrayRes {
                        
                        // Save Data
                        
                        for restaurante in restaurantes {
                            
                            if !self.isExist(id_establecimiento: restaurante.id_establecimiento) {
                            
                                self.saveData(restauranteMapper: restaurante)
                            }
                        }
                        
                        let context = AppDelegate.viewContext
                        let fetch = NSFetchRequest<Restaurantes>(entityName: "Restaurantes")
                        
                        do {
                            
                            self.restaurantes = try context.fetch(fetch)
                        } catch {
                            
                            fatalError("Failed to fetch: \(error)")
                        }
                    }
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.imageView.isHidden = true
                    self.collectionView.isHidden = false
                    
                    self.collectionView.reloadData()
            }
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                
                self.collectionView.isHidden = true
                self.imageView.isHidden = true
                self.label.isHidden = true
                
                //self.view.backgroundColor = UIColor.blue
                
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                
                
            }
        }
    }
    
    
    func saveData(restauranteMapper: RestaurantesMapper) {
        
        // Context
        
        let context = AppDelegate.viewContext
        
        // Create
        
        let restauranteCoreData = Restaurantes(context: context)
        
        // Fill
        
        restauranteCoreData.nombre = restauranteMapper.nombre
        restauranteCoreData.latitud = restauranteMapper.latitud
        restauranteCoreData.longitud = restauranteMapper.longitud
        restauranteCoreData.id_establecimiento = Int32(restauranteMapper.id_establecimiento)
        restauranteCoreData.tmp = Int32(restauranteMapper.tmp)
        restauranteCoreData.descripcion = restauranteMapper.descripcion
        restauranteCoreData.photo = restauranteMapper.photo
        
        // Save
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
}

// MARK: - DataSource

extension CercadetiViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        
        print("😎 \(self.restaurantes.count)")
        return self.restaurantes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CercadetiCollectionViewCell.identifier, for: indexPath) as? CercadetiCollectionViewCell else {
            
            fatalError("Unexpected IndexPath")
        }
        
        // Get Restaurante
        
        let restaurante = self.restaurantes[indexPath.row]
        
        
        // Fill
        
        cell.tag = indexPath.row
        cell.labelNombre.text = restaurante.nombre
        print(restaurante.nombre ?? "")
        cell.labelDireccion.text = restaurante.descripcion
        
        // Image
        
        //cell.imagFoto.downloadedFrom(link: restaurante.photo!)

        cell.imagFoto.sd_setShowActivityIndicatorView(true)
        cell.imagFoto.sd_setIndicatorStyle(.white)
        //cell.imagFoto.sd_setImage(with: URL(string: restaurante.photo!), placeholderImage: #imageLiteral(resourceName: "borrar1"))
        cell.imagFoto.sd_setImage(with: URL(string: restaurante.photo!))
        
        return cell
        
    }
}

// MARK: - Delegate 

extension CercadetiViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                                    didSelectItemAt indexPath: IndexPath) {
     
        let cell = collectionView.cellForItem(at: indexPath) as! CercadetiCollectionViewCell
        self.imageFromCellToDetall = cell.imagFoto.image
        
        performSegue(withIdentifier: "acercadetiDetalladaAcerca", sender: self)
    }
    
}

// MARK: - FlowLayout

extension CercadetiViewController: UICollectionViewDelegateFlowLayout {
    
    //Use for size
    
    internal func collectionView(_ collectionView: UICollectionView,
                                    layout collectionViewLayout: UICollectionViewLayout,
                                    sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = width
        
        return CGSize(width: width , height: height+55)
//        let size = collectionView.bounds.width/2.0
//        let sizelandscape = collectionView.bounds.width/4.0
//        
//        switch UIDevice.current.orientation{
//        case .portrait:
//            return CGSize(width: size, height: size)
//        case .portraitUpsideDown:
//            return CGSize(width: size, height: size)
//        case .landscapeLeft:
//            return CGSize(width: sizelandscape, height: sizelandscape)
//        case .landscapeRight:
//            return CGSize(width: sizelandscape, height: sizelandscape)
//        default:
//            return CGSize(width: size, height: size)
//        }
    }
    
    //Use for interspacing
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - Clases Object Mapper

class EdoardoMapper: Mappable {
    
    var arrayRes: [RestaurantesMapper]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        arrayRes            <- map["restaurantes"]
    }
    
}

class RestaurantesMapper: Mappable {
    
    var nombre: String!
    var latitud: Double!
    var longitud: Double!
    var id_establecimiento: Int!
    var tmp: Int!
    var descripcion: String!
    var photo: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        nombre              <- map["nombre"]
        latitud             <- map["latitud"]
        longitud            <- map["longitud"]
        id_establecimiento  <- map["id_establecimiento"]
        tmp                 <- map["tmp"]
        descripcion         <- map["descripcion"]
        photo               <- map["photo"]
    }
    
}








































