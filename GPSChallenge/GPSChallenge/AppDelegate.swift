//
//  AppDelegate.swift
//  GPSChallenge
//
//  Created by Jean-Francois Carnovale on 2020-02-13.
//  Copyright © 2020 Jean-Francois Carnovale. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    let clientSecret = "TJTCBCSAU0TZTVHYKW5WUZI3RSKU2D052ZISKCOGW3FD5ZTV"
    let clientID = "CHWAF3MR10PLLNGI2BO2OLCSW3XHSBXTCQ20ZYQ2TNFKVMW2"
    
    let locManager = CLLocationManager()
    var longitude = 0.0
    var latitude = 0.0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.startUpdatingLocation()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location = \(locValue.latitude) \(locValue.longitude)")
        longitude = locValue.longitude
        latitude = locValue.latitude
        apiRequest(longitude: longitude, latitude: latitude)
    }
    
    func apiRequest(longitude:Double, latitude:Double){
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v2/venues/search?client_id=\(clientID)&client_secret=\(clientSecret)&v=20190520&intent=checkin&ll=\(latitude),\(longitude)&query=restaurant&limit=10&radius=200")! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) {(data, response, error)
            in
            print(data ?? "no Data")
            
            if let d = data {
                let string = String(data: d, encoding: String.Encoding.utf8)
                print(string ?? "no string")
                return
            }
            print(response ?? "no response")
            print (error ?? "no error")
        }
        task.resume()
    }
}

