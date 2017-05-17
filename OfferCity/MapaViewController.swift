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

class MapaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Obetener ubicacion y enviarla al servicio
        /*let user = "522227113239"
        let password = "630215"
        
        
            
        let parameters: Parameters = [
            "userId": "522224458813",
            "isProfile": true,
            "imei":"000867721021924579"
        ]
            
        
        Alamofire.request("http://189.206.53.12/paychat-core/secured/chatService/profile/getShortProfile",method: .post,parameters: parameters, encoding: JSONEncoding.default).authenticate(user: user, password: password).responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response!) // HTTP URL response
            print(response.data!)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 19.071514, longitude: -98.245873, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 19.071514, longitude: -98.245873)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
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
