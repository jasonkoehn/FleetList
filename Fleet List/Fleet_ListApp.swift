//
//  Fleet_ListApp.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

@main
struct Fleet_ListApp: App {
    init() {
        Task {
            await loadAirlinesfromapi()
            saveAirlines()
            await loadCountriesfromapi()
            saveCountries()
        }
    }
    var body: some Scene {
        WindowGroup {
            UserView()
        }
    }
}
