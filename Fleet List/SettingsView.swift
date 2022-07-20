//
//  SettingsView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/14/22.
//

import SwiftUI

//struct SettingsView: View {
//    var body: some View {
//        Toggle(sortByCountry)
//    }
//}
//
//
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}

struct FleetView: View {
    @State var aircraft = [Aircraft]()
    @State var models = [Models]()
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var alias: String
    var body: some View {
        VStack {
            NavigationLink(destination: {AirlineView(name: name, country: country, website: website, iata: iata, icao: icao, callsign: callsign, alias: alias, fleetsize: aircraft.count)}) {
                VStack {
                    Image(alias)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(4)
                        .frame(height: 80)
                        .padding(.horizontal, 10)
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
                    }.foregroundColor(.primary)
                }
            }
            List {
                ForEach(models, id: \.type) { type in
                    Section(type.model) {
                        ForEach(aircraft, id: \.hex) { aircraft in
                            if aircraft.type == type.type {
                                NavigationLink(destination: {AircraftView(name: name, alias: alias, type: aircraft.type, model: type.model, registration: aircraft.registration, delivery_date: aircraft.delivery_date, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn)}) {
                                    HStack {
                                        HStack {
                                            Text(aircraft.registration)
                                                .font(.system(size: 23))
                                            Spacer()
                                        }.frame(width: 120)
                                        Text(aircraft.type)
                                            .font(.system(size: 15))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle(name)
            .task {
                await loadAircraft()
            }
            //            .refreshable {
            //                Task {
            //                    await loadAircraftfromapi()
            //                    saveAircraft()
            //                    loadAircraft()
            //                }
            //            }
        }
    }
    func loadAircraft() async {
        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/"+alias+".json") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                aircraft = decodedResponse.aircraft
                models = decodedResponse.models
                print(aircraft)
                print(models)
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var models: [Models]
    var aircraft: [Aircraft]
}

struct Models: Codable {
    var type: String
    var model: String
}

struct Aircraft: Codable {
    var type: String
    var model: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var ln: Int
    var fn: Int
}
