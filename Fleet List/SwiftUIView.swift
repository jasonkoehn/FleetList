//
//  SwiftUIView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/11/22.
//

import SwiftUI

//struct AirlineView: View {
//    @State var airlines: [AirlinesJSON] = []
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(airlines, id: \.name) { airlines in
//                    NavigationLink(destination: {FleetView(name: airlines.name, website: airlines.website, iata: airlines.iata, icao: airlines.icao, callsign: airlines.callsign, fleet_size: airlines.fleet_size, fleet_url: airlines.fleet_url, picture_url: airlines.picture_url)}) {
//                        Text(airlines.name)
//                            .font(.system(size: 25))
//                    }
//                }
//            }
//            .task {
//                await loadData()
//            }
//            .navigationTitle("Airlines")
//        }
//    }
//    func loadData() async {
//        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/Airlines.json") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode([AirlinesJSON].self, from: data) {
//                airlines = decodedResponse
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//}
//
//struct AirlinesJSON: Codable {
//    var name: String
//    var website: String
//    var iata: String
//    var icao: String
//    var callsign: String
//    var fleet_size: Int
//    var fleet_url: String
//    var picture_url: String
//}
