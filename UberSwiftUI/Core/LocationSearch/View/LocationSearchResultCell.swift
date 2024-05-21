//
//  LocationSearchResultCell.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title :String
    let subTitle : String
    
    
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            
            VStack(alignment:.leading,spacing: 4){
                Text(title)
                    .font(.body)
                
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                
                Divider()
            }
            .padding(.leading,8)
            .padding(.vertical,8)
//            .background(.blue)
        }
        .padding(.horizontal)
    }
}

#Preview {
    LocationSearchResultCell(title: "StartBucks", subTitle: "Park")
}
