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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        createMarkers()
        
        // Do any additional setup after loading the view.
        /*let button = UIButton()
        button.frame = (frame: CGRect(x: self.view.frame.size.width - 60, y: 20, width: 50, height: 50)) as! CGRect
        button.backgroundColor = UIColor.red
        button.setTitle("Name your Button ", for: .normal)
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)*/
        
        
        
        
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
    
    
    
    func createMarkers(){
        restaurantes = restaurantesDAO.getRestaurantes()
        
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
    
    
    }
    
    /*override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        restaurantes = restaurantesDAO.getRestaurantes()
        let camera = GMSCameraPosition.camera(withLatitude: 19.071514, longitude: -98.245873, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        self.view = mapView
        
        
        

        
        
        
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
    }*/
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        let infoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self.view, options: nil)!.first! as! CustomInfoWindow
       
        var newFrame = infoWindow.frame
        let width = self.view.bounds.width * 0.95
        let height = width * 0.4
        
        newFrame.size.width = width
        newFrame.size.height = height
        
        
        
       
        infoWindow.frame = newFrame
        infoWindow.title.text = marker.title
        infoWindow.descripcion.text = marker.snippet
        infoWindow.Imagen.image = UIImage(data: restaurantes[0].image! as Data)
        return infoWindow
    }
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
