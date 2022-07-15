//
//  SettingsView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/14/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button(action: {
            Task {
                await loadJSON()
                saveData()
            }
        }) {
            Text("Load&Save")
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
