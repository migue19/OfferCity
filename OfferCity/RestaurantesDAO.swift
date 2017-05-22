//
//  RestaurantesDAO.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 21/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import CoreData

class RestaurantesDAO{
    
    func getRestaurantes() -> [Restaurantes]
    {
        let context = AppDelegate.viewContext
        
        do {
            let restaurantes: [Restaurantes] = try
            context.fetch(Restaurantes.fetchRequest())
            return restaurantes
        }catch{
        print("Error al obtener los Rest de la DB")
        return []
        }
        
    }
    
    func InsertRestaurantDB(data: Data, id: Int32, restauranteMapper: RestaurantesMapper){
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Restaurantes> = Restaurantes.fetchRequest()
        
        request.predicate = NSPredicate(format: "id_establecimiento = \(id)")
        do {
            let fetchRequest = try context.fetch(request)
            if fetchRequest.count > 0
            {
                print("Updateando Imagen")
                print(fetchRequest)
                UpdateImage(restaurante: fetchRequest[0] , data: data)
            }
            else{
                print("Insertando Imagen")
                let restauranteCoreData = Restaurantes(context: context)
                
                // Fill
                restauranteCoreData.nombre = restauranteMapper.nombre
                restauranteCoreData.latitud = restauranteMapper.latitud
                restauranteCoreData.longitud = restauranteMapper.longitud
                restauranteCoreData.id_establecimiento = Int32(restauranteMapper.id_establecimiento)
                restauranteCoreData.tmp = Int32(restauranteMapper.tmp)
                restauranteCoreData.descripcion = restauranteMapper.descripcion
                restauranteCoreData.photo = restauranteMapper.photo
                restauranteCoreData.image = data as NSData
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
        }catch{
            print("Error al Obtener imagenes de la DB")
        }
    }
    
    
    func UpdateImage(restaurante: Restaurantes, data: Data){
        restaurante.setValue(data, forKey: "image")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }




}
