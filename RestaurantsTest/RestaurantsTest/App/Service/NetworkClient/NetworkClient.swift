//
//  NetworkClient.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import Foundation

class networkClient {
    
    func executeGetToken(firstParamName: String, secondParamName: String, firstParamValue: String, secondParamValue: String, completion: @escaping(Result<tokenModel, networkError>) -> Void) {
        
        guard let baseURL = URLComponents(string: Constants.baseURL + Constants.tokensPath) else {
            completion(.failure(.badURL))
            return
        }
        
        var components = baseURL
        components.queryItems = [URLQueryItem(name: firstParamName, value: firstParamValue),
                                 URLQueryItem(name: secondParamName, value: secondParamValue)]
        let request = URLRequest(url: components.url!)
        
        print("-----------------------------------------------------------------")
        print("Request Start:")
        print("URL: ", request)

        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if (err != nil) {
                completion(.failure(.requestError))
            }

            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            print("JSON String: \(String(data: data, encoding: .utf8))")
            
            do {
                let restauranData = try JSONDecoder().decode(tokenModel.self, from: data)
                completion(.success(restauranData))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            print("Request End")
            print("-----------------------------------------------------------------")
        }.resume()
    }
    
    func executeGetRestaurants(firstParamName: String, secondParamName: String, firstParamValue: String, secondParamValue: String, token: String, completion: @escaping(Result<RestaurantRequestModel, networkError>) -> Void) {
        
        guard let baseURL = URLComponents(string: Constants.baseURL + Constants.restaurantsPath) else {
            completion(.failure(.badURL))
            return
        }
        
        var components = baseURL
        components.queryItems = [URLQueryItem(name: firstParamName, value: firstParamValue),
                                 URLQueryItem(name: secondParamName, value: secondParamValue),
                                 URLQueryItem(name: "max", value: "20"),
                                 URLQueryItem(name: "fields", value: "name,deliveryTime,deliveryAreas,generalScore,coordinates")]
        var request = URLRequest(url: components.url!)
        
        print("-----------------------------------------------------------------")
        print("Request Start:")
        print("URL: ", request)
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("HTTP Headers: ", request.allHTTPHeaderFields)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if (err != nil) {
                completion(.failure(.requestError))
            }

            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            print("JSON String: \(String(data: data, encoding: .utf8))")
            
            do {
                let restauranData = try JSONDecoder().decode(RestaurantRequestModel.self, from: data)
                completion(.success(restauranData))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            print("Request End")
            print("-----------------------------------------------------------------")
        }.resume()
    }
}

enum networkError: Error {
    case badURL
    case requestError
    case noDataAvailable
    case canNotProcessData
}
