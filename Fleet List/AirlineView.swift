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
    var fleetsize: Int
    var types: [Types] = []
    var body: some View {
        VStack {
            Image(name)
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
            }
            List {
                Text("All")
                ForEach(types, id: \.type) { types in
                    Text(types.model)
                }
            }.listStyle(PlainListStyle())
        }
        .navigationTitle(name)
    }
}

struct AirlineView_Previews: PreviewProvider {
    static var previews: some View {
        AirlineView(name: "Southwest Airlines", country: "United States", website: "southwest.com", iata: "WN", icao: "SWA", callsign: "SOUTHWEST", fleetsize: 735)
    }
}
