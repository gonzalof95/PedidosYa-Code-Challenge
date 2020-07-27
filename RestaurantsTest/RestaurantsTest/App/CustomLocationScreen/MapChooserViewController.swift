//
//  MapChooserViewController.swift
//  RestaurantsTest
//
//  Created by Gonzalo Ivan Fuentes on 27/07/2020.
//  Copyright © 2020 gonzalo. All rights reserved.
//

import UIKit
import PureLayout
import CoreLocation
import MapKit

class MapChooserViewController: BaseViewController, CLLocationManagerDelegate {
    
    let viewContainer = UIView(forAutoLayout: ())
    let mapView = MKMapView(forAutoLayout: ())
    let button1 = CustomButton(forAutoLayout: ())
    let button2 = CustomButton(forAutoLayout: ())
    let locationManager = CLLocationManager()
    let pinImageView = UIImageView(forAutoLayout: ())
    var accessToken: String?
    var coordinates: String?
    
    init(accessToken: String) {
        super.init(nibName: nil, bundle: nil)
        self.accessToken = accessToken
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        setView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar(UIColor.customColorMain)
        setStatusBar(UIColor.customColorMain)
        button1.activate()
        button2.activate()
        navigationItem.title = Constants.mainScreenTitle
        view.backgroundColor = .customBackgroundColor
        
        mapView.layer.cornerRadius = 20
    }
    
    func setView() {
        view.addSubview(mapView)
        view.addSubview(button1)
        view.addSubview(button2)
        mapView.addSubview(pinImageView)
        
        button1.setTitle("Show in Table", for: .normal)
        button2.setTitle("Show in Map", for: .normal)
        
        pinImageView.image = UIImage(named: "pin")
        
        addButtonAction()
        mapView.delegate = self
    }
    
    func setConstraints() {
        mapView.autoAlignAxis(.vertical, toSameAxisOf: view)
        mapView.autoPinEdge(.top, to: .top, of: view, withOffset: 100)
        mapView.autoPinEdge(.leading, to: .leading, of: view, withOffset: 25)
        mapView.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -25)
        mapView.autoPinEdge(.bottom, to: .bottom, of: button1, withOffset: -80)
         
        button1.autoAlignAxis(.vertical, toSameAxisOf: view)
        button1.autoSetDimension(.height, toSize: 44)
        button1.autoPinEdge(.leading, to: .leading, of: view, withOffset: 25)
        button1.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -25)
        button1.autoPinEdge(.bottom, to: .top, of: button2, withOffset: -12)
        
        button2.autoAlignAxis(.vertical, toSameAxisOf: view)
        button2.autoSetDimension(.height, toSize: 44)
        button2.autoPinEdge(.leading, to: .leading, of: view, withOffset: 25)
        button2.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -25)
        button2.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -32)
        
        pinImageView.autoAlignAxis(.vertical, toSameAxisOf: view)
        pinImageView.autoSetDimensions(to: CGSize(width: 25, height: 35))
        pinImageView.autoCenterInSuperview()
    }
    
    func addButtonAction() {
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        button1.deactivate()
        let presenter = RestaurantsPresenter(networkClient())
        let viewController = RestaurantsViewController(presenter: presenter, accessToken: accessToken!, coordinates: coordinates!)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func button2Tapped() {
        button2.deactivate()
        let presenter = RestaurantsPresenter(networkClient())
        let viewController = RestaurantsMapViewController(presenter: presenter, accessToken: accessToken!, coordinates: coordinates!)
        navigationController?.pushViewController(viewController, animated: true)
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
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: Constants.mapRegion, longitudinalMeters: Constants.mapRegion)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapChooserViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        coordinates = "\(latitude.truncate(places: 6)),\(longitude.truncate(places: 6))"
    }
}
