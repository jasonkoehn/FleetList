//
//  FleetView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct FleetView: View {
    @State private var results = [Aircraft]()
    @State private var airlineName = ""
    @State private var iata = ""
    @State private var icao = ""
    @State private var callsign = ""
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text(airlineName)
                        .font(.title)
                    HStack {
                        Spacer()
                        Text(iata)
                        Spacer()
                        Text(icao)
                        Spacer()
                        Text(callsign)
                        Spacer()
                    }
                }
                ForEach(results, id: \.hex) { item in
                    VStack(alignment: .leading) {
                        Text(item.registration)
                            .font(.title)
                    }
                }
            }
            .navigationBarTitle(Text(airlineName))
            .task {
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/BreezeAirways.json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.aircraft
                airlineName = decodedResponse.airline
                iata = decodedResponse.iata
                icao = decodedResponse.icao
                callsign = decodedResponse.callsign
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var airline: String
    var iata: String
    var icao: String
    var callsign: String
    var aircraft: [Aircraft]
}

struct Aircraft: Codable {
    var hex: String
    var registration: String
}

struct FleetView_Previews: PreviewProvider {
    static var previews: some View {
        FleetView()
    }
}
