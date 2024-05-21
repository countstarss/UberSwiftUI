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
        if let coordiante = locationViewModel.selectedLocationCoordinate{
            print("DEBUG:Selected coordiante In map view is \(coordiante)")
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordiante)
            context.coordinator.configurePolyline(withDestinationCoordinate: coordiante)
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
        var userLocationCoordinate : CLLocationCoordinate2D?
        
        
        //MARK: - Lifecycle
        init(parent: UberMapViewRepresentable) {
            // 初始化,继承
            self.parent = parent
            super.init()
        }
        
        
        //MARK: - MKMapViewDelegate
        //MARK: - 设置用户区域(region)
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
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
        
        // 生成polyline
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) ->
        MKOverlayRenderer {
            
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
            
        }
        
        //MARK: - helper
        
        func addAndSelectAnnotation(withCoordinate coordinate : CLLocationCoordinate2D) {
            // 添加新的pin之前,删除原来的标注
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated:true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            getDestinationRoute(from: userLocationCoordinate , to: coordinate) { route in

                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destination :CLLocationCoordinate2D,
                                 completion :@escaping(MKRoute) -> Void) {
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            let destPlaceMark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMark)
            request.destination = MKMapItem(placemark: destPlaceMark)
            
            let direction = MKDirections(request: request)
            
            direction.calculate { response,error in
                if let error = error {
                    print("DEBUG:Failed to get direction with error : \(error.localizedDescription)")
                    return
                }
                // 这里只取了第一条route,以后可能会需要多条路线,都生成,让用户选择
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
    }
}
