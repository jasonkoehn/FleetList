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
                    ForEach(airlines, id: \.name) { airlines in
                        if airlines.name.first?.uppercased() == alphabet {
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
