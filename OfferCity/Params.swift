//
//  Params.swift
//  OfferCity
//
//  Created by ginppian on 11/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import Alamofire

struct Params {

    static let shared = Params()
    
    func mostrarEstablecimiento() -> Parameters {
        let params : Parameters = ["token": "c31e7cc5503e222a6d2ab594c845730272273a5bdcdbd1b97e29df7e19b3ecdadf021fe6a05a0da5c7046e670d89365181d15d037262822231735da484398578"]
        
        return params
    }
    

}
