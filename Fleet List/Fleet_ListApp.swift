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
        }
    }
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}
