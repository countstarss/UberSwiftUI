//
//  UberSwiftUIApp.swift
//  UberSwiftUI
//
//  Created by 王佩豪 on 2024/5/21.
//

import SwiftUI

@main
struct UberSwiftUIApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                // 添加环境之后,这个环境对象属性允许使用这个实例查看模型
                .environmentObject(locationViewModel)
        }
    }
}
