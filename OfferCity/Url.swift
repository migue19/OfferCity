//
//  Servicio.swift
//  OfferCity
//
//  Created by ginppian on 11/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation

struct Url {
    
    static let shared = Url()
    
    func mostrarEstablecimiento() -> String {
        return "https://offercity.herokuapp.com/api/mostrarEstablecimiento"
    }
    
    
}
