//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText :String = "Current location"
    @State private var endLocationText :String = "Where to?"
    
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
                        .fill(Color(.black))
                        .frame(width: 6,height: 6)
                }
                
                
                VStack{
                    TextField("Current Location",text: $startLocationText)
                        .frame(height: 40)
                        .padding(.vertical,2)
                        .padding(.horizontal,16)
                        .background(Color(.systemGroupedBackground))
                        .shadow(color: .black.opacity(0.2), radius: 4)
                    
                    TextField("Destination Location",text: $endLocationText)
                        .frame(height: 40)
                        .padding(.vertical,2)
                        .padding(.horizontal,16)
                        .background(Color(.systemGray4))
                        .shadow(color: .black.opacity(0.2), radius: 4)
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
                    ForEach(0 ... 6,id:\.self) { _ in
                        LocationSearchResultCell()
                    }
                }.padding(.horizontal,8)
            }
        }
    }
}

#Preview {
    LocationSearchView()
}
