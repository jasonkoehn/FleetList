//
//  FleetView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct FleetView: View {
    @State var aircraftBeforeSave = [Aircraft]()
    @State var modelsBeforeSave = [Models]()
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
//                    await loadAircraftFromapi()
//                    saveAircraft()
//                    loadAircraft()
//                }
//            }
        }
    }
    
//    func loadAircraft() {
//        let manager = FileManager.default
//        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//        let aircraftFileUrl = url.appendingPathComponent(alias+".plist")
//        let typesFileUrl = url.appendingPathComponent(alias+"types.plist")
//        let aircrafts = try! Data(contentsOf: aircraftFileUrl)
//        let types = try! Data(contentsOf: typesFileUrl)
//        let decoder = PropertyListDecoder()
//        let aircraftResponse = try! decoder.decode([Aircraft].self, from: aircrafts)
//        let typesResponse = try! decoder.decode([Models].self, from: types)
//        aircraft = aircraftResponse
//        models = typesResponse
//    }
    
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
    
//    func saveAircraft() {
//        let manager = FileManager.default
//        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//        let aircraftFileUrl = url.appendingPathComponent(alias+".plist")
//        let typesFileUrl = url.appendingPathComponent(alias+"types.plist")
//        manager.createFile(atPath: aircraftFileUrl.path, contents: nil, attributes: nil)
//        manager.createFile(atPath: typesFileUrl.path, contents: nil, attributes: nil)
//        let encoder = PropertyListEncoder()
//        let encodedAircraft = try! encoder.encode(airlinesBeforeSave)
//        let encodedTypes = try! encoder.encode(modelsBeforeSave)
//        try! encodedAircraft.write(to: aircraftFileUrl)
//        try! encodedTypes.write(to: typesFileUrl)
//    }
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


//struct FleetView: View {
//    @State var aircraft: [Aircraft] = []
//    @State var aircraftBeforeSave: [Aircraft] = []
//    var name: String
//    var country: String
//    var website: String
//    var iata: String
//    var icao: String
//    var callsign: String
//    var alias: String
////    @State var fleetsize = 0
//    var body: some View {
//        VStack {
//            NavigationLink(destination: {AirlineView(name: name, country: country, website: website, iata: iata, icao: icao, callsign: callsign, alias: alias, fleetsize: aircraft.count)}) {
//                VStack {
//                    Image(alias)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(4)
//                        .frame(height: 80)
//                        .padding(.horizontal, 10)
//                    HStack {
//                        Spacer()
//                        Text("IATA")
//                            .italic()
//                            .font(.subheadline)
//                        Text(iata)
//                        Spacer()
//                        Text("ICOA")
//                            .italic()
//                            .font(.subheadline)
//                        Text(icao)
//                        Spacer()
//                        Text("Callsign")
//                            .italic()
//                            .font(.subheadline)
//                        Text(callsign)
//                        Spacer()
//                    }.foregroundColor(.primary)
//                }
//            }
//            List {
//                ForEach(aircraft, id: \.hex) { aircraft in
////                    if aircraft.operater == name {
//                        NavigationLink(destination: {AircraftView(name: name, alias: alias, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, delivery_date: aircraft.delivery_date, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn)}) {
//                            HStack {
//                                HStack {
//                                    Text(aircraft.registration)
//                                        .font(.system(size: 23))
//                                    Spacer()
//                                }.frame(width: 120)
//                                Text(aircraft.type)
//                                    .font(.system(size: 15))
//                            }
//                        }
////                    }
//                }
//            }
//            .listStyle(PlainListStyle())
//            .navigationTitle(name)
//            .task {
//                loadAircraft()
//            }
//            .refreshable {
//                Task {
//                    await loadAircraftfromapi()
//                    saveAircraft()
//                    loadAircraft()
//                }
//            }
//        }
//    }
//    func loadAircraft() {
//        let manager = FileManager.default
//        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//        let fileUrl = url.appendingPathComponent(alias+".plist")
//        let data = try! Data(contentsOf: fileUrl)
//        let decoder = PropertyListDecoder()
//        let response = try! decoder.decode([Aircraft].self, from: data)
//        aircraft = response
//        print(aircraft)
//    }
//    func saveAircraft() {
//        let manager = FileManager.default
//        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
//        let fileUrl = url.appendingPathComponent(alias+".plist")
//        manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
//        let encoder = PropertyListEncoder()
//        let encodedData = try! encoder.encode(aircraftBeforeSave)
//        try! encodedData.write(to: fileUrl)
//    }
//
//    func loadAircraftfromapi() async {
//        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/"+alias+".json") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode([Aircraft].self, from: data) {
//                aircraftBeforeSave = decodedResponse
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
////    func loadAircraft() {
////        let manager = FileManager.default
////        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
////        let fileUrl = url.appendingPathComponent("aircraft.plist")
////        let data = try! Data(contentsOf: fileUrl)
////        let decoder = PropertyListDecoder()
////        let response = try! decoder.decode([Aircraft].self, from: data)
////        aircraft = response
////        print(aircraft)
////    }
//}
//
//struct Aircraft: Codable {
//    var type: String
//    var model: String
//    var registration: String
//    var delivery_date: String
//    var hex: String
//    var msn: Int
//    var ln: Int
//    var fn: Int
//}



//struct FleetView: View {
//    @State var aircraft: [Aircraft] = []
//    var name: String
//    var country: String
//    var website: String
//    var iata: String
//    var icao: String
//    var callsign: String
//    var alias: String
//    var body: some View {
//        VStack {
//            NavigationLink(destination: {AirlineView(name: name, country: country, website: website, iata: iata, icao: icao, callsign: callsign, alias: alias, fleetsize: aircraft.count)}) {
//                VStack {
//                    Image(alias)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(4)
//                        .frame(height: 80)
//                        .padding(.horizontal, 10)
//                    HStack {
//                        Spacer()
//                        Text("IATA")
//                            .italic()
//                            .font(.subheadline)
//                        Text(iata)
//                        Spacer()
//                        Text("ICOA")
//                            .italic()
//                            .font(.subheadline)
//                        Text(icao)
//                        Spacer()
//                        Text("Callsign")
//                            .italic()
//                            .font(.subheadline)
//                        Text(callsign)
//                        Spacer()
//                    }.foregroundColor(.primary)
//                }
//            }
//            List {
//                ForEach(aircraft, id: \.hex) { aircraft in
//                    NavigationLink(destination: {AircraftView(name: name, alias: alias, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, delivery_date: aircraft.delivery_date, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn)}) {
//                        HStack {
//                            HStack {
//                                Text(aircraft.registration)
//                                    .font(.system(size: 23))
//                                Spacer()
//                            }.frame(width: 120)
//                            Text(aircraft.type)
//                                .font(.system(size: 15))
//                        }
//                    }
//                }
//            }
//            .listStyle(PlainListStyle())
//            .navigationTitle(name)
//            .task {
//                await loadData()
//            }
//        }
//    }
//    func loadData() async {
//        guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/"+alias+".json") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode([Aircraft].self, from: data) {
//                aircraft = decodedResponse
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//}
