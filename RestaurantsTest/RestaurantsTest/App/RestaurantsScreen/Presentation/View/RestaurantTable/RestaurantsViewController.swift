//
//  RestaurantsViewController.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout

class RestaurantsViewController: BaseViewController {
    
    var tableView = UITableView(forAutoLayout: ())
    var presenter: RestaurantsPresenter?
    var accessToken: String?
    var coordinates: String?
    var restaurantsArray: [RestaurantModel] = []
    
    init(presenter: RestaurantsPresenter, accessToken: String, coordinates: String) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.accessToken = accessToken
        self.coordinates = coordinates
        self.presenter?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        presenter?.viewLoaded(accessToken ?? "", coordinates ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar(UIColor.customColorMain)
        setStatusBar(UIColor.customColorMain)
        navigationItem.title = Constants.mainScreenTitle
        view.backgroundColor = .customBackgroundColor
    }
}

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestaurantCell
        
        let restaurant = restaurantsArray[indexPath.row]
        cell.set(restaurant)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RestaurantsViewController: RestaurantsViewControllerProtocol {
    func setupRestaurants(_ restaurants: [RestaurantModel]) {
        restaurantsArray = restaurants
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 100
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: "cell")
    }
}
