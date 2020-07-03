//
//  TabView.swift
//  big stonks
//
//  Created by roli on 20.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var store = DataStore()
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(named: "background1")
    }
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            PortfolioView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Portfolio")
            }
            
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            
            
        }.accentColor(.primary)
            .environmentObject(store)
    }
}
