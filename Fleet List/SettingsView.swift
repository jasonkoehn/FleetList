//
//  SettingsView.swift
//  Fleet List
//
//  Created by Jason Koehn on 8/3/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var isPro: Bool = UserDefaults.standard.bool(forKey: "IsPro")
    var body: some View {
        List {
            Toggle("Pro", isOn: $isPro)
                .font(.system(size: 25))
                .onChange(of: isPro) { newValue in
                    UserDefaults.standard.set(self.isPro, forKey: "IsPro")
                }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
