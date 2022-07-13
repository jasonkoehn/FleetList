//
//  AirlineView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AirlineView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Canada") {
                    ForEach(canadaAirlines, id: \.alias) { airlines in
                        NavigationLink(destination: {FleetView(name: airlines.name, country: airlines.country, website: airlines.website, iata: airlines.iata, icao: airlines.icao, callsign: airlines.callsign, fleetsize: airlines.fleetsize, alias: airlines.alias)}) {
                            Text(airlines.name)
                                .font(.system(size: 23))
                        }
                    }
                }
                Section("United States") {
                    ForEach(usAirlines, id: \.alias) { airlines in
                        NavigationLink(destination: {FleetView(name: airlines.name, country: airlines.country, website: airlines.website, iata: airlines.iata, icao: airlines.icao, callsign: airlines.callsign, fleetsize: airlines.fleetsize, alias: airlines.alias)}) {
                            Text(airlines.name)
                                .font(.system(size: 23))
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Airlines")
        }
    }
}

struct AirlineView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineView()
    }
}
