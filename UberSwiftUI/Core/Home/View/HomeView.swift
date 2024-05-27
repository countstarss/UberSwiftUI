//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct HomeView: View {
//    @State private var showLocationSearchView = true
    // View State Management 01
    @State private var mapState = MapViewState.noInput
    
    
    var body: some View {
        ZStack(alignment:.top) {
            UberMapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            // View State Management 02
            if mapState == .noInput{
                // 首页搜索框
                LocationSearchActivationView()
                    .padding(.vertical,72)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.15)) {
                            mapState = .searchingForLocation
                        }
                    }
            }else if mapState == .searchingForLocation{
                // 两个搜索框的页面
                LocationSearchView(mapState: $mapState)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(Color(.systemGray6))
                
            }
            
            MapViewActionButton(mapState: $mapState)
                .padding(.leading,24)
                .padding(.top,4)
        }
    }
}

#Preview {
    HomeView()
}
