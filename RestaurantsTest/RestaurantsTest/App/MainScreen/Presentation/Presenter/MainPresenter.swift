//
//  MainPresenter.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation
import CoreLocation

class MainPresenter {
    
    weak var delegate: MainViewControllerProtocol?
    var accessToken: tokenModel?
    let client: networkClient
    let locationManager = CLLocationManager()
    var coordinates: String?
    
    required init(_ client: networkClient) {
        self.client = client
    }
    
    func viewLoaded() {
        checkLocationAuthorization()
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
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print("authoriced")
            locationManager.startUpdatingLocation()
            if let location = locationManager.location?.coordinate {
                print("Ubicacion re loca: ", location)
                coordinates = "\(location.latitude),\(location.longitude)"
                print(coordinates)
            }
            getToken()
            break
        case .notDetermined:
            print("notdetermined")
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
    
    func buttonTapped() {
        guard let accesstoken = self.accessToken?.token, let coordinates = self.coordinates else {
            print("No access token or Coordinates")
            return
        }
        
        delegate?.pushNextViewController(accesstoken, coordinates)
    }
    
    func button2Tapped() {
        guard let accesstoken = self.accessToken?.token, let coordinates = self.coordinates else {
             print("No access token or Coordinates")
             return
         }
        delegate?.pushMapViewController(accesstoken, coordinates)
    }
    
    func button3Tapped() {
        guard let accesstoken = self.accessToken?.token else {
             print("No access token")
             return
         }
        delegate?.pushCustomLocationViewController(accesstoken)
    }
}
