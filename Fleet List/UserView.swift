//
//  UserView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/14/22.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        TabView {
            NavigationView {
                AirlinesView()
            }
            .tabItem {
                Image(systemName: "airplane")
            }
//            NavigationView {
//                SendView()
//            }.tabItem {
//                Image(systemName: "gear")
//            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
