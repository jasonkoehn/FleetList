//
//  AirlineFleetView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

struct AirlineFleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var types: [Types] = []
    var body: some View {
        VStack {
            NavigationLink(destination: {AirlineView(name: name, country: country, website: website, iata: iata, icao: icao, callsign: callsign, fleetsize: 9)}) {
                VStack {
                    Image(name)
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
                ForEach(types, id: \.type) { types in
                    Section(types.model) {
                        ForEach(aircraft, id: \.hex) { aircraft in
                            if aircraft.operater == name && aircraft.type == types.type {
                                NavigationLink(destination: {AircraftView(name: name, type: aircraft.type, model: types.model, registration: aircraft.registration, delivery_date: aircraft.delivery_date, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight)}) {
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
                loadAircraft()
            }
            .refreshable {
                Task {
                    await loadAircraftfromapi()
                    saveAircraft()
                    loadAircraft()
                }
            }
        }
    }
    func loadAircraft() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("aircraft.plist")
        let data = try! Data(contentsOf: fileUrl)
        let decoder = PropertyListDecoder()
        let response = try! decoder.decode([Aircraft].self, from: data)
        aircraft = response
        aircraft.sort {
            $0.registration < $1.registration
        }
        
    }
}
