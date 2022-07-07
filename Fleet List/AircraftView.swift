//
//  AircraftView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AircraftView: View {
    var name: String
    var type: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var ln: Int
    var fn: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AircraftView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftView(name: "Southwest Airlines", type: "B38M", registration: "N8701L", delivery_date: "2018-02-20", hex: "A1A87E", msn: 55389, ln: 4480, fn: 8701)
    }
}
