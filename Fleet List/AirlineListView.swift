//
//  AirlineListView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

struct AirlineListView: View {
    @State var airlines: [Airline] = []
    @State var alphabet: [Letter] = []
    @State private var searchText = ""
    @State private var searching = false
    var body: some View {
        List {
            if searchText.isEmpty {
                ForEach(alphabet, id: \.letter) { alphabet in
                    Section(alphabet.letter) {
                        ForEach(searchResults, id: \.name) { airline in
                            if airline.name.first?.uppercased() == alphabet.letter {
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
                        }
                    }
                }
            } else {
                ForEach(searchResults, id: \.name) { airline in
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
            }
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .task {
            loadAirlines()
            loadLetters()
        }
        .navigationTitle("Airlines")
        .refreshable {
            Task {
                await loadAirlinesfromapi()
                saveAirlines()
                loadAirlines()
                await loadAircraftfromapi()
                saveAircraft()
                await loadUtilitiesfromapi()
                loadLetters()
            }
        }
    }
    var searchResults: [Airline] {
        if searchText.isEmpty {
            return airlines
        } else {
            return airlines.filter { $0.name.contains(searchText) }
        }
    }
    func loadAirlines() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("airlines.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            if let response = try? decoder.decode([Airline].self, from: data) {
                airlines = response
                airlines.sort {
                    $0.name < $1.name
                }
            }else {
                Task {
                    await loadAirlinesfromapi()
                    saveAirlines()
                    loadAirlines()
                }
            }
        } else {
            Task {
                await loadAirlinesfromapi()
                saveAirlines()
                loadAirlines()
            }
        }
    }
    func loadLetters() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("letters.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            if let response = try? decoder.decode([Letter].self, from: data) {
                alphabet = response
                alphabet.sort {
                    $0.letter < $1.letter
                }
            } else {
                Task {
                    await loadUtilitiesfromapi()
                    loadLetters()
                }
            }
        } else {
            Task {
                await loadUtilitiesfromapi()
                loadLetters()
            }
        }
    }
}


