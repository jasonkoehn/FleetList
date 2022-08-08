//
//  AppView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
//            NavigationView {
//                HomeView()
//            }
//            .tabItem {
//                Image(systemName: "house")
//                Text("Home")
//            }
            NavigationView {
                AirlineListView()
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Airlines")
            }
            NavigationView {
                CountriesListView()
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("Countries")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
