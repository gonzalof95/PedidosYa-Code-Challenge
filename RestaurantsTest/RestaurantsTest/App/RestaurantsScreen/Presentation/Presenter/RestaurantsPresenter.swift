//
//  RestaurantsPresenter.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

class RestaurantsPresenter {
    
    weak var delegate: RestaurantsViewControllerProtocol?
    var requestResponse: RestaurantRequestModel?
    var restaurantList: [RestaurantModel] = []
    var accessToken: String?
    let client: networkClient
    
    required init(_ client: networkClient) {
        self.client = client
    }
    
    func viewLoaded(_ token: String, _ coordinates: String) {
        getRestaurants(token, coordinates, nil, false)
    }
    
    func getRestaurants(_ token: String, _ coordinates: String, _ offset: Int?, _ reCall: Bool) {
        client.executeGetRestaurants(firstParamName: "point",
                          secondParamName: "country",
                          firstParamValue: coordinates,
                          secondParamValue: Constants.country,
                          token: token,
                          offset: offset ?? 0) { (result) in
                            switch result {
                            case .success(let restaurants):
                                self.restaurantList = restaurants.data
                                print(self.restaurantList)
                                DispatchQueue.main.async {
                                    if !reCall {
                                        self.delegate?.setupRestaurants(self.restaurantList)
                                    } else {
                                        self.delegate?.reloadTable(self.restaurantList)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                            }
        }
    }
}
