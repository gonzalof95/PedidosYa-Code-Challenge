//
//  RestaurantsMapViewController.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 26/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout
import MapKit
import CoreLocation

class RestaurantsMapViewController: BaseViewController, MKMapViewDelegate {
    
    var presenter: RestaurantsPresenter?
    var accessToken: String?
    var restaurantsArray: [RestaurantModel] = []
    let mapView = MKMapView(forAutoLayout: ())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    init(presenter: RestaurantsPresenter, accessToken: String) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
        self.accessToken = accessToken
        //self.presenter?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar(UIColor.customColorMain)
        setStatusBar(UIColor.customColorMain)
        navigationItem.title = Constants.mainScreenTitle
        view.backgroundColor = .customBackgroundColor
        
        
    }
    
    func setView() {
        view.addSubview(mapView)
        
        mapView.autoPinEdgesToSuperviewEdges()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.mapType = .standard
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            
        }
    }
}

//extension RestaurantsMapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        <#code#>
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        <#code#>
//    }
//}
