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
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    
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
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG:Location Search Faild with Error : \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
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
    
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel:MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // 把搜索结果放到上面Model中声明的数组results中
        self.results = completer.results
    }
}
