//
//  Double.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/27.
//

import Foundation

extension Double {
    private var currencyFormatter : NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(for: self) ?? ""
    }
}
