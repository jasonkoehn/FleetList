//
//  FleetView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct FleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleet_size: Int
    var data_url: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("IATA")
                    .italic()
                    .font(.subheadline)
                Text(iata)
                Spacer()
                Text("ICOA")
                    .italic()
                    .font(.subheadline)
                Text(icao)
                Spacer()
                Text("Callsign")
                    .italic()
                    .font(.subheadline)
                Text(callsign)
                Spacer()
            }
            List {
                ForEach(aircraft, id: \.hex) { aircraft in
                    NavigationLink(destination: {AircraftView(name: name, type: aircraft.type, registration: aircraft.registration, delivery_date: aircraft.delivery_date, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn)}) {
                        HStack {
                            Text(aircraft.registration)
                                .font(.system(size: 25))
                            Text(aircraft.type)
                        }
                    }
                }
            }
            .navigationTitle(name)
            .task {
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: data_url) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Aircraft].self, from: data) {
                aircraft = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Aircraft: Codable {
    var type: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var ln: Int
    var fn: Int
}

