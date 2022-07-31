//
//  AirlineView.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/14/22.
//

import SwiftUI

struct AirlineView: View {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: Int
    var types: [Types] = []
    var body: some View {
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
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Website")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Link(website, destination: URL(string: "https://www." + website)!)
                        .font(.system(size: 20))
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    Text("Fleet Size")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Text("\(fleetsize)")
                        .font(.system(size: 20))
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    Text("Country")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Image(country)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Spacer()
                }
                Spacer()
            }.frame(height: 70)
            List {
                NavigationLink(destination: AllFleetView(name: name, types: types)) {
                    Text("All")
                        .font(.system(size: 20))
                        .bold()
                        .italic()
                }
                ForEach(types, id: \.type) { types in
                    NavigationLink(destination: TypesFleetView(name: name, type: types.type, model: types.model)) {
                        Text(types.model)
                            .font(.system(size: 17))
                            .italic()
                    }
                }
            }.listStyle(PlainListStyle())
                .navigationTitle(name)
        }
        
    }
}

struct AllFleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var types: [Types] = []
    var body: some View {
        List {
            ForEach(types, id: \.type) { types in
                Section(types.model) {
                    ForEach(aircraft, id: \.hex) { aircraft in
                        if aircraft.airline == name && aircraft.type == types.type {
                            NavigationLink(destination: {AircraftView(name: name, type: aircraft.type, model: types.model, registration: aircraft.registration, deliverydate: aircraft.delivery, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight)}) {
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
        .navigationTitle("Aircraft")
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
    func loadAircraft() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            let response = try! decoder.decode([Aircraft].self, from: data)
            aircraft = response
            aircraft.sort {
                $0.registration < $1.registration
            }
        } else {
            Task {
                await loadAircraftfromapi()
                saveAircraft()
                loadAircraft()
            }
        }
    }
}

struct TypesFleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var type: String
    var model: String
    var body: some View {
        List {
            ForEach(aircraft, id: \.hex) { aircraft in
                if aircraft.airline == name && aircraft.type == type {
                    NavigationLink(destination: {AircraftView(name: name, type: aircraft.type, model: model, registration: aircraft.registration, deliverydate: aircraft.delivery, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight)}) {
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
        .listStyle(PlainListStyle())
        .navigationTitle(model)
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
    func loadAircraft() {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: fileUrl) {
            let decoder = PropertyListDecoder()
            let response = try! decoder.decode([Aircraft].self, from: data)
            aircraft = response
            aircraft.sort {
                $0.registration < $1.registration
            }
        } else {
            Task {
                await loadAircraftfromapi()
                saveAircraft()
                loadAircraft()
            }
        }
    }
}
