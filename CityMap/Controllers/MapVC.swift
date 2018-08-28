//
//  MapVC.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/28/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import UIKit
import MapKit

// MARK: - Constants

private enum Constants {
    static let defaultCoordinateSpan = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
}

class MapVC: UIViewController, MKMapViewDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var mapView: MKMapView!
    
    var cities: [City] = [] {
        didSet {
            setupMarkers(cities)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Setup user interface at launch.
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        mapView.delegate = self
        
        // Setup default region in mapView.
        let defaultRegion = MKCoordinateRegion(center: mapView.centerCoordinate, span: Constants.defaultCoordinateSpan)
        mapView.setRegion(defaultRegion, animated: false)
    }
    
    private func setupMarkers(_ cities: [City]) {
        // View must be loaded.
        guard isViewLoaded else { return }
        
        // Setup markers on map for each city.
        for city in cities {
            let location = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.subtitle = city.title
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        guard fullyRendered else { return }
        setupMarkers(cities)
    }
}
