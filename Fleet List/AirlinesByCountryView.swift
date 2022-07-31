//
//  AirlinesByCountryView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/30/22.
//

import SwiftUI

struct AirlinesByCountryView: View {
    @State var airlines: [Airline] = []
    var countryName: String
    var body: some View {
        List {
            ForEach(airlines, id: \.name) { airline in
                if airline.country == countryName {
                    NavigationLink(destination: AirlineView(name: airline.name, country: airline.country, website: airline.website, iata: airline.iata, icao: airline.icao, callsign: airline.callsign, fleetsize: airline.fleetsize, types: airline.types)) {
                        HStack {
                            Image(airline.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            Text(airline.name)
                                .font(.system(size: 23))
                        }
                    }
                }
            }.frame(height: 30)
        }
        .listStyle(PlainListStyle())
        .task {
            loadAirlines()
        }
        .navigationTitle(countryName)
        .refreshable {
            Task {
                await loadAirlinesfromapi()
                saveAirlines()
                loadAirlines()
            }
        }
    }
    func loadAirlines() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("airlines.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            let response = try! decoder.decode([Airline].self, from: data)
            airlines = response
            airlines.sort {
                $0.name < $1.name
            }
        } else {
            Task {
                await loadAirlinesfromapi()
                saveAirlines()
                loadAirlines()
            }
        }
    }
}
