//
//  RestaurantModel.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

struct RestaurantRequestModel: Decodable {
    let total: Int
    let max: Int
    let data: [RestaurantModel]
}

struct RestaurantModel: Decodable {
    let name: String
    let deliveryTime: String
    let deliveryAreas: String
    let generalScore: Float
    let coordinates: String
}
