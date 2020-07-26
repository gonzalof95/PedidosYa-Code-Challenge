//
//  TokenModel.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

struct tokenModel: Decodable {
    let token: String?
    
    public enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}
