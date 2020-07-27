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

class RestaurantsMapViewController: BaseViewController {
    
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
        mapView.delegate = self
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
        if let coordinates = coordinates {
            mapView.showsUserLocation = false
            let customCoordinates = toCoordinate(stringCoordinates: coordinates)
            let region = MKCoordinateRegion.init(center: customCoordinates, latitudinalMeters: Constants.mapRegion, longitudinalMeters: Constants.mapRegion)
            mapView.setRegion(region, animated: true)
        } else if let location = locationManager.location?.coordinate {
            mapView.showsUserLocation = true
            print("Ubicacion re loca: ", location)
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: Constants.mapRegion, longitudinalMeters: Constants.mapRegion)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func toCoordinate(stringCoordinates: String) -> CLLocationCoordinate2D {
        let coordinates = stringCoordinates.components(separatedBy: ",")
        let lat = Double(coordinates[0])
        let long = Double(coordinates[1])
        let location = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
        return location
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
            let coordinates = toCoordinate(stringCoordinates: restaurant.coordinates)
            let annotation = RestaurantAnnotation(name: restaurant.name, coordinate: coordinates)
            mapView.addAnnotation(annotation)
        }
    }
    
    func reloadTable(_ restaurants: [RestaurantModel]) {
    }
}

extension RestaurantsMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? RestaurantAnnotation else { return nil }
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "marker") as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
}
