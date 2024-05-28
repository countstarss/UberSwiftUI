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
//    let locationManager = LocationManager.shared
    //MARK: - STEP3:包含LocationSearchViewModel并且观察它,体现在下面的updateUIView中
    // 创建视图模型的单独实例
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    @Binding var mapState :MapViewState
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG : MapState is \(mapState)")
        // 通过这一步可以验证我们选中的地点已经传到了mapView中,
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            // 点击搜索结果进入locationSelected状态再添加标记和规划路径
            if let coordiante = locationViewModel.selectedUberLocation?.coordinate{
                
//                print("DEBUG:Selected coordiante In map view is \(coordiante)")
                print("DEBUG: Adding stuff to map...")
                // SelectAnnotation
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordiante)
                // 配置Polyline 04
                context.coordinator.configurePolyline(withDestinationCoordinate: coordiante)
                
            }
            break
        case .polylineAdded:
            break
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
        var currentRegion :MKCoordinateRegion?
        
        
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
            
            self.currentRegion = region
            
            // 设置用户区域,允许使用动画
            parent.mapView.setRegion(region, animated: true)
        }
        
        // 生成polyline 03
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
            
            
            // 地图显示动画
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        // 配置Polyline 02
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate , to: coordinate) { route in

                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                //MARK: - 设置聚焦区域
                let rect = self.parent.mapView.mapRectThatFits(
                    route.polyline.boundingMapRect,
                    edgePadding: .init(
                        top: 64,
                        left: 32,
                        bottom: 500,
                        right: 32
                    )
                )
                //MARK: - 限定聚焦区域
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        // 配置Polyline 01
        
        
        func clearMapViewAndRecenterUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            // region 是初始化的region, 声明一个currentRegion之后,保存原始region
            // 后续添加了mappin和Polyline,如果想要返回原始状态,就setRegion为currentRegion
            if let currentRegion = currentRegion{
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
}
