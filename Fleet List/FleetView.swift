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
    @State var airlineurl: String
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
                ForEach(results, id: \.hex) { item in
                    NavigationLink(destination: {Text(item.registration)}) {
                        HStack {
                            Text(item.registration)
                                .font(.system(size: 25))
                            Text(item.type)
                        }
                    }
                }
            }
            .navigationTitle(airlineName)
            .task {
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: airlineurl) else {
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
    var type: String
}

struct FleetView_Previews: PreviewProvider {
    static var previews: some View {
        FleetView(airlineurl: "")
    }
}
