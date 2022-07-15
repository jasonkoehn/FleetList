//
//  DataFetchSave.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/14/22.
//

import SwiftUI

struct Airline: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var alias: String
}

struct Country: Codable {
    var name: String
}

var countriesBeforeSave: [Country] = []

var airlinesBeforeSave: [Airline] = []

func saveAirlines() {
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let fileUrl = url.appendingPathComponent("airlines.plist")
    manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(airlinesBeforeSave)
    try! encodedData.write(to: fileUrl)
}

func loadAirlinesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/Airlines.json") else {
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

func loadCountriesfromapi() async {
    guard let url = URL(string: "https://jasonkoehn.github.io/AirlineData/Countries.json") else {
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

func saveCountries() {
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let fileUrl = url.appendingPathComponent("countries.plist")
    manager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(countriesBeforeSave)
    try! encodedData.write(to: fileUrl)
}
