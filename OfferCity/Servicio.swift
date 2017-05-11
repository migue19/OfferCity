//
//  Servicio.swift
//  OfferCity
//
//  Created by ginppian on 11/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation

struct Servicio {
    static let shared = Servicio()
    
    func mostrarEstablecimiento() -> String {
        return "https://offercity.herokuapp.com/api/mostrarEstablecimiento"
    }
    
    
}
