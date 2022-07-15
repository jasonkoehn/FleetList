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
    var alias: String
    var fleetsize: Int
    var body: some View {
        VStack {
            Image(alias)
                .resizable()
                .aspectRatio(contentMode: .fit)
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
            Text(website)
            Text("\(fleetsize)")
        }
        
    }
}
