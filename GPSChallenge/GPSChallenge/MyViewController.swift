//
//  MyViewController.swift
//  GPSChallenge
//
//  Created by Jean-Francois Carnovale on 2020-02-13.
//  Copyright © 2020 Jean-Francois Carnovale. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MyViewController: UIViewController, CLLocationManagerDelegate{
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location = \(locValue.latitude) \(locValue.longitude)")
    }
}
