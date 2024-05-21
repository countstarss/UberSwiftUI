//
//  LocationSearchActivationView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            
            Rectangle()
                .fill(.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.6), radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
