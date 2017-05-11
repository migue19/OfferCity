//
//  Headers.swift
//  OfferCity
//
//  Created by ginppian on 11/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import Alamofire

struct Headers {
    
    static let shared = Headers()
    
    func mostrarEstablecimiento() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            ]
        
        return headers
    }
    
}
