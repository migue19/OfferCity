//
//  VDPMapasTableViewCell.swift
//  OfferCity
//
//  Created by ginppian on 23/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit
import GoogleMaps

class VDPMapasTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Propertys

    static let identifier = "VDPMapasTableViewCell"
    
    // MARK: - Constructor

    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Actions

    @IBAction func buttonAction(_ sender: UIButton) {
        print("Mapa 📌")
    }
    
}

extension VDPMapasTableViewCell {
    
    func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 19.071514,
                                              longitude: -98.245873,
                                              zoom: 15.0)
        
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 19.071514, longitude: -98.245873)
        marker.title = "Puebla"
        marker.snippet = "México"
        marker.map = mapView
    }
}
