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
            case .white:return "White"
            case .black:return "UberBlack"
            case .uberX:return "UberX"
            case .userXL:return "UberXL"
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
}
