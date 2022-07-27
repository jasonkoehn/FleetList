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
            await loadCountriesfromapi()
            saveCountries()
            await loadAirlinesfromapi()
            saveAirlines()
            await loadAircraftfromapi()
            saveAircraft()
            await loadTypesfromapi()
            saveTypes()
        }
    }
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
