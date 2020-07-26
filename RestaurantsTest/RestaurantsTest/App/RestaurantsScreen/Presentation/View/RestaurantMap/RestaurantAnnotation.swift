//
//  RestaurantAnnotation.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 26/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    
    
    let name: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
        
        super.init()
    }
    
    var title: String? { return name }
}
