//
//  MainViewControllerProtocol.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func pushNextViewController(_ accessToken: String?)
}
