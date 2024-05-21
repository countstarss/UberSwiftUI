//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button{
            
        }label: {
            Image(systemName: "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3),radius: 6)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    MapViewActionButton()
}
