//
//  MapaViewController.swift
//  followme
//
//  Created by Miguel Mexicano Herrera on 10/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapaViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var restaurantes: [Restaurantes] = []
    let restaurantesDAO = RestaurantesDAO()
    
    let arrayImage = [#imageLiteral(resourceName: "borrarEvento1"), #imageLiteral(resourceName: "borrarEvento2"), #imageLiteral(resourceName: "borrarEvento3"), #imageLiteral(resourceName: "borrarEvento4")]
    let arrayEvento = ["Marc Anthony ", "LOS ANGELES AZULES", "Mijares", "Sofía Niño de Rivera"]
    let arrayFecha = ["16 de mayo", "26 DE MAYO", "24 junio", "15 de junio"]
    let arrayUbicacion = ["Complejo cultural universitario", "Auditorio metropolitano", "Auditorio del C.C.U.", "Auditorio del C.C.U."]
    let arrayLatitud = [19.019807,19.035273,19.019357,19.018949]
    let arrayLongitud =  [-98.240838,-98.236860,-98.239941,98.239717]
    
    var segment = 0  /////0 es lugares : 1 es eventos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        createMarkersPlaces()
    }
    
    
    private func setupMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 19.071514, longitude: -98.245873, zoom: 10.0)
        
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func createMarkersPlaces(){
        
        
        restaurantes = restaurantesDAO.getRestaurantes()
        
        if restaurantes.count > 0{
            mapView.clear()
            
            print("pintando Mapas")
            for  (index, restaurant) in restaurantes.enumerated(){
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: restaurant.latitud, longitude: restaurant.longitud)
                marker.title = restaurant.nombre
                
                var descripcion = restaurant.descripcion!
                
            
                marker.userData = ["index": index]
                
                
                if descripcion.characters.count > 150
                {
                   let index = descripcion.index(descripcion.startIndex, offsetBy: 150)
                   descripcion = descripcion.substring(to: index)+"..."
                }
                
                marker.snippet = descripcion
                marker.map = mapView
            }
        }
        else{
            print("No hay datos para pintar")
        }
    }
    
    
    func createMarkersEventos(){
        if arrayEvento.count > 0{
            mapView.clear()
            print("pintando Eventos")
            for  (index, evento) in arrayEvento.enumerated(){
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: arrayLatitud[index], longitude: arrayLongitud[index])
                
                marker.userData = ["index": index]
                
                marker.title = evento
                
                let descripcion =  "Fecha: " + arrayFecha[index] + "\n" + "Lugar: " + arrayUbicacion[index]
                
                marker.snippet = descripcion
                marker.map = mapView
            }
        }
        else{
            print("No hay datos para pintar")
        }

    }
    
    
    @IBAction func changeMarkers(_ sender: Any) {
        
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            segment = 0
            createMarkersPlaces()
            print("cerca de tiº")
        case 1:
            createMarkersEventos()
            segment = 1
            print("eventos")
        default:
            break
        }
        
        
    }
    
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
       
        var newFrame = infoWindow.frame
        let width = self.view.bounds.width * 0.95
        let height = width * 0.4
        
        newFrame.size.width = width
        newFrame.size.height = height
        
        let dataMarker = marker.userData as! [String: Any]
        
        let indice = dataMarker["index"] as! Int
        
        
        infoWindow.frame = newFrame
        infoWindow.title.text = marker.title
        infoWindow.descripcion.text = marker.snippet
        
        
        if segment == 0{
          infoWindow.Imagen.image = UIImage(data: restaurantes[indice].image! as Data)
        }else{
          infoWindow.Imagen.image = arrayImage[indice]
        }
        
        return infoWindow
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if segment == 0
        {
          performSegue(withIdentifier: "acercadetiDetallada", sender: marker)
        }else{
          performSegue(withIdentifier: "eventosDetallada", sender: marker)
        }
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let marker = sender as! GMSMarker
        let dataMarker = marker.userData as! [String: Any]
        let indice = dataMarker["index"] as! Int
        
        if segue.identifier == "acercadetiDetallada" {
            let image = UIImage(data: restaurantes[indice].image! as Data)
            
        
                let nav = segue.destination as! UINavigationController
                let vc = nav.topViewController as! DetalladaAcercaViewController
                if image == nil {
                    vc.imageFromCellToDetall = #imageLiteral(resourceName: "placeholder")
                }else{
                    vc.imageFromCellToDetall = image
                }
            
            return
        }
        if segue.identifier == "eventosDetallada"{
            let image = arrayImage[indice]
        
                let nav = segue.destination as! UINavigationController
                let vc = nav.topViewController as! DetalladaEventosViewController
            
                vc.imageFromCellToDetall = image
           
            return
        }
    }
}
