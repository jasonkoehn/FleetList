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
    var fleetsize: Int
    var types: String
}

struct Airline: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: Int
    var types: [Types]
}

struct Types: Codable {
    var type: String
    var model: String
}

struct Aircraft: Codable {
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
var model = ""
var airlineTypes: [Types] = []


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
                    case "E190":
                        model = "Embraer E190"
                    case "E195":
                        model = "Embraer E195"
                    case "BCS3":
                        model = "Airbus A220-300"
                    case "B737":
                        model = "Boeing 737-700"
                    case "B738":
                        model = "Boeing 737-800"
                    case "B38M":
                        model = "Boeing 737 MAX 8"
                    default:
                        model = ""
                    }
                    airlineTypes.append(Types(type: type, model: model))
                }
                airlinesBeforeSave.append(Airline(name: airline.name, country: airline.country, website: airline.website, iata: airline.iata, icao: airline.icao, callsign: airline.callsign, fleetsize: airline.fleetsize, types: airlineTypes))
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
        if let decodedResponse = try? JSONDecoder().decode([Aircraft].self, from: data) {
            aircraftBeforeSave = decodedResponse
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

