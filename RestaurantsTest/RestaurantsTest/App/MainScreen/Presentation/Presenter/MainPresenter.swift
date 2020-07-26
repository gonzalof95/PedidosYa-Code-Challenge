//
//  MainPresenter.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

class MainPresenter {
    
    weak var delegate: MainViewControllerProtocol?
    var accessToken: tokenModel?
    let client: networkClient
    
    required init(_ client: networkClient) {
        self.client = client
    }
    
    func viewLoaded() {
        getToken()
    }
    
    private func getToken() {
        client.executeGetToken(firstParamName: "clientId",
                          secondParamName: "clientSecret",
                          firstParamValue: Constants.clientID,
                          secondParamValue: Constants.key) { (result) in
                            switch result {
                            case .success(let token):
                                self.accessToken = token
                                print(self.accessToken!)
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    func buttonTapped() {
        guard let accesstoken = self.accessToken?.token else {
            print("No access token")
            return
        }
        delegate?.pushNextViewController(accesstoken)
    }
}
