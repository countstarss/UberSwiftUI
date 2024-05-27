//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct MapViewActionButton: View {
    
//    @Binding var showLocationSearchView : Bool
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    
    var body: some View {
            Image(systemName: imageNameForState(mapState))
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
                    actionForState(mapState)
                }
                
    }
    
    func actionForState(_ state:MapViewState) {
        switch state{
        case .noInput:
            print("DEBUG : noInput")
        case .searchingForLocation :
            mapState = .noInput
            print("DEBUG : back to HomeView")
        case .locationSelected :
            mapState = .noInput
            viewModel.selectedLocationCoordinate = nil
        }
    }
    func imageNameForState(_ state: MapViewState)-> String{
        switch state{
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation,.locationSelected :
            return "chevron.backward"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}
