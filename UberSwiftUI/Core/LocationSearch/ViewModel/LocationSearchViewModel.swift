//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import Foundation
import MapKit

class LocationSearchViewModel:NSObject ,ObservableObject {
    
    //MARK: - Proporities
    
    @Published var results = [MKLocalSearchCompletion]()
    // 用来搜索
    private let searchCompleter = MKLocalSearchCompleter()
    // 查询片段
    var queryFragment : String = "" {
        // didSet意味着queryFragment每次改变都会调用下面的代码
        didSet{
            print("DEBUG:queryFragment is \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
}

//MARK: - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel:MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // 把搜索结果放到上面Model中声明的数组results中
        self.results = completer.results
    }
}
