//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText :String = "Current location"
    @Binding var showLocationSearchView : Bool
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
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
                    
                    
                    // LocationSearchViewModel中只声明了queryFragment,把这两个视图都添加到viewModel中之后,就可以通过文本框输入给queryFragment值
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
                        .onTapGesture {
                            //MARK: - STEP2:选择一个地点并且保存在LocationSearchViewModel中
                            // 通过点击行为选中,调用LocationSearchViewModel中的selectedLocation,传入绑定的title,也就是queryFragment
                            viewModel.selectedLocation(result.title)
                            showLocationSearchView.toggle()
                        }
                    }
                }.padding(.horizontal,8)
            }
        }
    }
}

#Preview {
    LocationSearchView(showLocationSearchView: .constant(true))
}
