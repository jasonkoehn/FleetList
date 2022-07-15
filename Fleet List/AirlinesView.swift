//
//  AirlinesView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AirlinesView: View {
    @State var airlines: [Airline] = []
    var body: some View {
        List {
            ForEach(countries, id: \.self) { country in
                Section(country) {
                    ForEach(airlines, id: \.name) { airlines in
                        if airlines.country == country {
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
            loadData()
        }
        .navigationTitle("Airlines")
        .listStyle(PlainListStyle())
        .refreshable {
            await loadJSON()
            saveData()
            loadData()
        }
    }
    func loadData() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("airlines.plist")
        let data = try! Data(contentsOf: fileUrl)
        if let response = try? PropertyListDecoder().decode([Airline].self, from: data) {
            airlines = response
        }
        
    }
}

struct AirlinesView_Previews: PreviewProvider {
    static var previews: some View {
        AirlinesView()
    }
}
