//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import Foundation
import MapKit


//MARK: - STEP1: CREATE LocationSearchViewModel
class LocationSearchViewModel:NSObject ,ObservableObject {
    
    //MARK: - Proporities
    
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation : UberLocation?
    @Published var pickUpTime : String?
    @Published var dropOffTime : String?
    
    // 用来搜索
    private let searchCompleter = MKLocalSearchCompleter()
    // 查询片段
    var queryFragment : String = "" {
        // didSet意味着queryFragment每次改变都会调用下面的代码
        didSet{
//            print("DEBUG:queryFragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation:CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Senction Heading
    func selectedLocation(_ localSearch : MKLocalSearchCompletion){
        // 调用下面的函数 ,闭包写返回值和error,最后得到coordinate,
        // 并把coordinate传递给公开的CLLocationCoordinate2D类型 :selectedLocationCoordinate
        // 然后就可以在mapView中得到经纬度的具体值
        locationSearch(forLocalSearchCompletion: localSearch) {
            response,
            error in
            if let error = error {
                print("DEBUG:Location Search Faild with Error : \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(
                title: localSearch.title,
                coordinate: coordinate
            )
            print("DEBUG:Localtion coordinate \(coordinate)")
        }
    }
    
    // 通过获取的result,逐个进行自然语言搜索
    func locationSearch(forLocalSearchCompletion localSearch :MKLocalSearchCompletion,
                        completion:@escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        // 开启搜索
        search.start(completionHandler: completion)
    }
    
    
    func computeRidePrice(forType type:RideType) -> Double{
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
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
            self.configurePickupAndDropiffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropiffTimes(with expectedTravelTime : Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
    
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel:MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // 把搜索结果放到上面Model中声明的数组results中
        self.results = completer.results
    }
}
