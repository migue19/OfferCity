//
//  RestService.swift
//  followme
//
//  Created by Miguel Mexicano Herrera on 14/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import Alamofire



class RestService{
    
    
    func ServiceTest(usuario: String, isProfile: Bool, imei: String, completionHandler: @escaping (ShortProfileResponse?, Error?) -> ()){
        let parameters: Parameters = [
            "userId": usuario,
            "isProfile": isProfile,
            "imei": imei
        ]
        
        RestConnection().SendRequetService(url: Path.SERVICE_TEST.rawValue, body: parameters, secure: true, method: .post){ response, error in
            if error != nil
            {
                print("Ocurrio un error al obtener el short Profile: ", error!)
                return
            }
            
            
            //response?.stringValue
            
            //print(response!)
            //print(response?.stringValue)
            
            //if let object = ShortProfileResponse.deserialize(from: response) {
                // …
            //}
            
            let contact: Int = response!["contact"].intValue
            let existeRegistro: Int = response!["existeRegistro"].intValue
            let mySubscription: Int = response!["mySubscription"].intValue
            let name: String = response!["name"].string!
            let pitcher: Int = response!["pitcher"].intValue
            let publicProfile: Int = response!["publicProfile"].intValue
            let total: Int = response!["total"].intValue
            let visitaPerfil: Int = response!["visitaPerfil"].intValue
            
            let profile = ShortProfileResponse(contacto: contact, existeRegistro: existeRegistro, mySubscription: mySubscription, name: name, pitcher: pitcher, publicProfile: publicProfile, total: total, visitaPerfil: visitaPerfil)
            
            
            completionHandler(profile, nil)
        
        }
       
    }


}










