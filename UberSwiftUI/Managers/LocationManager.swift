//
//  LocationManager.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import CoreLocation

class LocationManager : NSObject ,ObservableObject {
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        // 访问用户位置
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}


extension LocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        guard location.isEmpty else { return }
//        print(location.first)
        locationManager.stopUpdatingLocation()
    }
}

