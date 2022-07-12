//
//  AirlinesList.swift
//  Fleet List
//
//  Created by Jason Koehn on 7/11/22.
//

import SwiftUI

struct Airlines: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: Int
    var alias: String
}

var airlines = [
    Airlines(name: "Alaska Airlines", country: "United States", website: "alaskaair.com", iata: "AS", icao: "ASA", callsign: "ALASKA", fleetsize: 340, alias: "AlaskaAirlines"),
    Airlines(name: "American Airlines", country: "United States", website: "aa.com", iata: "AA", icao: "AAL", callsign: "AMERICAN", fleetsize: 915, alias: "AmericanAirlines"),
    Airlines(name: "Breeze Airways", country: "United States", website: "flybreeze.com", iata: "MX", icao: "MXY", callsign: "MOXY", fleetsize: 19, alias: "BreezeAirways"),
    Airlines(name: "Delta Air Lines", country: "United States", website: "delta.com", iata: "DL", icao: "DAL", callsign: "DELTA", fleetsize: 878, alias: "DeltaAirLines"),
    Airlines(name: "JetBlue Airways", country: "United States", website: "jetblue.com", iata: "B6", icao: "JBU", callsign: "JETBLUE", fleetsize: 285, alias: "JetBlueAirways"),
    Airlines(name: "Southwest Airlines", country: "United States", website: "southwest.com", iata: "WN", icao: "SWA", callsign: "SOUTHWEST", fleetsize: 735, alias: "SouthwestAirlines"),
    Airlines(name: "United Airlines", country: "United States", website: "united.com", iata: "UA", icao: "UAL", callsign: "UNITED", fleetsize: 843, alias: "UnitedAirlines"),
]
