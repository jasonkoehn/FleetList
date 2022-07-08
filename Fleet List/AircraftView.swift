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
    var model: String
    var registration: String
    var delivery_date: String
    var hex: String
    var msn: Int
    var ln: Int
    var fn: Int
    var body: some View {
        VStack {
            Text(registration)
                .font(.system(size: 50))
                .padding(30)
            Text(model)
                .font(.system(size: 35))
                .padding(.bottom)
            HStack {
                Text("Operator:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text(name)
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("Type:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text(type)
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("Delivery:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text(delivery_date)
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("Hex:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text(hex)
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("MSN:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text("\(msn)")
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("LN:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text("\(ln)")
                    .font(.system(size: 25))
                Spacer()
            }
            HStack {
                Text("FN:")
                    .font(.system(size: 25))
                    .italic()
                Spacer()
                Text("\(fn)")
                    .font(.system(size: 25))
                Spacer()
            }
            Spacer()
        }
    }
}

struct AircraftView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AircraftView(name: "Southwest Airlines", type: "B38M", model: "Boeing 737 Max 8", registration: "N8701L", delivery_date: "2018-02-20", hex: "A1A87E", msn: 55389, ln: 4480, fn: 8701)
        }
    }
}
