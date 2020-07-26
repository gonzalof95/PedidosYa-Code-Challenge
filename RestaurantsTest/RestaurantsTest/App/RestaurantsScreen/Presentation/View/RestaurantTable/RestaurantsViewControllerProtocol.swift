//
//  RestaurantsViewControllerProtocol.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

protocol RestaurantsViewControllerProtocol: AnyObject {
    func setupTableView(_ restaurants: [RestaurantModel])
}
