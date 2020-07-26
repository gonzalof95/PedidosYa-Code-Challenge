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
        getRestaurants(token, coordinates)
    }
    
    private func getRestaurants(_ token: String, _ coordinates: String) {
        client.executeGetRestaurants(firstParamName: "point",
                          secondParamName: "country",
                          firstParamValue: coordinates,
                          secondParamValue: Constants.country,
                          token: token) { (result) in
                            switch result {
                            case .success(let restaurants):
                                self.restaurantList = restaurants.data
                                print(":VVVVV")
                                print(self.restaurantList)
                                DispatchQueue.main.async {
                                    self.delegate?.setupRestaurants(self.restaurantList)
                                }
                                print("VVVVVV:")
                            case .failure(let error):
                                print(error)
                            }
        }
    }
}