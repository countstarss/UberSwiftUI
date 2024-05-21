//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText :String = "Current location"
    @State private var destinationLocationText :String = ""
    @StateObject var viewModel = LocationSearchViewModel()
    
    var body: some View {
        VStack{
//            Color(.darkGray).ignoresSafeArea()
            
            // header view
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray2))
                        .frame(width: 6,height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 2,height: 28)
                        .cornerRadius(5)
                    
                    Rectangle()
                        .frame(width: 6,height: 6)
                        .foregroundStyle(.black)
                }
                
                
                VStack{
                    TextField("Current Location",text: $startLocationText)
                        .frame(height: 40)
                        .padding(.vertical,2)
                        .padding(.horizontal,16)
                        .background(Color(.systemGroupedBackground))
                        .shadow(color: .gray.opacity(0.4), radius: 6)
                    
                    TextField("Destination Location",text: $viewModel.queryFragment)
                        .frame(height: 40)
                        .padding(.vertical,2)
                        .padding(.horizontal,16)
                        .background(Color(.systemGray4))
                        .shadow(color: .gray.opacity(0.4), radius: 6)
                }
            }
                .frame(width: UIScreen.main.bounds.width - 48)
                .padding(.top,64)
                .padding(.bottom,8)
            
            Divider()
                .padding(.vertical)

            // list view
            ScrollView{
                VStack{
                    ForEach(viewModel.results,id:\.self) { result in
                        LocationSearchResultCell(
                            title: result.title,
                            subTitle: result.subtitle
                        )
                    }
                }.padding(.horizontal,8)
            }
        }
    }
}

#Preview {
    LocationSearchView()
}
