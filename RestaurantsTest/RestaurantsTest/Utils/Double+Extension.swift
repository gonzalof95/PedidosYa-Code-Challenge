//
//  Double+Extension.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 27/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self) / pow(10.0, Double(places)))
    }
}
