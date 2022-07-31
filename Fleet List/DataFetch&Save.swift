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
}

struct Country: Codable {
    var name: String
}


// Data Arrays
var airlinesBeforeSave: [Airline] = []
var countriesBeforeSave: [Country] = []
var aircraftBeforeSave: [Aircraft] = []
var alphabet: [String] = ["A", "B", "D", "F", "H", "J", "L", "P", "S", "U", "W"]
var leftovers = ["C", "E", "G", "I", "K", "M", "N", "O", "Q", "R", "T", "V", "X", "Y", "Z"]


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

func loadCountriesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/FleetList/Countries.json") else {
        print("Invalid URL")
        return
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([Country].self, from: data) {
            countriesBeforeSave = decodedResponse
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

func saveCountries() {
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let fileUrl = url.appendingPathComponent("countries.plist")
    manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(countriesBeforeSave)
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

