//
//  DataFetch&Save.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

// Data Structs
struct AirlineAPI: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: String
    var types: String
    var summary: String
}

struct Airline: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var summary: String
    var fleetsize: String
    var types: [Types]
}

struct Types: Codable {
    var type: String
    var model: String
}

struct AircraftAPI: Codable {
    var airline: String
    var type: String
    var registration: String
    var country: String
    var firstflight: String
    var delivery: String
    var hex: String
    var config: String
    var msn: String
    var ln: String
    var fn: String
    var site: String
    var remarks: String
}

struct Aircraft: Codable {
    var airline: String
    var type: String
    var model: String
    var registration: String
    var country: String
    var firstflight: String
    var delivery: String
    var hex: String
    var config: String
    var msn: String
    var ln: String
    var fn: String
    var site: String
    var remarks: String
}

struct Utilities: Codable {
    var countries: [Country]
    var letters: [Letter]
}

struct Country: Codable {
    var name: String
}

struct Letter: Codable {
    var letter: String
}


// Data Arrays
var airlinesBeforeSave: [Airline] = []
var aircraftBeforeSave: [Aircraft] = []
var models = ""
var airlineTypes: [Types] = []
var model = ""


// Load from API Functions
func loadAirlinesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/FleetList/Airlines.json") else {
        print("Invalid URL")
        return
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([AirlineAPI].self, from: data) {
            airlinesBeforeSave = []
            for airline in decodedResponse {
                let types = airline.types.components(separatedBy: ",")
                for type in types {
                    switch type {
                    case "A20N":
                        models = "Airbus A320neo"
                    case "A21N":
                        models = "Airbus A321neo"
                    case "A318":
                        models = "Airbus A318"
                    case "A319":
                        models = "Airbus A319"
                    case "A320":
                        models = "Airbus A320"
                    case "A332":
                        models = "Airbus A330-200"
                    case "A333":
                        models = "Airbus A330-300"
                    case "A338":
                        models = "Airbus A330-800"
                    case "A339":
                        models = "Airbus A330-900"
                    case "A343":
                        models = "Airbus A340-300"
                    case "A346":
                        models = "Airbus A340-600"
                    case "A359":
                        models = "Airbus A350-900"
                    case "A35K":
                        models = "Airbus A350-1000"
                    case "A388":
                        models = "Airbus A380-800"
                    case "B736":
                        models = "Boeing 737-600"
                    case "B737":
                        models = "Boeing 737-700"
                    case "B738":
                        models = "Boeing 737-800"
                    case "B739":
                        models = "Boeing 737-900"
                    case "B37M":
                        models = "Boeing 737 MAX 8"
                    case "B38M":
                        models = "Boeing 737 MAX 8"
                    case "B39M":
                        models = "Boeing 737 MAX 9"
                    case "B78X":
                        models = "Boeing 787-10 Dreamliner"
                    case "E135":
                        models = "Embraer ERJ135"
                    case "E145":
                        models = "Embraer ERJ145"
                    case "E190":
                        models = "Embraer E190"
                    case "E195":
                        models = "Embraer E195"
                    case "BCS1":
                        models = "Airbus A220-100"
                    case "BCS3":
                        models = "Airbus A220-300"
                    default:
                        models = ""
                    }
                    airlineTypes.append(Types(type: type, model: models))
                }
                airlinesBeforeSave.append(Airline(name: airline.name, country: airline.country, website: airline.website, iata: airline.iata, icao: airline.icao, callsign: airline.callsign, summary: airline.summary, fleetsize: airline.fleetsize, types: airlineTypes))
                airlineTypes = []
            }
        }
    } catch {
        print("Invalid data")
        
    }
}

func loadAircraftfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/FleetList/Aircraft.json") else {
        print("Invalid URL")
        return
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([AircraftAPI].self, from: data) {
            aircraftBeforeSave = []
            for aircraft in decodedResponse {
                switch aircraft.type {
                case "A20N":
                    model = "Airbus A320neo"
                case "A21N":
                    model = "Airbus A321neo"
                case "A318":
                    model = "Airbus A318"
                case "A319":
                    model = "Airbus A319"
                case "A320":
                    model = "Airbus A320"
                case "A332":
                    model = "Airbus A330-200"
                case "A333":
                    model = "Airbus A330-300"
                case "A338":
                    model = "Airbus A330-800"
                case "A339":
                    model = "Airbus A330-900"
                case "A343":
                    model = "Airbus A340-300"
                case "A346":
                    model = "Airbus A340-600"
                case "A359":
                    model = "Airbus A350-900"
                case "A35K":
                    model = "Airbus A350-1000"
                case "A388":
                    model = "Airbus A380-800"
                case "B736":
                    model = "Boeing 737-600"
                case "B737":
                    model = "Boeing 737-700"
                case "B738":
                    model = "Boeing 737-800"
                case "B739":
                    model = "Boeing 737-900"
                case "B37M":
                    model = "Boeing 737 MAX 8"
                case "B38M":
                    model = "Boeing 737 MAX 8"
                case "B39M":
                    model = "Boeing 737 MAX 9"
                case "B78X":
                    model = "Boeing 787-10 Dreamliner"
                case "E135":
                    model = "Embraer ERJ135"
                case "E145":
                    model = "Embraer ERJ145"
                case "E190":
                    model = "Embraer E190"
                case "E195":
                    model = "Embraer E195"
                case "BCS1":
                    model = "Airbus A220-100"
                case "BCS3":
                    model = "Airbus A220-300"
                default:
                    model = ""
                }
                aircraftBeforeSave.append(Aircraft(airline: aircraft.airline, type: aircraft.type, model: model, registration: aircraft.registration, country: aircraft.country, firstflight: aircraft.firstflight, delivery: aircraft.delivery, hex: aircraft.hex, config: aircraft.config, msn: aircraft.msn, ln: aircraft.msn, fn: aircraft.fn, site: aircraft.site, remarks: aircraft.remarks))
            }
        }
    } catch {
        print("Invalid data")
    }
}

func loadUtilitiesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/FleetList/Utilities.json") else {
        print("Invalid URL")
        return
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode(Utilities.self, from: data) {
            let manager = FileManager.default
            let encoder = PropertyListEncoder()
            guard let file = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            
            let countriesUrl = file.appendingPathComponent("countries.plist")
            manager.createFile(atPath: countriesUrl.path, contents: nil, attributes: nil)
            let encodedCountries = try! encoder.encode(decodedResponse.countries)
            try! encodedCountries.write(to: countriesUrl)
            
            let lettersUrl = file.appendingPathComponent("letters.plist")
            manager.createFile(atPath: lettersUrl.path, contents: nil, attributes: nil)
            let encodedLetters = try! encoder.encode(decodedResponse.letters)
            try! encodedLetters.write(to: lettersUrl)
        }
    } catch {
        print("Invalid data")
    }
}

// Save to FileManangerFunctions
func saveAirlines() {
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let fileUrl = url.appendingPathComponent("airlines.plist")
    manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(airlinesBeforeSave)
    try! encodedData.write(to: fileUrl)
}

func saveAircraft() {
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let fileUrl = url.appendingPathComponent("aircraft.plist")
    manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(aircraftBeforeSave)
    try! encodedData.write(to: fileUrl)
}

//Button(action: {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    guard let encoded = try? encoder.encode(airlines) else {
//        print("Failed to encode order")
//        return
//    }
//    print(String(data: encoded, encoding: .utf8)!)
//}){
//    Text("Send")
//}

//Button(action: {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//    guard let encoded = try? encoder.encode(aircraft) else {
//        print("Failed to encode order")
//        return
//    }
//    print(String(data: encoded, encoding: .utf8)!)
//}){
//    Text("Send")
//}

