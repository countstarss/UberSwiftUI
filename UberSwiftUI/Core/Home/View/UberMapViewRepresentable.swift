//
//  UberMapViewRepresentable.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI
import MapKit


struct UberMapViewRepresentable: UIViewRepresentable {
    
    
    let mapView = MKMapView()
    
    let locationManager = LocationManager()
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}


extension UberMapViewRepresentable {
    
    //MARK: - Coordinator 协调员 ,继承以下两个协议
    class MapCoordinator : NSObject , MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable) {
            // 初始化,继承
            self.parent = parent
            super.init()
        }
        
        //MARK: - 设置用户区域(region)
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            // 设置用户区域,允许使用动画
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
