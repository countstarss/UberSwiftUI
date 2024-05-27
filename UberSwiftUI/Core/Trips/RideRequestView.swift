//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/27.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRideType: RideType = .white
    
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
            
            // Trip info View
            HStack{
                //MARK: - indicator
                VStack{
                    Circle()
                        .fill(Color(.systemGray2))
                        .frame(width: 8,height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 2,height: 28)
                        .cornerRadius(5)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8,height: 8)
                    
                }
                VStack(alignment:.leading){
                    HStack {
                        Text("Current Location")
                            .frame(height: 40)
                            .padding(.vertical,2)
                            .padding(.horizontal,16)
                        
                        Spacer()
                        Text("1:30 PM")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack {
                        Text("Destination Location")
                            .frame(height: 40)
                            .padding(.vertical,2)
                            .padding(.horizontal,16)
                        
                        Spacer()
                        Text("2:20 PM")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
                
                
            }
            .padding(.vertical,8)
            .padding(.horizontal,24)
            
            //MARK: - ride type selection view
            
            Divider()
            
            Text("SUGGESTION RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity,alignment:.leading)
            
            ScrollView(.horizontal){
                HStack(spacing:8){
                    ForEach(RideType.allCases){ type in
                        VStack(alignment:.leading){
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90,height: 100)
                                .background(Color(.systemPink))
                                .cornerRadius(15)
                            VStack(spacing:4){
                                Text(type.description)
                                Text("$\(type.price)/mile")
                            }
                            .font(.system(size: 14).weight(.semibold))
                            .padding(4)
                        }
                        .padding(4)
                        // 根据状态切换效果
                        .foregroundColor(type == selectedRideType ?
                            .white  : .black)
                        .background(Color(type == selectedRideType ?
                             .systemBlue : .systemGroupedBackground
                        ))
                        .scaleEffect(type == selectedRideType ?
                            1.08 : 1
                        )
                        .cornerRadius(15)
                        .onTapGesture {
                            withAnimation{
                                selectedRideType = type
                            }
                        }
                        
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
            
            Divider()
                .padding(4)
            
            //MARK: - payment option view
            HStack(spacing:12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)

            //MARK: - request ride button
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 50)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            .padding(.bottom,30)
            

        }
        .background(.ultraThinMaterial)
//        .background(.blue)
        .cornerRadius(30)
    }
}


#Preview {
    RideRequestView()
}
