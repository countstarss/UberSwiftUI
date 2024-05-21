//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = true
    
    
    var body: some View {
        ZStack(alignment:.top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if !showLocationSearchView{
                LocationSearchView()
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color(.systemGray6))
            }else{
                LocationSearchActivationView()
                    .padding(.vertical,72)
                    .onTapGesture {
                        showLocationSearchView.toggle()
                    }
            }
            
            MapViewActionButton()
                .padding(.leading,24)
                .padding(.top,4)
                .onTapGesture {
                    showLocationSearchView.toggle()
                }
        }
    }
}

#Preview {
    HomeView()
}
