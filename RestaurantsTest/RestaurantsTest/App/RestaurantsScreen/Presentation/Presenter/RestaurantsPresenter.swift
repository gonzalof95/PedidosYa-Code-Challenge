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
    
    func viewLoaded(_ token: String) {
        getRestaurants(token)
    }
    
    private func getRestaurants(_ token: String) {
        client.executeGetRestaurants(firstParamName: "point",
                          secondParamName: "country",
                          firstParamValue: "-34.911554,-56.171583",
                          secondParamValue: Constants.country,
                          token: token) { (result) in
                            switch result {
                            case .success(let restaurants):
                                self.restaurantList = restaurants.data
                                print(":VVVVV")
                                print(self.restaurantList)
                                DispatchQueue.main.async {
                                    self.delegate?.setupTableView(self.restaurantList)
                                }
                                print("VVVVVV:")
                            case .failure(let error):
                                print(error)
                            }
        }
    }
}
