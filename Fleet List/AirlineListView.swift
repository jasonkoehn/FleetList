//
//  AirlineListView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

struct AirlineListView: View {
    @State var airlines: [Airline] = []
    var body: some View {
        List {
            ForEach(alphabet, id: \.self) { alphabet in
                Section(alphabet) {
                    ForEach(airlines, id: \.name) { airline in
                        if airline.name.first?.uppercased() == alphabet {
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
            }.frame(height: 30)
        }
        .listStyle(PlainListStyle())
        .task {
            loadAirlines()
        }
        .navigationTitle("Airlines")
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

struct AirlineListView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineListView()
    }
}
