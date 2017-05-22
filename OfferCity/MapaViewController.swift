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
    var restaurantes: [Restaurantes] = []
    let restaurantesDAO = RestaurantesDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        restaurantes = restaurantesDAO.getRestaurantes()
        let camera = GMSCameraPosition.camera(withLatitude: 19.071514, longitude: -98.245873, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        view = mapView
        
        
        
       // for restaurante in restaurantes
        //{
        
        
        if restaurantes.count > 0{
            print("pintando Mapas")
            for restaurant in restaurantes{
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: restaurant.latitud, longitude: restaurant.longitud)
                marker.title = restaurant.nombre
                marker.snippet = restaurant.descripcion
                print(restaurant.photo ?? "")
                //let data = restaurant.image
                //if data != nil
                //{
                 //marker.icon = UIImage(data: data! as Data)
                //}
                marker.map = mapView
            }
        }
        else{
            print("No hay datos para pintar")
        }
       // }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
       
        var newFrame = infoWindow.frame
        newFrame.size.width = self.view.bounds.width - 20
        
       
        infoWindow.frame = newFrame
        infoWindow.title.text = marker.title
        infoWindow.descripcion.text = marker.snippet
        infoWindow.Imagen.image = UIImage(data: restaurantes[0].image! as Data)
        return infoWindow
    }
    
    
    /*func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
        infoWindow.title.text = marker.title
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
        infoWindow.title.text = marker.title
        return infoWindow
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
