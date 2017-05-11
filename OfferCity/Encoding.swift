//
//  Encoding.swift
//  OfferCity
//
//  Created by ginppian on 11/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation
import Alamofire

struct Encoding {

    static let shared = Encoding()
    
    func `default`() -> URLEncoding {
        return URLEncoding.httpBody
    }
    
}
