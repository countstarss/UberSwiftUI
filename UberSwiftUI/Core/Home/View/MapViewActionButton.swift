//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var showLocationSearchView : Bool
    var body: some View {
            Image(systemName: !showLocationSearchView ? "chevron.backward" : "line.3.horizontal")
//            Image(systemName:"chevron.backward")
//            Image(systemName:"line.3.horizontal")
                .font(.title3)
                .foregroundColor(.black)
                .frame(width: 12,height:12)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .padding(.leading,4)
                .shadow(color: .black.opacity(0.3),radius: 6)
                .frame(maxWidth: .infinity,alignment: .leading)
                .onTapGesture {
                    if !showLocationSearchView {
                        showLocationSearchView.toggle()
                    }
                }
                
    }
}

#Preview {
    MapViewActionButton(showLocationSearchView: .constant(true))
}
