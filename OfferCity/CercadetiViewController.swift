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

class CercadetiViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Propertys
    
    fileprivate var restaurantes = [Restaurantes]()
//    fileprivate var restaurantes: [Restaurantes] = {
//        
//        var _restaurantes = [Restaurantes]()
//        
//        let context = AppDelegate.viewContext
//        let fetch = NSFetchRequest<Restaurantes>(entityName: "Restaurantes")
//        
//        do {
//            _restaurantes = try context.fetch(fetch)
//        } catch {
//            fatalError("Failed to fetch: \(error)")
//        }
//        
//        return _restaurantes
//    }()
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Reachability.isConnectedToNetwork() {
            
            getData()
            
        }
        
        
    }
    
    
    // MARK: - Setup Views
    
    private func setupView() {
        
    }
    
    private func setupMessage() {
        
    }
    
    private func updateView() {
        
    }
    
    func getData() {
        
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .default).async {
            print("This is run on the background queue")
            
            Alamofire.request(Url.mostrarEstablecimiento(), method: .post, parameters: Params.mostrarEstablecimiento(), encoding: Encoding.default(), headers: Headers.default())
                
                .responseObject { (response: DataResponse<EdoardoMapper>) in
                    
                    let edoardo = response.result.value
                    print(edoardo?.arrayRes ?? "valio barriga")
                    
                    if let restaurantes = edoardo?.arrayRes {
                        
                        // Save Data
                        
                        for restaurante in restaurantes {
                            
                            print(restaurante.nombre!)
                            self.saveData(restauranteMapper: restaurante)
                            
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
                    
                    self.collectionView.reloadData()
                    
            }
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                
                //self.activityIndicator.startAnimating()
                
            }
        }
        
    }
    
    //extension CercadetiViewController {
    //
    //    func getData() {
    //
    //        DispatchQueue.global(qos: .default).async {
    //            print("This is run on the background queue")
    //
    //            Alamofire.request(Url.mostrarEstablecimiento(), method: .post, parameters: Params.mostrarEstablecimiento(), encoding: Encoding.default(), headers: Headers.default())
    //
    //                .responseObject { (response: DataResponse<EdoardoMapper>) in
    //
    //                    let edoardo = response.result.value
    //                    print(edoardo?.arrayRes ?? "valio barriga")
    //
    //                    if let restaurantes = edoardo?.arrayRes {
    //
    //                        // Save Data
    //
    //                        for restaurante in restaurantes {
    //
    //                            self.saveData(restauranteMapper: restaurante)
    //
    //                        }
    //                    }
    //
    //                    self.activityIndicator.stopAnimating()
    //                    self.activityIndicator.isHidden = true
    //
    //            }
    //
    //            DispatchQueue.main.async {
    //                print("This is run on the main queue, after the previous code in outer block")
    //
    //                self.activityIndicator.startAnimating()
    //
    //            }
    //        }
    //    }
    
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

extension CercadetiViewController: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                                numberOfItemsInSection section: Int) -> Int {

        return self.restaurantes.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                                cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CercadetiCollectionViewCell.identifier, for: indexPath) as? CercadetiCollectionViewCell else {
            fatalError("Unexpected IndexPath")
        }

        // Get

        let restaurante = self.restaurantes[indexPath.item]

        // Fill

        cell.labelNombre.text = restaurante.nombre
        print(restaurante.nombre ?? "")
        cell.labelDireccion.text = restaurante.descripcion
        print(restaurante.photo!)
        cell.imagFoto.downloadedFrom(link: restaurante.photo!)

        return cell

    }
}

extension CercadetiViewController: UICollectionViewDelegateFlowLayout {

    //Use for size

    internal func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.bounds.width
        let height = width

        return CGSize(width: width , height: height)
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








































