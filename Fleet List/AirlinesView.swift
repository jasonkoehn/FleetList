//
//  AirlinesView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AirlinesView: View {
    @State var airlines: [Airline] = []
    @State var countries: [Country] = []
    var body: some View {
        List {
            ForEach(countries, id: \.name) { country in
                Section(country.name) {
                    ForEach(airlines, id: \.name) { airlines in
                        if airlines.country == country.name {
                            NavigationLink(destination: FleetView(name: airlines.name, country: airlines.country, website: airlines.website, iata: airlines.iata, icao: airlines.icao, callsign: airlines.callsign, alias: airlines.alias)) {
                                Text(airlines.name)
                                    .font(.system(size: 23))
                            }
                        }
                    }
                }
            }
        }
        .task {
            loadCountries()
            loadAirlines()
        }
        .navigationTitle("Airlines")
        .listStyle(PlainListStyle())
        .refreshable {
            Task {
                await loadCountriesfromapi()
                saveCountries()
                loadCountries()
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
        let data = try! Data(contentsOf: fileUrl)
        let decoder = PropertyListDecoder()
        let response = try! decoder.decode([Airline].self, from: data)
        airlines = response
        print(response)
    }
    func loadCountries() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("countries.plist")
        let data = try! Data(contentsOf: fileUrl)
        let decoder = PropertyListDecoder()
        let response = try! decoder.decode([Country].self, from: data)
        countries = response
        print(response)
    }
}

struct AirlinesView_Previews: PreviewProvider {
    static var previews: some View {
        AirlinesView()
    }
}
