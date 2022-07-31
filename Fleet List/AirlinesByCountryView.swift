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
            ForEach(airlines, id: \.name) { airlines in
                if airlines.country == countryName {
                    NavigationLink(destination: AirlineFleetView(name: airlines.name, country: airlines.country, website: airlines.website, iata: airlines.iata, icao: airlines.icao, callsign: airlines.callsign, types: airlines.types)) {
                        HStack {
                            Image(airlines.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            Text(airlines.name)
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
