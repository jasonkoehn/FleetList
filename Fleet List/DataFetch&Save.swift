//
//  DataFetch&Save.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/26/22.
//

import SwiftUI

// Data Structs
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
    var firstflight: String
    var delivery: String
    var hex: String
    var config: String
    var msn: Int
    var ln: Int
    var fn: Int
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


// Load from API Functions
func loadAirlinesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/FleetList/Airlines.json") else {
        print("Invalid URL")
        return
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([Airline].self, from: data) {
            airlinesBeforeSave = decodedResponse
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

