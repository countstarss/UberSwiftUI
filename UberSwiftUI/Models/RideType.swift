//
//  RideType.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/27.
//

import Foundation

enum RideType : Int,CaseIterable,Identifiable {
    var id: Int {return rawValue}
    
    case white
    case black
    case uberX
    case userXL
    
    var description :String {
        switch self{
        case .white:return "White"
        case .black:return "UberBlack"
        case .uberX:return "UberX"
        case .userXL:return "UberXL"
        }
    }
    
    var imageName : String {
        switch self{
        case .white:return "uber"
        case .black:return "uber"
        case .uberX:return "uber"
        case .userXL:return "uber"
        }
    }
    
    var price : Int {
        switch self{
        case .white:return 6
        case .black:return 6
        case .uberX:return 9
        case .userXL:return 12
        }
    }
    
    var baseFare :Double {
        switch self{
        case .white:return 5
        case .black:return 15
        case .uberX:return 10
        case .userXL:return 20
        }
    }
    
    func computePrice(for distanceInMeters:Double) -> Double {
        let diatanceInMiles = distanceInMeters / 1600
        
        switch self{
        case .white:return diatanceInMiles * 1.5 + baseFare
        case .black:return diatanceInMiles * 2.5 + baseFare
        case .uberX:return diatanceInMiles * 2.0 + baseFare
        case .userXL:return diatanceInMiles * 3.0 + baseFare
        }
    }
}
