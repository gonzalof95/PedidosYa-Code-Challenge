//
//  MainViewController.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 25/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout
import CoreLocation
import MapKit

class MainViewController: BaseViewController {
    
    var customView: MainView?
    var presenter: MainPresenter?
    var tableView = UITableView()
    var restaurantsArray: [RestaurantModel] = []
    let locationManager = CLLocationManager()
    let mapView = MKMapView(forAutoLayout: ())
    
    init(with presenter: MainPresenter) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.presenter?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        checkLocationServices()
        presenter?.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar(UIColor.customColorMain)
        setStatusBar(UIColor.customColorMain)
        customView?.button.activate()
        customView?.button2.activate()
        customView?.button3.activate()
        navigationItem.title = Constants.mainScreenTitle
        view.backgroundColor = .customBackgroundColor
    }
    
    func setView() {
        view.backgroundColor = .customBackgroundColor
        self.customView = MainView()
        guard let strongCustomView = customView else { return }
        
        view.addSubview(strongCustomView)
        customView?.autoPinEdgesToSuperviewEdges()
        addButtonAction()
    }
    
    func addButtonAction() {
        customView?.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        customView?.button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        customView?.button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("button tapped")
        presenter?.buttonTapped()
    }
    
    @objc func button2Tapped() {
        print("button 2 tapped")
        presenter?.button2Tapped()
    }
    
    @objc func button3Tapped() {
        print("button 3 tapped")
        presenter?.button3Tapped()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            presenter?.checkLocationAuthorization()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

extension MainViewController: MainViewControllerProtocol {
    
    func pushMapViewController(_ accessToken: String?, _ coordinates: String?) {
        customView?.button2.deactivate()
        
        let presenter = RestaurantsPresenter(networkClient())
        let viewController = RestaurantsMapViewController(presenter: presenter, accessToken: accessToken!, coordinates: coordinates!)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushNextViewController(_ accessToken: String?, _ coordinates: String?) {
        customView?.button.deactivate()
        
        let presenter = RestaurantsPresenter(networkClient())
        let viewController = RestaurantsViewController(presenter: presenter, accessToken: accessToken!, coordinates: coordinates!)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushCustomLocationViewController(_ accessToken: String?) {
        customView?.button3.deactivate()
        
        let viewController = MapChooserViewController(accessToken: accessToken!)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        presenter?.checkLocationAuthorization()
    }
}
