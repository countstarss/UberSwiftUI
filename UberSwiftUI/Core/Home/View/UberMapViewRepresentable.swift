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
    //MARK: - STEP3:包含LocationSearchViewModel并且观察它,体现在下面的updateUIView中
    // 创建视图模型的单独实例
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // 通过这一步可以验证我们选中的地点已经传到了mapView中,
        if let selectedLocation = locationViewModel.selectedLocation{
            print("DEBUG:selectedLocation In map view is \(selectedLocation)")
        }
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
