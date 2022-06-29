//
//  AircraftView.swift
//  Fleet List
//
//  Created by Jason Koehn on 6/29/22.
//

import SwiftUI

struct AircraftView: View {
    var type: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var fn: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AircraftView_Previews: PreviewProvider {
    static var previews: some View {
        AircraftView(type: "", registration: "", delivery_date: "", hex: "", msn: 0, fn: 0)
    }
}
