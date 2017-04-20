//
//  File.swift
//  followme
//
//  Created by Miguel Mexicano Herrera on 11/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import Foundation



class Places{

    var latitud:Double;
    var longitud: Double;
    var title: String;
    var snippet: String;

    
    
    public init(latitud: Double,longitud: Double,title: String, snippet: String ){
          self.latitud = latitud
          self.longitud = longitud
        self.title = title
        self.snippet = snippet
        
    }



}
