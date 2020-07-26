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
    let locationManager = CLLocationManager()
    var coordinates: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        setView()
        presenter?.viewLoaded(accessToken ?? "", coordinates ?? "")
    }
    
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
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            centerViewOnUserLocation()
        }
    }
    
    func centerViewOnUserLocation() {
        mapView.showsUserLocation = true
        if let location = locationManager.location?.coordinate {
            print("Ubicacion re loca: ", location)
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: Constants.mapRegion, longitudinalMeters: Constants.mapRegion)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension RestaurantsMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: Constants.mapRegion, longitudinalMeters: Constants.mapRegion)
        mapView.setRegion(region, animated: true)
    }
}

extension RestaurantsMapViewController: RestaurantsViewControllerProtocol {
    func setupRestaurants(_ restaurants: [RestaurantModel]) {
        
        for restaurant in restaurants {
            let annotation = MKPointAnnotation()
            let coordinates = restaurant.coordinates.components(separatedBy: ",")
            let lat = Double(coordinates[0])
            let long = Double(coordinates[1])
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            mapView.addAnnotation(annotation)
        }
    }
}
