//
//  RestConnection.swift
//  followme
//
//  Created by Miguel Mexicano Herrera on 14/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Path:String {
    case SERVICE_TEST = "http://189.206.53.12/paychat-core/secured/chatService/profile/getShortProfile"
    
}


class RestConnection{
    
    
    
    func SendRequetService(url: String,body: Parameters, secure:Bool, method: HTTPMethod, completionHandler: @escaping (JSON?, Error?) -> ())
    {
        if(secure){
            MethodHTTPSecure(body: body, method: method, completion: completionHandler)
        }
        else{
          MethodHTTP(body: body, method: method, completion: completionHandler )
        }
    }
    
    
    
    func MethodHTTPSecure(body: Parameters, method: HTTPMethod, completion: @escaping (JSON?, Error?) -> () ){
        //Obtenerlos de la base de Datos Local
        print("Metodo Seguro")
        let user: String = "522227113239"
        let password: String = "630215"
        
        Alamofire.request(Path.SERVICE_TEST.rawValue,method: method,parameters: body, encoding: JSONEncoding.default).authenticate(user: user, password: password).responseJSON { response in
            print(response.request as Any)  // original URL request
            print("Response HTTP URL:", response.response!) // HTTP URL response
            print(response.data!)     // server data
            print("Response Serialization: ", response.result)   // result of response serialization
         
            switch response.result{
            case .success(let value):
                print(value)
                completion(JSON(value), nil)
                
            case .failure(let error):
                completion(nil, error)
            }
            
            
        }
        
    }
    
    
    func MethodHTTP(body: Parameters, method: HTTPMethod, completion: @escaping (JSON?, Error?) -> () ){
         print("Metodo Simple")
        Alamofire.request(Path.SERVICE_TEST.rawValue,method: method,parameters: body, encoding: JSONEncoding.default).responseJSON { response in
            print(response.request as Any)  // original URL request
            print("Response HTTP URL:", response.response!) // HTTP URL response
            print(response.data!)     // server data
            print("Response Serialization: ", response.result)   // result of response serialization
          
            switch response.result{
            case .success(let value):
                print(value)
                    completion(JSON(value), nil)
                
            case .failure(let error):
                    completion(nil, error)
            }
            
        }

    }
    
    
  




}
